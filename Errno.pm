#
# This file is auto-generated. ***ANY*** chnages here will be lost
#

package Errno;
use vars qw(@EXPORT @ISA $VERSION);
use Exporter ();
use Config;

$Config{'myarchname'} eq "sun4os5-solaris" or
	die "Errno architecture does not match executable architecture";

$VERSION = "1.00";
@ISA = qw(Exporter);

@EXPORT_OK = qw(
	EPERM ENOENT ESRCH EINTR EIO ENXIO E2BIG ENOEXEC EBADF ECHILD
	EWOULDBLOCK EAGAIN ENOMEM EACCES EFAULT ENOTBLK EBUSY EEXIST
	EXDEV ENODEV ENOTDIR EISDIR EINVAL ENFILE EMFILE ENOTTY ETXTBSY
	EFBIG ENOSPC ESPIPE EROFS EMLINK EPIPE EDOM ERANGE ENOMSG EIDRM
	ECHRNG EL2NSYNC EL3HLT EL3RST ELNRNG EUNATCH ENOCSI EL2HLT
	EDEADLK ENOLCK ECANCELED ENOTSUP EDQUOT EBADE EBADR EXFULL ENOANO
	EBADRQC EBADSLT EDEADLOCK EBFONT ENOSTR ENODATA ETIME ENOSR
	ENONET ENOPKG EREMOTE ENOLINK EADV ESRMNT ECOMM EPROTO EMULTIHOP
	EBADMSG ENAMETOOLONG EOVERFLOW ENOTUNIQ EBADFD EREMCHG ELIBACC
	ELIBBAD ELIBSCN ELIBMAX ELIBEXEC EILSEQ ENOSYS ELOOP ERESTART
	ESTRPIPE ENOTEMPTY EUSERS ENOTSOCK EDESTADDRREQ EMSGSIZE
	EPROTOTYPE ENOPROTOOPT EPROTONOSUPPORT ESOCKTNOSUPPORT EOPNOTSUPP
	EPFNOSUPPORT EAFNOSUPPORT EADDRINUSE EADDRNOTAVAIL ENETDOWN
	ENETUNREACH ENETRESET ECONNABORTED ECONNRESET ENOBUFS EISCONN
	ENOTCONN ESHUTDOWN ETOOMANYREFS ETIMEDOUT ECONNREFUSED EHOSTDOWN
	EHOSTUNREACH EALREADY EINPROGRESS ESTALE
);

sub EPERM          	() {     1 }
sub ENOENT         	() {     2 }
sub ESRCH          	() {     3 }
sub EINTR          	() {     4 }
sub EIO            	() {     5 }
sub ENXIO          	() {     6 }
sub E2BIG          	() {     7 }
sub ENOEXEC        	() {     8 }
sub EBADF          	() {     9 }
sub ECHILD         	() {    10 }
sub EWOULDBLOCK    	() {    11 }
sub EAGAIN         	() {    11 }
sub ENOMEM         	() {    12 }
sub EACCES         	() {    13 }
sub EFAULT         	() {    14 }
sub ENOTBLK        	() {    15 }
sub EBUSY          	() {    16 }
sub EEXIST         	() {    17 }
sub EXDEV          	() {    18 }
sub ENODEV         	() {    19 }
sub ENOTDIR        	() {    20 }
sub EISDIR         	() {    21 }
sub EINVAL         	() {    22 }
sub ENFILE         	() {    23 }
sub EMFILE         	() {    24 }
sub ENOTTY         	() {    25 }
sub ETXTBSY        	() {    26 }
sub EFBIG          	() {    27 }
sub ENOSPC         	() {    28 }
sub ESPIPE         	() {    29 }
sub EROFS          	() {    30 }
sub EMLINK         	() {    31 }
sub EPIPE          	() {    32 }
sub EDOM           	() {    33 }
sub ERANGE         	() {    34 }
sub ENOMSG         	() {    35 }
sub EIDRM          	() {    36 }
sub ECHRNG         	() {    37 }
sub EL2NSYNC       	() {    38 }
sub EL3HLT         	() {    39 }
sub EL3RST         	() {    40 }
sub ELNRNG         	() {    41 }
sub EUNATCH        	() {    42 }
sub ENOCSI         	() {    43 }
sub EL2HLT         	() {    44 }
sub EDEADLK        	() {    45 }
sub ENOLCK         	() {    46 }
sub ECANCELED      	() {    47 }
sub ENOTSUP        	() {    48 }
sub EDQUOT         	() {    49 }
sub EBADE          	() {    50 }
sub EBADR          	() {    51 }
sub EXFULL         	() {    52 }
sub ENOANO         	() {    53 }
sub EBADRQC        	() {    54 }
sub EBADSLT        	() {    55 }
sub EDEADLOCK      	() {    56 }
sub EBFONT         	() {    57 }
sub ENOSTR         	() {    60 }
sub ENODATA        	() {    61 }
sub ETIME          	() {    62 }
sub ENOSR          	() {    63 }
sub ENONET         	() {    64 }
sub ENOPKG         	() {    65 }
sub EREMOTE        	() {    66 }
sub ENOLINK        	() {    67 }
sub EADV           	() {    68 }
sub ESRMNT         	() {    69 }
sub ECOMM          	() {    70 }
sub EPROTO         	() {    71 }
sub EMULTIHOP      	() {    74 }
sub EBADMSG        	() {    77 }
sub ENAMETOOLONG   	() {    78 }
sub EOVERFLOW      	() {    79 }
sub ENOTUNIQ       	() {    80 }
sub EBADFD         	() {    81 }
sub EREMCHG        	() {    82 }
sub ELIBACC        	() {    83 }
sub ELIBBAD        	() {    84 }
sub ELIBSCN        	() {    85 }
sub ELIBMAX        	() {    86 }
sub ELIBEXEC       	() {    87 }
sub EILSEQ         	() {    88 }
sub ENOSYS         	() {    89 }
sub ELOOP          	() {    90 }
sub ERESTART       	() {    91 }
sub ESTRPIPE       	() {    92 }
sub ENOTEMPTY      	() {    93 }
sub EUSERS         	() {    94 }
sub ENOTSOCK       	() {    95 }
sub EDESTADDRREQ   	() {    96 }
sub EMSGSIZE       	() {    97 }
sub EPROTOTYPE     	() {    98 }
sub ENOPROTOOPT    	() {    99 }
sub EPROTONOSUPPORT	() {   120 }
sub ESOCKTNOSUPPORT	() {   121 }
sub EOPNOTSUPP     	() {   122 }
sub EPFNOSUPPORT   	() {   123 }
sub EAFNOSUPPORT   	() {   124 }
sub EADDRINUSE     	() {   125 }
sub EADDRNOTAVAIL  	() {   126 }
sub ENETDOWN       	() {   127 }
sub ENETUNREACH    	() {   128 }
sub ENETRESET      	() {   129 }
sub ECONNABORTED   	() {   130 }
sub ECONNRESET     	() {   131 }
sub ENOBUFS        	() {   132 }
sub EISCONN        	() {   133 }
sub ENOTCONN       	() {   134 }
sub ESHUTDOWN      	() {   143 }
sub ETOOMANYREFS   	() {   144 }
sub ETIMEDOUT      	() {   145 }
sub ECONNREFUSED   	() {   146 }
sub EHOSTDOWN      	() {   147 }
sub EHOSTUNREACH   	() {   148 }
sub EALREADY       	() {   149 }
sub EINPROGRESS    	() {   150 }
sub ESTALE         	() {   151 }

1;
