--- src/exim.c.orig	Wed Mar  7 20:18:03 2018
+++ src/exim.c	Wed Mar  7 20:18:41 2018
@@ -12,10 +12,6 @@
 
 #include "exim.h"
 
-#if defined(__GLIBC__) && !defined(__UCLIBC__)
-# include <gnu/libc-version.h>
-#endif
-
 #ifdef USE_GNUTLS
 # include <gnutls/gnutls.h>
 # if GNUTLS_VERSION_NUMBER < 0x030103 && !defined(DISABLE_OCSP)
@@ -1043,14 +1039,6 @@
       );
 #else
   fprintf(f, "Compiler: <unknown>\n");
-#endif
-
-#if defined(__GLIBC__) && !defined(__UCLIBC__)
-  fprintf(f, "Library version: Glibc: Compile: %d.%d\n",
-	       	__GLIBC__, __GLIBC_MINOR__);
-  if (__GLIBC_PREREQ(2, 1))
-    fprintf(f, "                        Runtime: %s\n",
-	       	gnu_get_libc_version());
 #endif
 
 #ifdef SUPPORT_TLS
