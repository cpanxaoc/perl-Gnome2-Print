#include "gnomeprintperl.h"

MODULE = Gnome2::Print::Unit PACKAGE = Gnome2::Print::Unit

## read-only access to GnomePrintUnit members.
SV *
members (GnomePrintUnit * unit)
    ALIAS:
    	Gnome2::Print::Unit::version     = 0
	Gnome2::Print::Unit::base        = 1
	Gnome2::Print::Unit::unittobase  = 2
	Gnome2::Print::Unit::name        = 3
	Gnome2::Print::Unit::abbr        = 4
	Gnome2::Print::Unit::plural      = 5
	Gnome2::Print::Unit::abbr_plural = 6
    CODE:
    	switch (ix) {
		case 0: RETVAL = newSViv (unit->version);        break;
		case 1: RETVAL = newSViv (unit->base);           break;
		case 2: RETVAL = newSVnv (unit->unittobase);     break;
		case 3: RETVAL = newSVGChar (unit->name);        break;
		case 4: RETVAL = newSVGChar (unit->abbr);        break;
		case 5: RETVAL = newSVGChar (unit->plural);      break;
		case 6: RETVAL = newSVGChar (unit->abbr_plural); break;
	}
    OUTPUT:
    	RETVAL


MODULE = Gnome2::Print::Unit PACKAGE = Gnome2::Print::Unit PREFIX = gnome_print_unit_


## These are read-only values, so we just pass copies.

##const GnomePrintUnit *gnome_print_unit_get_identity (guint base);
GnomePrintUnit_copy *
gnome_print_unit_get_identity (class, base)
	SV * class
	guint base
    C_ARGS:
    	base

##const GnomePrintUnit *gnome_print_unit_get_default (void);
GnomePrintUnit_copy *
gnome_print_unit_get_default (class)
	SV * class
    C_ARGS:
    	/* void */

##const GnomePrintUnit *gnome_print_unit_get_by_name (const guchar *name);
GnomePrintUnit_copy *
gnome_print_unit_get_by_name (class, name)
	SV * class
	const guchar * name
    C_ARGS:
    	name

##const GnomePrintUnit *gnome_print_unit_get_by_abbreviation (const guchar *abbreviation);
GnomePrintUnit_copy *
gnome_print_unit_get_by_abbreviation (class, abbreviation)
	SV * class
	const guchar * abbreviation
    C_ARGS:
    	abbreviation

##GList * gnome_print_unit_get_list (guint bases);
void
gnome_print_unit_get_list (bases)
	guint bases
    PREINIT:
    	GList * list, * i;
    PPCODE:
    	list = gnome_print_unit_get_list (bases);
	for (i = list; i != NULL; i = i->next)
		XPUSHs (sv_2mortal (newSVGnomePrintUnit_copy (i->data)));
	gnome_print_unit_free_list (list);

##void    gnome_print_unit_free_list (GList *units);

	
MODULE = Gnome2::Print::Unit PACKAGE = Gnome2::Print::Unit PREFIX = gnome_print_

## gnome_print_convert_distance* return FALSE on error, or if the conversion is
## impossible, otherwise TRUE; we return the distance on success, or undef on
## failure.
##gboolean gnome_print_convert_distance (gdouble *distance, const GnomePrintUnit *from, const GnomePrintUnit *to);
void
gnome_print_convert_distance (from, to)
	GnomePrintUnit * from
	GnomePrintUnit * to
    PREINIT:
    	gboolean res;
    	gdouble distance;
    PPCODE:
    	res = gnome_print_convert_distance (&distance,
			(const GnomePrintUnit *)from,
			(const GnomePrintUnit *)to);
	if (! res)
		XSRETURN_UNDEF;
	EXTEND (SP, 1);
	PUSHs (sv_2mortal (newSVnv (distance)));

##gboolean gnome_print_convert_distance_full (gdouble *distance, const GnomePrintUnit *from, const GnomePrintUnit *to, gdouble ctmscale, gdouble devicescale);
void
gnome_print_convert_distance_full (from, to, ctmscale, devicescale)
	GnomePrintUnit * from
	GnomePrintUnit * to
	gdouble ctmscale
	gdouble devicescale
    PREINIT:
    	gboolean res;
    	gdouble distance;
    PPCODE:
    	res = gnome_print_convert_distance_full (&distance, 
			(const GnomePrintUnit *)from,
			(const GnomePrintUnit *)to,
			ctmscale, devicescale);
	if (! res)
		XSRETURN_UNDEF;
	EXTEND (SP, 1);
	PUSHs (sv_2mortal (newSVnv (distance)));
