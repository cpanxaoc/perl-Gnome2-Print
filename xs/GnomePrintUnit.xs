#include "gnomeprintperl.h"

MODULE = Gnome2::Print::Unit PACKAGE = Gnome2::Print::Unit PREFIX = gnome_print_unit_


##const GnomePrintUnit *gnome_print_unit_get_identity (guint base);
##const GnomePrintUnit *gnome_print_unit_get_default (void);
##const GnomePrintUnit *gnome_print_unit_get_by_name (const guchar *name);
##const GnomePrintUnit *gnome_print_unit_get_by_abbreviation (const guchar *abbreviation);

##GList * gnome_print_unit_get_list (guint bases);
##void    gnome_print_unit_free_list (GList *units);

##gboolean gnome_print_convert_distance      (gdouble *distance, const GnomePrintUnit *from, const GnomePrintUnit *to);
##gboolean gnome_print_convert_distance_full (gdouble *distance, const GnomePrintUnit *from, const GnomePrintUnit *to, gdouble ctmscale, gdouble devicescale);

