use ExtUtils::MakeMaker;

WriteMakefile(
	NAME	=> 'Errno',
	PL_FILES => {},
	VERSION_FROM => 'errno.pl',
	'clean' => { FILES => 'errno_pm' },
	'dist'	=> {
			COMPRESS => 'gzip -9f',
			SUFFIX   => '.gz', 
			DIST_DEFAULT => 'dummy_errno tardist',
		   },
);

sub MY::libscan {
    my($self,$path) = @_;
    return '' if $path =~ /\.pl$/;
}

sub MY::post_initialize {
    my $self = shift;
    $self->{PM}->{'Errno.pm'} = $self->catfile('$(INST_ARCHLIBDIR)','Errno.pm');
    "";
}

sub MY::processPL {
    <<'ESQ';
Errno.pm : errno.pl errno_pm
	$(PERL) errno.pl > Errno.pm

errno_pm :
	touch errno_pm

dummy_errno :
	echo 'packge Errno;' > Errno.pm
	echo '$$VERSION = "$(VERSION)";' >>Errno.pm
	echo "0;" >>Errno.pm
	rm -f errno_pm

ESQ
}
