--- Makefile.orig	Tue Dec 10 14:19:13 2019
+++ Makefile	Tue Dec 10 14:20:07 2019
@@ -17,14 +17,12 @@
 #   along with this program; if not, write to the Free Software
 #   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
-CC= gcc
 #SKFLAGS= -g -DSYSV -Wall
 #LDFLAGS= -g
-SKFLAGS= $(RPM_OPT_FLAGS) -O3 -DSYSV -fomit-frame-pointer -Wall -fno-strength-reduce
+SKFLAGS= $(RPM_OPT_FLAGS) -DSYSV -fomit-frame-pointer -Wall -fno-strength-reduce
 # -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 # -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
 # $(shell getconf LFS_SKFLAGS)
-LDFLAGS= -s
 
 # Look where your install program is.
 INSTALL = /usr/bin/install
