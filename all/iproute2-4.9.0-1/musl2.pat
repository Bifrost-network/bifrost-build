--- ./include/linux/in6.h.orig	Fri Jun 30 15:00:42 2017
+++ ./include/linux/in6.h	Fri Jun 30 15:11:08 2017
@@ -28,43 +28,6 @@
  *	IPv6 address structure
  */
 
-#if __UAPI_DEF_IN6_ADDR
-struct in6_addr {
-	union {
-		__u8		u6_addr8[16];
-#if __UAPI_DEF_IN6_ADDR_ALT
-		__be16		u6_addr16[8];
-		__be32		u6_addr32[4];
-#endif
-	} in6_u;
-#define s6_addr			in6_u.u6_addr8
-#if __UAPI_DEF_IN6_ADDR_ALT
-#define s6_addr16		in6_u.u6_addr16
-#define s6_addr32		in6_u.u6_addr32
-#endif
-};
-#endif /* __UAPI_DEF_IN6_ADDR */
-
-#if __UAPI_DEF_SOCKADDR_IN6
-struct sockaddr_in6 {
-	unsigned short int	sin6_family;    /* AF_INET6 */
-	__be16			sin6_port;      /* Transport layer port # */
-	__be32			sin6_flowinfo;  /* IPv6 flow information */
-	struct in6_addr		sin6_addr;      /* IPv6 address */
-	__u32			sin6_scope_id;  /* scope id (new in RFC2553) */
-};
-#endif /* __UAPI_DEF_SOCKADDR_IN6 */
-
-#if __UAPI_DEF_IPV6_MREQ
-struct ipv6_mreq {
-	/* IPv6 multicast address of group */
-	struct in6_addr ipv6mr_multiaddr;
-
-	/* local IPv6 address of interface */
-	int		ipv6mr_ifindex;
-};
-#endif /* __UAPI_DEF_IVP6_MREQ */
-
 #define ipv6mr_acaddr	ipv6mr_multiaddr
 
 struct in6_flowlabel_req {
--- ./include/linux/if.h.orig	Fri Jun 30 15:01:33 2017
+++ ./include/linux/if.h	Fri Jun 30 15:12:52 2017
@@ -73,6 +73,8 @@
  * @IFF_DORMANT: driver signals dormant. Volatile.
  * @IFF_ECHO: echo sent packets. Volatile.
  */
+
+#if 0
 enum net_device_flags {
 /* for compatibility with glibc net/if.h */
 #if __UAPI_DEF_IF_NET_DEVICE_FLAGS
@@ -99,28 +101,10 @@
 	IFF_ECHO			= 1<<18, /* __volatile__ */
 #endif /* __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO */
 };
+#endif
+
 #endif /* __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO != 0 || __UAPI_DEF_IF_NET_DEVICE_FLAGS != 0 */
 
-/* for compatibility with glibc net/if.h */
-#if __UAPI_DEF_IF_NET_DEVICE_FLAGS
-#define IFF_UP				IFF_UP
-#define IFF_BROADCAST			IFF_BROADCAST
-#define IFF_DEBUG			IFF_DEBUG
-#define IFF_LOOPBACK			IFF_LOOPBACK
-#define IFF_POINTOPOINT			IFF_POINTOPOINT
-#define IFF_NOTRAILERS			IFF_NOTRAILERS
-#define IFF_RUNNING			IFF_RUNNING
-#define IFF_NOARP			IFF_NOARP
-#define IFF_PROMISC			IFF_PROMISC
-#define IFF_ALLMULTI			IFF_ALLMULTI
-#define IFF_MASTER			IFF_MASTER
-#define IFF_SLAVE			IFF_SLAVE
-#define IFF_MULTICAST			IFF_MULTICAST
-#define IFF_PORTSEL			IFF_PORTSEL
-#define IFF_AUTOMEDIA			IFF_AUTOMEDIA
-#define IFF_DYNAMIC			IFF_DYNAMIC
-#endif /* __UAPI_DEF_IF_NET_DEVICE_FLAGS */
-
 #if __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO
 #define IFF_LOWER_UP			IFF_LOWER_UP
 #define IFF_DORMANT			IFF_DORMANT
@@ -185,17 +169,6 @@
  */
 
 /* for compatibility with glibc net/if.h */
-#if __UAPI_DEF_IF_IFMAP
-struct ifmap {
-	unsigned long mem_start;
-	unsigned long mem_end;
-	unsigned short base_addr; 
-	unsigned char irq;
-	unsigned char dma;
-	unsigned char port;
-	/* 3 bytes spare */
-};
-#endif /* __UAPI_DEF_IF_IFMAP */
 
 struct if_settings {
 	unsigned int type;	/* Type of physical device or protocol */
@@ -221,33 +194,6 @@
  * remainder may be interface specific.
  */
 
-/* for compatibility with glibc net/if.h */
-#if __UAPI_DEF_IF_IFREQ
-struct ifreq {
-#define IFHWADDRLEN	6
-	union
-	{
-		char	ifrn_name[IFNAMSIZ];		/* if name, e.g. "en0" */
-	} ifr_ifrn;
-	
-	union {
-		struct	sockaddr ifru_addr;
-		struct	sockaddr ifru_dstaddr;
-		struct	sockaddr ifru_broadaddr;
-		struct	sockaddr ifru_netmask;
-		struct  sockaddr ifru_hwaddr;
-		short	ifru_flags;
-		int	ifru_ivalue;
-		int	ifru_mtu;
-		struct  ifmap ifru_map;
-		char	ifru_slave[IFNAMSIZ];	/* Just fits the size */
-		char	ifru_newname[IFNAMSIZ];
-		void *	ifru_data;
-		struct	if_settings ifru_settings;
-	} ifr_ifru;
-};
-#endif /* __UAPI_DEF_IF_IFREQ */
-
 #define ifr_name	ifr_ifrn.ifrn_name	/* interface name 	*/
 #define ifr_hwaddr	ifr_ifru.ifru_hwaddr	/* MAC address 		*/
 #define	ifr_addr	ifr_ifru.ifru_addr	/* address		*/
@@ -272,17 +218,6 @@
  * for machine (useful for programs which
  * must know all networks accessible).
  */
-
-/* for compatibility with glibc net/if.h */
-#if __UAPI_DEF_IF_IFCONF
-struct ifconf  {
-	int	ifc_len;			/* size of buffer	*/
-	union {
-		char *ifcu_buf;
-		struct ifreq *ifcu_req;
-	} ifc_ifcu;
-};
-#endif /* __UAPI_DEF_IF_IFCONF */
 
 #define	ifc_buf	ifc_ifcu.ifcu_buf		/* buffer address	*/
 #define	ifc_req	ifc_ifcu.ifcu_req		/* array of structures	*/
--- ./ip/tunnel.c.orig	Fri Jun 30 15:15:27 2017
+++ ./ip/tunnel.c	Fri Jun 30 15:15:46 2017
@@ -33,6 +33,7 @@
 #include <linux/if.h>
 #include <linux/ip.h>
 #include <linux/if_tunnel.h>
+#include <net/if.h>
 
 #include "utils.h"
 #include "tunnel.h"
--- ./ip/ipmaddr.c.orig	Fri Jun 30 15:18:00 2017
+++ ./ip/ipmaddr.c	Fri Jun 30 15:18:16 2017
@@ -20,6 +20,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <string.h>
+#include <net/if.h>
 
 #include <linux/netdevice.h>
 #include <linux/if.h>
--- ./ip/iptuntap.c.orig	Fri Jun 30 15:18:39 2017
+++ ./ip/iptuntap.c	Fri Jun 30 15:18:54 2017
@@ -26,6 +26,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <glob.h>
+#include <net/if.h>
 
 #include "rt_names.h"
 #include "utils.h"
--- ./ip/iplink.c.orig	Fri Jun 30 15:16:21 2017
+++ ./ip/iplink.c	Fri Jun 30 15:17:10 2017
@@ -28,7 +28,7 @@
 #include <sys/ioctl.h>
 #include <linux/sockios.h>
 #include <stdbool.h>
-
+#include <net/if.h>
 #include "rt_names.h"
 #include "utils.h"
 #include "ip_common.h"
--- ./ip/iptoken.c.orig	Fri Jun 30 15:19:29 2017
+++ ./ip/iptoken.c	Fri Jun 30 15:19:44 2017
@@ -22,7 +22,7 @@
 #include <arpa/inet.h>
 #include <linux/types.h>
 #include <linux/if.h>
-
+#include <net/if.h>
 #include "rt_names.h"
 #include "utils.h"
 #include "ip_common.h"
--- ./bridge/link.c.orig	Fri Jun 30 15:23:06 2017
+++ ./bridge/link.c	Fri Jun 30 15:23:17 2017
@@ -10,7 +10,7 @@
 #include <linux/if_bridge.h>
 #include <string.h>
 #include <stdbool.h>
-
+#include <net/if.h>
 #include "libnetlink.h"
 #include "utils.h"
 #include "br_common.h"
--- ./misc/ifstat.c.orig	Fri Jun 30 15:23:48 2017
+++ ./misc/ifstat.c	Fri Jun 30 15:24:02 2017
@@ -27,7 +27,7 @@
 #include <signal.h>
 #include <math.h>
 #include <getopt.h>
-
+#include <net/if.h>
 #include <libnetlink.h>
 #include <json_writer.h>
 #include <linux/if.h>
--- ./tc/f_matchall.c.orig	Fri Jun 30 15:22:04 2017
+++ ./tc/f_matchall.c	Fri Jun 30 15:22:17 2017
@@ -20,7 +20,7 @@
 #include <arpa/inet.h>
 #include <string.h>
 #include <linux/if.h>
-
+#include <limits.h>
 #include "utils.h"
 #include "tc_util.h"
 
--- ./ip/ipaddress.c.orig	Fri Jun 30 15:31:07 2017
+++ ./ip/ipaddress.c	Fri Jun 30 15:35:45 2017
@@ -30,6 +30,7 @@
 #include <linux/if_arp.h>
 #include <linux/sockios.h>
 #include <linux/net_namespace.h>
+#include <net/if.h>
 
 #include "rt_names.h"
 #include "utils.h"
