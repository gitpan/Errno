#!perl
use ExtUtils::MakeMaker;
use Config;
use strict;

my $VERSION = "1.02";

my @incpath = (split(/\s+/, $Config{usrinc}), split(/\s+/ ,$Config{locincpth}));
my %err = ();
my %done = ();

sub process_file {
    my($file) = @_;

    return unless defined $file;

    my $path = undef;
    my $dir;
    foreach $dir (@incpath) {
	my $tmp = MM->catfile($dir,$file);
	next unless -r $tmp;
	$path = $tmp;
	last;
    }

    return if exists $done{$path};
    $done{$path} = 1;

    unless(defined $path) {
	warn "Cannot find '$file'";
	return;
    }

    local *FH;
    open(FH,"< $path") or return;
    while(<FH>) {
	s#/\*.*(\*/|$)##;

	process_file($1)
		if /^#\s*include\s*[<"]([^>"]+)[>"]/;

	$err{$1} = 1
	    if /^#\s*define\s+(E\w+)\s+/;
   }
   close(FH);
}

sub write_errno_pm {
    my $err;

    # create the CPP input

    open(CPPI,"> errno.i") or
	die "Cannot open errno.i";

    print CPPI "#include <errno.h>\n";

    foreach $err (keys %err) {
	print CPPI '"',$err,'" [[',$err,']]',"\n";
    }

    close(CPPI);

    # invoke CPP and read the output

    open(CPPO,"$Config{cppstdin} $Config{cppflags} $Config{cppminus}  <errno.i |") or
	die "Cannot exec $Config{cppstdin}";

    %err = ();

    while(<CPPO>) {
	my($name,$expr);
	next unless ($name, $expr) = /"(.*?)"\s*\[\[\s*(.*?)\s*\]\]/;
	next if $name eq $expr;
	$err{$name} = eval $expr;
    }
    close(CPPO);

    # Write Errno.pm

    open(OUT,"> Errno.pm") or
	    die "Cannot create 'Errno.pm': $!";

    print "Writing a custom Errno.pm ...\n";

    select OUT;
    print <<"EDQ";
#
# This file is auto-generated. ***ANY*** changes here will be lost
#

package Errno;
use vars qw(\@EXPORT_OK \%EXPORT_TAGS \@ISA \$VERSION \%errno \$AUTOLOAD);
use Exporter ();
use Tie::Hash;
use Config;
use strict;

\$Config{'myarchname'} eq "$Config{'myarchname'}" or
	die "Errno architecture ($Config{'myarchname'}) does not match executable architecture (\$Config{'myarchname'})";

\$VERSION = "$VERSION";
\@ISA = qw(Exporter Tie::StdHash);

\%errno = (
EDQ
   
    my $len = 0;
    my @err = sort { $err{$a} <=> $err{$b} } keys %err;
    map { $len = length if length > $len } @err;

#    my $export = join(" ",@err);
#    $export =~ s/(.{50,65})\s/$1\n\t/g;
#
#    print "\@EXPORT_OK = qw(\n\t",$export,"\n);\n\n";
#

    foreach $err (@err) {
        printf "\t%-${len}s => %5d,\n",$err,$err{$err};
    }
    print <<'ESQ';
);
@EXPORT_OK = keys %errno;

%EXPORT_TAGS = (
    POSIX => [qw(
ESQ

    my $k = join(" ", grep { exists $err{$_} } 
	qw(E2BIG EACCES EADDRINUSE EADDRNOTAVAIL EAFNOSUPPORT
	EAGAIN EALREADY EBADF EBUSY ECHILD ECONNABORTED
	ECONNREFUSED ECONNRESET EDEADLK EDESTADDRREQ EDOM EDQUOT
	EEXIST EFAULT EFBIG EHOSTDOWN EHOSTUNREACH EINPROGRESS
	EINTR EINVAL EIO EISCONN EISDIR ELOOP EMFILE EMLINK
	EMSGSIZE ENAMETOOLONG ENETDOWN ENETRESET ENETUNREACH
	ENFILE ENOBUFS ENODEV ENOENT ENOEXEC ENOLCK ENOMEM
	ENOPROTOOPT ENOSPC ENOSYS ENOTBLK ENOTCONN ENOTDIR
	ENOTEMPTY ENOTSOCK ENOTTY ENXIO EOPNOTSUPP EPERM
	EPFNOSUPPORT EPIPE EPROCLIM EPROTONOSUPPORT EPROTOTYPE
	ERANGE EREMOTE ERESTART EROFS ESHUTDOWN ESOCKTNOSUPPORT
	ESPIPE ESRCH ESTALE ETIMEDOUT ETOOMANYREFS ETXTBSY
	EUSERS EWOULDBLOCK EXDEV));

    $k =~ s/(.{50,70})\s/$1\n\t/g;
    print "\t",$k,"\n    )]\n);\n\n";

#    foreach $err (@err) {
#        printf "sub %-${len}s\t() { %5d }\n",$err,$err{$err};
#    }

    print <<'ESQ';

sub AUTOLOAD {
    my($constname);
    ($constname = $AUTOLOAD) =~ s/.*:://;

    unless(exists $errno{$constname}) {
	require Carp;
	Carp::croak("Your vendor has not defined errno $constname, used");
    }

    eval "sub $constname () { $errno{$constname} }";

    goto &$AUTOLOAD;
}

sub TIEHASH { bless \%errno } 

sub FETCH {
    my ($self, $errname) = @_;
    if (exists $self->{$errname} ) {
        return $! == $self->{$errname};
    }
    require Carp;
    Carp::confess("No errno $errname");
} 

sub STORE {
    require Carp;
    Carp::confess "ERRNO hash is read only!";
}

sub unimport { untie(%!)  }

sub import { 
    my $spec;
    tie %!,     __PACKAGE__;
    foreach $spec (@_) {
        if($spec eq ':POSIX') {
	    my $err;
	    foreach $err (@{$EXPORT_TAGS{POSIX}}) {
		eval "sub $err () { $errno{$err} }";
	    }
	}
	elsif($spec =~ m:^/(.*)/$:) {
	    my $pat = $1;
	    my $err;
	    foreach $err (@EXPORT_OK) {
		eval "sub $spec () { $errno{$spec} }"
		    if $err =~ /\Q$pat\E/;
		
	    }
	}
	elsif(exists $errno{$spec} && !defined(&{$spec})) {
	    eval "sub $spec () { $errno{$spec} }";
	}
    }
    $_[0]->export_to_level(1, @_);
}

*DELETE = *CLEAR = \&STORE;

tie %!,     __PACKAGE__;

1;
__END__

=head1 NAME

Errno - System errno constants

=head1 SYNOPSIS

    use Errno qw(EINTR EIO :POSIX);

=head1 DESCRIPTION

C<Errno> defines and conditionally exports all the error constants
defined in your system C<errno.h> include file. It has a single export
tag, C<:POSIX>, which will export all POSIX defined error numbers.

C<Errno> also makes C<%!> magic such that each element of C<%!> has a non-zero
value only if C<$!> is set to that value, eg

    use Errno;
    
    unless (open(FH, "/fangorn/spouse")) {
        if ($!{ENOENT}) {
            warn "Get a wife!\n";
        } else {
            warn "This path is barred: $!";
        } 
    } 

=head1 AUTHOR

Graham Barr <gbarr@pobox.com>

=head1 COPYRIGHT

Copyright (c) 1997-8 Graham Barr. All rights reserved.
This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

ESQ

    select STDOUT;
    close(OUT);
}

#sub MY::post_initialize {
#    my ($self) = @_;

    process_file("errno.h");

    write_errno_pm();

#    $self->{PM}->{'Errno.pm'} = $self->catfile('$(INST_ARCHLIBDIR)','Errno.pm');

 #   "";
#}

WriteMakefile(
	NAME	=> 'Errno',
	VERSION	=> $VERSION,
	'dist'	=> {
			COMPRESS => 'gzip -9f',
			SUFFIX   => '.gz', 
		   },
	'clean'	=> {FILES => '*.b[ac]k'}
);
