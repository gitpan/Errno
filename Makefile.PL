use ExtUtils::MakeMaker;

WriteMakefile(
	NAME	=> 'Errno',
	PL_FILES => {},
	clean => {FILES => 'Errno.pm'},
	VERSION_FROM => 'errno.pl'
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
    '
Errno.pm : errno.pl
	$(PERL) errno.pl > Errno.pm

'
}
