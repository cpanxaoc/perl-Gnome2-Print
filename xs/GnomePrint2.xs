#include <gnome2perl.h>
#include "gnomeprintperl.h"


MODULE = Gnome2::Print	PACKAGE = Gnome2::Print	PREFIX = gnome_print_


BOOT:
#include "register.xsh"
#include "boot.xsh"
