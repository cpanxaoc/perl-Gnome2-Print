#include "gnomeprintperl.h"

MODULE = Gnome2::Print::Paper PACKAGE = Gnome2::Print::Paper PREFIX = gnome_print_paper_

## GnomePrintPaper it's not a registered boxed type.
##const GnomePrintPaper *gnome_print_paper_get_default (void);
##const GnomePrintPaper *gnome_print_paper_by_name (const guchar *name);
##const GnomePrintPaper *gnome_print_paper_get_by_size (gdouble width, gdouble height);
##const GnomePrintPaper *gnome_print_paper_get_closest_by_size (gdouble width, gdouble height, gboolean mustfit);

## gnome_print_paper_get_list returns a list of GnomePrintPaper.
##GList * gnome_print_paper_get_list (void);
##void    gnome_print_paper_free_list (GList *papers);
