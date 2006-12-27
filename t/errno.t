#!./perl

BEGIN {
    unless(grep /blib/, @INC) {
	chdir 't' if -d 't';
	if ($^O eq 'MacOS') { 
	    @INC = qw(: ::lib ::macos:lib); 
	} else { 
	    @INC = '../lib'; 
	}
    }
}
my $test = 1;
sub ok { printf "%sok %d\n", (shift() ? "" : "not "), $test++; }
 
use Errno;
print "1..", 9 + keys(%!), "\n";

ok( @Errno::EXPORT_OK > 0);
die unless @Errno::EXPORT_OK;

$err = $Errno::EXPORT_OK[0];
$num = &{"Errno::$err"};

$! = $num;
# Some systems have ESUCCESS 0, that's why exists instead of boolean.
ok( exists $!{$err} );

$! = 0;
ok( ! $!{$err});

$s1 = join(",",sort keys(%!));
$s2 = join(",",sort @Errno::EXPORT_OK);

if($s1 ne $s2) {
    my @s1 = keys(%!);
    my @s2 = @Errno::EXPORT_OK;
    my(%s1,%s2);
    @s1{@s1} = ();
    @s2{@s2} = ();
    delete @s2{@s1};
    delete @s1{@s2};
    print "# These are only in \%!\n";
    print "# ",join(" ",map { "'$_'" } keys %s1),"\n";
    print "# These are only in \@EXPORT_OK\n";
    print "# ",join(" ",map { "'$_'" } keys %s2),"\n";
}
ok( $s1 eq $s2);

my @enames = keys(%!);
foreach my $name (@enames) {
  $! = &{"Errno::$name"};
  ok($!{$name}, $name);
}

ok( $!{STORE} eq "");

eval { $!{FOO} = 1 };
ok( $@ );

sub Errno::foo ($) { }
ok( $!{foo} eq "");

ok( !exists $!{STORE});
ok( !exists $!{foo});

exit 0;
