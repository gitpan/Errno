#
# This file is auto-generated. ***ANY*** changes here will be lost
#

package Errno;
use vars qw(@EXPORT_OK %EXPORT_TAGS @ISA $VERSION %errno $AUTOLOAD);
use Exporter ();
use Tie::Hash;
use Config;
use strict;

$Config{'myarchname'} eq "i586-linux" or
	die "Errno architecture (i586-linux) does not match executable architecture ($Config{'myarchname'})";

$VERSION = "1.02";
@ISA = qw(Exporter Tie::StdHash);

%errno = (
	EPERM           =>     1,
	ENOENT          =>     2,
	ESRCH           =>     3,
	EINTR           =>     4,
	EIO             =>     5,
	ENXIO           =>     6,
	E2BIG           =>     7,
	ENOEXEC         =>     8,
	EBADF           =>     9,
	ECHILD          =>    10,
	EWOULDBLOCK     =>    11,
	EAGAIN          =>    11,
	ENOMEM          =>    12,
	EACCES          =>    13,
	EFAULT          =>    14,
	ENOTBLK         =>    15,
	EBUSY           =>    16,
	EEXIST          =>    17,
	EXDEV           =>    18,
	ENODEV          =>    19,
	ENOTDIR         =>    20,
	EISDIR          =>    21,
	EINVAL          =>    22,
	ENFILE          =>    23,
	EMFILE          =>    24,
	ENOTTY          =>    25,
	ETXTBSY         =>    26,
	EFBIG           =>    27,
	ENOSPC          =>    28,
	ESPIPE          =>    29,
	EROFS           =>    30,
	EMLINK          =>    31,
	EPIPE           =>    32,
	EDOM            =>    33,
	ERANGE          =>    34,
	EDEADLK         =>    35,
	EDEADLOCK       =>    35,
	ENAMETOOLONG    =>    36,
	ENOLCK          =>    37,
	ENOSYS          =>    38,
	ENOTEMPTY       =>    39,
	ELOOP           =>    40,
	ENOMSG          =>    42,
	EIDRM           =>    43,
	ECHRNG          =>    44,
	EL2NSYNC        =>    45,
	EL3HLT          =>    46,
	EL3RST          =>    47,
	ELNRNG          =>    48,
	EUNATCH         =>    49,
	ENOCSI          =>    50,
	EL2HLT          =>    51,
	EBADE           =>    52,
	EBADR           =>    53,
	EXFULL          =>    54,
	ENOANO          =>    55,
	EBADRQC         =>    56,
	EBADSLT         =>    57,
	EBFONT          =>    59,
	ENOSTR          =>    60,
	ENODATA         =>    61,
	ETIME           =>    62,
	ENOSR           =>    63,
	ENONET          =>    64,
	ENOPKG          =>    65,
	EREMOTE         =>    66,
	ENOLINK         =>    67,
	EADV            =>    68,
	ESRMNT          =>    69,
	ECOMM           =>    70,
	EPROTO          =>    71,
	EMULTIHOP       =>    72,
	EDOTDOT         =>    73,
	EBADMSG         =>    74,
	EOVERFLOW       =>    75,
	ENOTUNIQ        =>    76,
	EBADFD          =>    77,
	EREMCHG         =>    78,
	ELIBACC         =>    79,
	ELIBBAD         =>    80,
	ELIBSCN         =>    81,
	ELIBMAX         =>    82,
	ELIBEXEC        =>    83,
	EILSEQ          =>    84,
	ERESTART        =>    85,
	ESTRPIPE        =>    86,
	EUSERS          =>    87,
	ENOTSOCK        =>    88,
	EDESTADDRREQ    =>    89,
	EMSGSIZE        =>    90,
	EPROTOTYPE      =>    91,
	ENOPROTOOPT     =>    92,
	EPROTONOSUPPORT =>    93,
	ESOCKTNOSUPPORT =>    94,
	EOPNOTSUPP      =>    95,
	EPFNOSUPPORT    =>    96,
	EAFNOSUPPORT    =>    97,
	EADDRINUSE      =>    98,
	EADDRNOTAVAIL   =>    99,
	ENETDOWN        =>   100,
	ENETUNREACH     =>   101,
	ENETRESET       =>   102,
	ECONNABORTED    =>   103,
	ECONNRESET      =>   104,
	ENOBUFS         =>   105,
	EISCONN         =>   106,
	ENOTCONN        =>   107,
	ESHUTDOWN       =>   108,
	ETOOMANYREFS    =>   109,
	ETIMEDOUT       =>   110,
	ECONNREFUSED    =>   111,
	EHOSTDOWN       =>   112,
	EHOSTUNREACH    =>   113,
	EALREADY        =>   114,
	EINPROGRESS     =>   115,
	ESTALE          =>   116,
	EUCLEAN         =>   117,
	ENOTNAM         =>   118,
	ENAVAIL         =>   119,
	EISNAM          =>   120,
	EREMOTEIO       =>   121,
	EDQUOT          =>   122,
);
@EXPORT_OK = keys %errno;

%EXPORT_TAGS = (
    POSIX => [qw(
	E2BIG EACCES EADDRINUSE EADDRNOTAVAIL EAFNOSUPPORT EAGAIN EALREADY
	EBADF EBUSY ECHILD ECONNABORTED ECONNREFUSED ECONNRESET EDEADLK
	EDESTADDRREQ EDOM EDQUOT EEXIST EFAULT EFBIG EHOSTDOWN EHOSTUNREACH
	EINPROGRESS EINTR EINVAL EIO EISCONN EISDIR ELOOP EMFILE EMLINK
	EMSGSIZE ENAMETOOLONG ENETDOWN ENETRESET ENETUNREACH ENFILE ENOBUFS
	ENODEV ENOENT ENOEXEC ENOLCK ENOMEM ENOPROTOOPT ENOSPC ENOSYS ENOTBLK
	ENOTCONN ENOTDIR ENOTEMPTY ENOTSOCK ENOTTY ENXIO EOPNOTSUPP EPERM
	EPFNOSUPPORT EPIPE EPROTONOSUPPORT EPROTOTYPE ERANGE EREMOTE ERESTART
	EROFS ESHUTDOWN ESOCKTNOSUPPORT ESPIPE ESRCH ESTALE ETIMEDOUT
	ETOOMANYREFS ETXTBSY EUSERS EWOULDBLOCK EXDEV
    )]
);


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

