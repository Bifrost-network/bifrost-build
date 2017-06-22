--- src/exim.c.orig	Thu Jun 22 09:21:46 2017
+++ src/exim.c	Thu Jun 22 09:23:00 2017
@@ -12,10 +12,6 @@
 
 #include "exim.h"
 
-#ifdef __GLIBC__
-# include <gnu/libc-version.h>
-#endif
-
 #ifdef USE_GNUTLS
 # include <gnutls/gnutls.h>
 # if GNUTLS_VERSION_NUMBER < 0x030103 && !defined(DISABLE_OCSP)
@@ -1042,14 +1038,6 @@
       );
 #else
   fprintf(f, "Compiler: <unknown>\n");
-#endif
-
-#ifdef __GLIBC__
-  fprintf(f, "Library version: Glibc: Compile: %d.%d\n",
-	       	__GLIBC__, __GLIBC_MINOR__);
-  if (__GLIBC_PREREQ(2, 1))
-    fprintf(f, "                        Runtime: %s\n",
-	       	gnu_get_libc_version());
 #endif
 
 #ifdef SUPPORT_TLS
