--- include/linux/libc-compat.h~	Tue Dec 13 00:07:42 2016
+++ include/linux/libc-compat.h	Fri Jun 30 14:54:50 2017
@@ -49,7 +49,6 @@
 #define _LIBC_COMPAT_H
 
 /* We have included glibc headers... */
-#if defined(__GLIBC__)
 
 /* Coordinate with glibc net/if.h header. */
 #if defined(_NET_IF_H) && defined(__USE_MISC)
@@ -207,7 +206,5 @@
 
 /* Definitions for xattr.h */
 #define __UAPI_DEF_XATTR		1
-
-#endif /* __GLIBC__ */
 
 #endif /* _LIBC_COMPAT_H */
