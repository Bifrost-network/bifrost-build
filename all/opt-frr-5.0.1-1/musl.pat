--- lib/prefix.h~	Thu Jul  5 09:40:17 2018
+++ lib/prefix.h	Tue Aug 14 14:10:09 2018
@@ -25,11 +25,11 @@
 #ifdef SUNOS_5
 #include <sys/ethernet.h>
 #else
-#ifdef GNU_LINUX
-#include <net/ethernet.h>
-#else
+//#ifdef GNU_LINUX
+//#include <net/ethernet.h>
+//#else
 #include <netinet/if_ether.h>
-#endif
+//#endif
 #endif
 #include "sockunion.h"
 #include "ipaddr.h"
