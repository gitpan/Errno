use ExtUtils::MakeMaker;
use Config;
use IO::File;
use strict;

my @incpath = (split(/\s+/, $Config{usrinc}), split(/\s+/ ,$Config{locincpth}));
my %err = ();

sub process_file {
    my($mm,$file) = @_;

    return unless defined $file;

    my $path = undef;
    my $dir;
    foreach $dir (@incpath) {
	my $tmp = $mm->catfile($dir,$file);
	next unless -r $tmp;
	$path = $tmp;
	last;
    }

    unless(defined $path) {
	warn "Cannot find '$file'";
	return;
    }

    my $fp = new IO::File $path,"r" or return;
    while(<$fp>) {
	s#/\*.*(\*/|$)##;

	process_file($mm,$1)
		if /^#\s*include\s*[<"]([^>"]+)[>"]/;

	$err{$1} = $2
	    if /^#\s*define\s+(E\w+)\s+(\d+|E\w+)\s*$/;
   }
   $fp->close;
}

sub write_errno_pm {
    my $err;


    foreach $err (keys %err) {
        while($err{$err} =~ /\D/) {
	    if(exists $err{$err{$err}}) {
	        $err{$err} = $err{$err{$err}};
	    }
	    else {
	        delete $err{$err};
	        last
	    }
        }
    }

    my $fp = new IO::File "Errno.pm","w" or
	    die "Cannot create 'Errno.pm': $!";

    print "Writing a custom Errno.pm ...\n";
    $fp->print(<<"EDQ");
#
# This file is auto-generated. ***ANY*** chnages here will be lost
#

package Errno;
use vars qw(\@EXPORT \@ISA \$VERSION);
use Exporter ();
use Config;

\$Config{'myarchname'} eq "$Config{'myarchname'}" or
	die "Errno architecture does not match executable architecture";

\$VERSION = "1.00";
\@ISA = qw(Exporter);

EDQ

    my $len = 0;
    my @err = sort { $err{$a} <=> $err{$b} } keys %err;
    map { $len = length if length > $len } @err;

    my $export = join(" ",@err);
    $export =~ s/(.{50,65})\s/$1\n\t/g;

    $fp->print("\@EXPORT_OK = qw(\n\t",$export,"\n);\n\n");

    foreach $err (@err) {
        $fp->printf("sub %-${len}s\t() { %5d }\n",$err,$err{$err});
    }

    $fp->print("\n1;\n");

    $fp->close;
}

sub MY::post_initialize
{
 my ($self) = @_;

 process_file($self, "errno.h");

 write_errno_pm();

 $self->{PM}->{'Errno.pm'} = $self->catfile('$(INST_ARCHLIBDIR)','Errno.pm');

 "";
}

WriteMakefile(
	NAME	=> 'Errno',
	VERSION	=> '1.00',
	'dist'	=> {
			COMPRESS => 'gzip -9f',
			SUFFIX   => '.gz', 
			DIST_DEFAULT => 'all tardist',
		   },
	'clean'	=> {FILES => '*.b[ac]k'}
);
