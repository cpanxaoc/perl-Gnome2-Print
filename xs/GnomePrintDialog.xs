#include "gnomeprintperl.h"


MODULE = Gnome2::Print::Dialog PACKAGE = Gnome2::Print::Dialog	PREFIX = gnome_print_dialog_


GtkWidget *
gnome_print_dialog_new (class, gpj, title, flags)
	SV		* class
	GnomePrintJob	* gpj
	const guchar	* title
	gint		flags
    C_ARGS:
    	gpj, title, flags

GnomePrintConfig *
gnome_print_dialog_get_config (gpd)
	GnomePrintDialog *gpd

void
gnome_print_dialog_get_copies (gpd)
	GnomePrintDialog *gpd
    PREINIT:
    	gint copies;
	gint collate;
    PPCODE:
    	gnome_print_dialog_get_copies (gpd, &copies, &collate);

	EXTEND (SP, 2);
	PUSHs (sv_2mortal (newSVnv (copies)));
	PUSHs (sv_2mortal (newSVnv (collate)));

void
gnome_print_dialog_set_copies (gpd, copies, collate)
	GnomePrintDialog	* gpd
	gint	copies
	gint	collate
