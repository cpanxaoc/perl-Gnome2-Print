#include <gnome2perl.h>
#include "gnomeprintperl.h"


MODULE = Gnome2::Print	PACKAGE = Gnome2::Print	PREFIX = gnome_print_

void
get_version (class)
	SV * class
     PPCODE:
     	EXTEND (SP, 1);
	PUSHs(sv_2mortal (newSVGChar (LIBGNOMEPRINT_VER)));
	
BOOT:
#include "register.xsh"
#include "boot.xsh"
