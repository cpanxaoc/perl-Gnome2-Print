#include "gnomeprintperl.h"


MODULE = Gnome2::Print::JobPreview PACKAGE = Gnome2::Print::JobPreview PREFIX = gnome_print_job_preview_


GtkWidget *
gnome_print_job_preview_new (class, gpm, title)
	SV		* class
	GnomePrintJob	* gpm
	const guchar	* title
    C_ARGS:
    	gpm, title
