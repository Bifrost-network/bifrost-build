#ifndef _COMPAT_IF_H
#define _COMPAT_IF_H

#include <linux/if.h>
#define IF_NAMESIZE 16

struct if_nameindex {
	unsigned int if_index;
	char *if_name;
};

unsigned int if_nametoindex (const char *);
char *if_indextoname (unsigned int, char *);
struct if_nameindex *if_nameindex (void);
void if_freenameindex (struct if_nameindex *);

#endif
