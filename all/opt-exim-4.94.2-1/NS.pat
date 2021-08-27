--- build-Linux-i386/structs.h~	Mon Sep  2 23:57:27 2019
+++ build-Linux-i386/structs.h	Sat Sep  7 21:00:25 2019
@@ -49,7 +49,7 @@
   uschar *name;
   int bit;
 } bit_table;
-
+# define NS_MAXMSG 65535
 /* Block for holding a uid and gid, possibly unset, and an initgroups flag. */
 
 typedef struct ugid_block {
