use ExtUtils::MakeMaker;

@VMS = ($^O eq 'VMS') ? (MAN3PODS => ' ') : ();

WriteMakefile(
    NAME	 => 'Errno',
    VERSION_FROM => 'Errno_pm.PL',
    PL_FILES	 => {'Errno_pm.PL'=>'Errno.pm'},
    PM		 => {'Errno.pm' => '$(INST_LIBDIR)/Errno.pm'},
    'clean'	 => {FILES => 'Errno.pm'},
    'dist'	 => {
	COMPRESS => 'gzip -9f',
	SUFFIX   => '.gz', 
	DIST_DEFAULT => 'd/Errno.pm tardist',
    },
    @VMS,
);

sub MY::postamble {
q!

d/Errno.pm : Makefile
	echo '#This is a dummy file so CPAN will find a VERSION' > d/Errno.pm
	echo 'package Errno;' >> d/Errno.pm
	echo '$$VERSION = "$(VERSION)";' >>d/Errno.pm
	echo '#This is to make sure require will return an error' >>d/Errno.pm
	echo "0;" >>d/Errno.pm

!
}
