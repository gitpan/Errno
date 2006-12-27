use ExtUtils::MakeMaker;

@MAN3PODS = ($^O eq 'VMS' or grep { /PERL_CORE=1/ } @ARGV) ? (MAN3PODS => {}) : ();

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
    @MAN3PODS,
);

sub MY::postamble {
    my $TARG = MM->catfile('d','Errno.pm');
qq!$TARG : Makefile
	echo '#This is a dummy file so CPAN will find a VERSION' > $TARG
	echo 'package Errno;' >> $TARG
	echo '\$\$VERSION = "\$(VERSION)";' >>$TARG
	echo '#This is to make sure require will return an error' >>$TARG
	echo '0;' >>$TARG

!
}
