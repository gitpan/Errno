use Errno qw(:POSIX);

print "1..3\n";

$! = E2BIG;

print "not " unless $! == E2BIG;
print "ok 1\n";

print "not " unless $!{E2BIG};
print "ok 2\n";

print "not " if $!{EBADF};
print "ok 3\n";


