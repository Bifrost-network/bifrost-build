/* Program name management.
   Copyright (C) 2016-2018 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

#include <config.h>

/* Specification.  */
#include "getprogname.h"

#include <errno.h> /* get program_invocation_name declaration */
#include <stdlib.h> /* get __argv declaration */

#include "dirname.h"

#ifndef HAVE_GETPROGNAME             /* not Mac OS X, FreeBSD, NetBSD, OpenBSD >= 5.4, Cygwin */
char const *
getprogname (void)
{
	return "bison";
}

#endif

/*
 * Hey Emacs!
 * Local Variables:
 * coding: utf-8
 * End:
 */
