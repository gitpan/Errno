#!./perl

BEGIN {
    unless(grep /blib/, @INC) {
	chdir 't' if -d 't';
	@INC = '../lib' if -d '../lib';
    }
}

use Errno;

print "1..4\n";

print "not " unless @Errno::EXPORT_OK;
print "ok 1\n";
die unless @Errno::EXPORT_OK;

$err = $Errno::EXPORT_OK[0];
$num = &{"Errno::$err"};

print "not " unless &{"Errno::$err"} == $num;
print "ok 2\n";

$! = $num;
print "not " unless $!{$err};
print "ok 3\n";

$! = 0;
print "not " if $!{$err};
print "ok 4\n";
