--- klogd.c.orig	Tue Dec 10 14:41:22 2019
+++ klogd.c	Tue Dec 10 14:43:03 2019
@@ -260,14 +260,13 @@
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <sys/stat.h>
-#if !defined(__GLIBC__)
-#include <linux/time.h>
-#endif /* __GLIBC__ */
 #include <stdarg.h>
 #include <paths.h>
 #include <stdlib.h>
+#include <sys/types.h>
+
 #include "klogd.h"
 #include "ksyms.h"
 #ifndef TESTING
@@ -277,13 +276,8 @@
 
 #define __LIBRARY__
 #include <linux/unistd.h>
-#if !defined(__GLIBC__)
-# define __NR_ksyslog __NR_syslog
-_syscall3(int,ksyslog,int, type, char *, buf, int, len);
-#else
 #include <sys/klog.h>
 #define ksyslog klogctl
-#endif
 
 #define LOG_BUFFER_SIZE 4096
 #define LOG_LINE_LENGTH 1000
--- pidfile.c.orig	Tue Dec 10 14:39:00 2019
+++ pidfile.c	Tue Dec 10 14:39:24 2019
@@ -31,6 +31,8 @@
 #include <string.h>
 #include <errno.h>
 #include <signal.h>
+#include <sys/types.h>
+#include <fcntl.h>
 
 /* read_pid
  *
--- syslog.c.orig	Tue Dec 10 14:43:27 2019
+++ syslog.c	Tue Dec 10 14:44:02 2019
@@ -55,7 +55,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/file.h>
-#include <sys/signal.h>
+#include <signal.h>
 #include <sys/syslog.h>
 #if 0
 #include "syslog.h"
@@ -72,6 +72,8 @@
 #include <stdarg.h>
 #include <paths.h>
 #include <stdio.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #define	_PATH_LOGNAME	"/dev/log"
 
--- syslogd.c.orig	Tue Dec 10 14:25:03 2019
+++ syslogd.c	Tue Dec 10 14:38:18 2019
@@ -521,7 +521,7 @@
 #define SYSLOG_NAMES
 #include <sys/syslog.h>
 #include <sys/param.h>
-#include <sys/errno.h>
+#include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -549,6 +549,8 @@
 #endif
 #include "version.h"
 
+#define dprintf mydprintf
+
 #if defined(__linux__)
 #include <paths.h>
 #endif
@@ -818,10 +820,6 @@
 void init();
 void cfline(char *line, register struct filed *f);
 int decode(char *name, struct code *codetab);
-#if defined(__GLIBC__)
-#define dprintf mydprintf
-#endif /* __GLIBC__ */
-static void dprintf(char *, ...);
 static void allocate_log(void);
 void sighup_handler();
 
@@ -832,6 +830,22 @@
 static int create_inet_socket();
 #endif
 
+static void dprintf(char *fmt, ...)
+
+{
+	va_list ap;
+
+	if ( !(Debug && debugging_on) )
+		return;
+	
+	va_start(ap, fmt);
+	vfprintf(stdout, fmt, ap);
+	va_end(ap);
+
+	fflush(stdout);
+	return;
+}
+
 int main(argc, argv)
 	int argc;
 	char **argv;
@@ -2094,14 +2108,12 @@
 	(void) signal(SIGCHLD, reapchild);	/* reset signal handler -ASP */
 	wait ((int *)0);
 #else
-	union wait status;
+	int status;
 
-	while (wait3(&status, WNOHANG, (struct rusage *) NULL) > 0)
+	while (waitpid(-1, &status, WNOHANG) > 0)
 		;
 #endif
-#ifdef linux
 	(void) signal(SIGCHLD, reapchild);	/* reset signal handler -ASP */
-#endif
 	errno = saved_errno;
 }
 
@@ -2831,23 +2843,6 @@
 		}
 	return (-1);
 }
-
-static void dprintf(char *fmt, ...)
-
-{
-	va_list ap;
-
-	if ( !(Debug && debugging_on) )
-		return;
-	
-	va_start(ap, fmt);
-	vfprintf(stdout, fmt, ap);
-	va_end(ap);
-
-	fflush(stdout);
-	return;
-}
-
 
 /*
  * The following function is responsible for allocating/reallocating the
