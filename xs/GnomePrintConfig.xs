#include "gnomeprintperl.h"


MODULE = Gnome2::Print::Config	PACKAGE = Gnome2::Print::Config


### some convenience keys to be used with set/get...
const guchar *
constants (class)
	SV * class
    ALIAS:
    	Gnome2::Print::Config::key_paper_size = 1
	Gnome2::Print::Config::key_paper_width = 2
    CODE:
    	switch (ix) {
		case 1: RETVAL = GNOME_PRINT_KEY_PAPER_SIZE; break;
		case 2: RETVAL = GNOME_PRINT_KEY_PAPER_WIDTH; break;
	}
    OUTPUT:
	RETVAL


MODULE = Gnome2::Print::Config	PACKAGE = Gnome2::Print::Config	PREFIX = gnome_print_config_


GnomePrintConfig_noinc *
gnome_print_config_default (SV * class);
    C_ARGS:
	/* void */

gchar_own *
gnome_print_config_to_string (gpc, flags)
	GnomePrintConfig	* gpc
	guint			flags

GnomePrintConfig_noinc *
gnome_print_config_from_string (str, flags)
	const gchar	* str
	guint		flags

void
gnome_print_config_dump (gpc)
	GnomePrintConfig	* gpc

void
gnome_print_config_get_page_size (gpc)
	GnomePrintConfig	* gpc
    PREINIT:
    	gdouble width;
	gdouble height;
    PPCODE:
    	if (!gnome_print_config_get_page_size (gpc, &width, &height))
		XSRETURN_EMPTY;
	
	EXTEND (SP, 2);
	PUSHs (sv_2mortal (newSVnv (width)));
	PUSHs (sv_2mortal (newSVnv (height)));


### The C functions return FALSE (or NULL, for gnome_print_config_get) if the
### key is not found.  Here, we change it a bit: we return undef if the key is
### not found (both in set_* and in get_*); otherwise, in the get_* methods, we
### return the requested value.

##guchar * gnome_print_config_get (GnomePrintConfig *config, const guchar *key);
##gboolean gnome_print_config_set (GnomePrintConfig *config, const guchar *key, const guchar *value);

##gboolean gnome_print_config_get_boolean (GnomePrintConfig *config, const guchar *key, gboolean *val)

##gboolean gnome_print_config_get_int     (GnomePrintConfig *config, const guchar *key, gint *val);
##gboolean gnome_print_config_get_double  (GnomePrintConfig *config, const guchar *key, gdouble *val);
##gboolean gnome_print_config_get_length  (GnomePrintConfig *config, const guchar *key, gdouble *val, const GnomePrintUnit **unit);
##gboolean gnome_print_config_set_boolean (GnomePrintConfig *config, const guchar *key, gboolean val);

##gboolean gnome_print_config_set_int (GnomePrintConfig *config, const guchar *key, gint val);
##gboolean gnome_print_config_set_double (GnomePrintConfig *config, const guchar *key, gdouble val);
##gboolean gnome_print_config_set_length (GnomePrintConfig *config, const guchar *key, gdouble val, const GnomePrintUnit *unit);
