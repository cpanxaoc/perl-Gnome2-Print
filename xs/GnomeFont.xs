#include "gnomeprintperl.h"

MODULE = Gnome2::Print::Font	PACKAGE = Gnome2::Print::Font

### GnomeFontWeight it's not a GEnum type, so we need this hack...
### mmh... I'm wondering if I should file this as a bug in gnome-print.
gint
constants (class)
	SV * class
    ALIAS:
	Gnome2::Print::Font::lightest    = 1
	Gnome2::Print::Font::extra_light = 2
	Gnome2::Print::Font::thin        = 3
	Gnome2::Print::Font::ligh        = 4
	Gnome2::Print::Font::book        = 5
	Gnome2::Print::Font::regular     = 6
	Gnome2::Print::Font::medium      = 7
	Gnome2::Print::Font::semi        = 8
	Gnome2::Print::Font::demi        = 9
	Gnome2::Print::Font::bold        = 10
	Gnome2::Print::Font::heavy       = 11
	Gnome2::Print::Font::extrabold   = 12
	Gnome2::Print::Font::black       = 13
	Gnome2::Print::Font::extrablack  = 14
	Gnome2::Print::Font::heaviest    = 15
    CODE:
    	switch (ix) {
		case  1: RETVAL = GNOME_FONT_LIGHTEST; break; 
		case  2: RETVAL = GNOME_FONT_EXTRA_LIGHT; break;
		case  3: RETVAL = GNOME_FONT_THIN; break;
		case  4: RETVAL = GNOME_FONT_LIGHT; break;
		case  5: RETVAL = GNOME_FONT_BOOK; break;
		case  6: RETVAL = GNOME_FONT_REGULAR; break;
		case  7: RETVAL = GNOME_FONT_MEDIUM; break;
		case  8: RETVAL = GNOME_FONT_SEMI; break;
		case  9: RETVAL = GNOME_FONT_DEMI; break;
		case 10: RETVAL = GNOME_FONT_BOLD; break;
		case 11: RETVAL = GNOME_FONT_HEAVY; break;
		case 12: RETVAL = GNOME_FONT_EXTRABOLD; break;
		case 13: RETVAL = GNOME_FONT_BLACK; break;
		case 14: RETVAL = GNOME_FONT_EXTRABLACK; break; 
		case 15: RETVAL = GNOME_FONT_HEAVIEST; break;
	}
    OUTPUT:
	RETVAL


MODULE = Gnome2::Print::Font	PACKAGE = Gnome2::Print::Font	PREFIX = gnome_font_

	
const guchar *
gnome_font_get_name (font)
	GnomeFont	* font

const guchar *
gnome_font_get_family_name (font)
	GnomeFont 	* font
	
const guchar *
gnome_font_get_species_name (font)
	GnomeFont 	* font
	
const guchar *
gnome_font_get_ps_name (font)
	GnomeFont 	* font

gdouble 
gnome_font_get_size (font)
	GnomeFont 	* font

GnomeFontFace_noinc  *
gnome_font_get_face (font)
	GnomeFont 	* font

##ArtPoint       *gnome_font_get_glyph_stdadvance (GnomeFont *font, gint glyph, ArtPoint *advance);
##ArtDRect       *gnome_font_get_glyph_stdbbox    (GnomeFont *font, gint glyph, ArtDRect *bbox);
##const ArtBpath *gnome_font_get_glyph_stdoutline (GnomeFont *font, gint glyph);
##ArtPoint       *gnome_font_get_glyph_stdkerning (GnomeFont *font, gint glyph0, gint glyph1, ArtPoint *kerning);

gdouble 
gnome_font_get_glyph_width (font, glyph)
	GnomeFont 	* font
	gint 		glyph

### This is defined inside gnome-font.h, but it's not an expoerted symbol.
##gdouble 
##gnome_font_get_glyph_kerning (font, glyph1, glyph2)
##	GnomeFont 	* font
##	gint 		glyph1
##	gint		glyph2

gint
gnome_font_lookup_default (font, unicode)
	GnomeFont 	* font
	gint 		unicode

##guchar *gnome_font_get_full_name (GnomeFont *font);
##gdouble gnome_font_get_ascender (GnomeFont *font);
##gdouble gnome_font_get_descender (GnomeFont *font);
##gdouble gnome_font_get_underline_position  (GnomeFont *font);
##gdouble gnome_font_get_underline_thickness (GnomeFont *font);

 ## Find the closest face matching the family name, weight, and italic
 ## This is not very intelligent, so use with caution (Lauris)
GnomeFont_noinc *
gnome_font_find (class, name, size)
	SV * class
	const guchar *name
	gdouble size
    C_ARGS:
    	name, size

GnomeFont_noinc *
gnome_font_find_closest (class, name, size)
	SV * class
	const guchar *name
	gdouble size
    C_ARGS:
    	name, size

GnomeFont_noinc *
gnome_font_find_from_full_name (class, string)
	SV * class
	const guchar *string
    C_ARGS:
    	string
	

GnomeFont_noinc *
gnome_font_find_closest_from_full_name (class, string)
	SV * class
	const guchar *string
    C_ARGS:
    	string

### weight should be GnomeFontWeight, but since it's an enum, we use a gint
### instead.
GnomeFont *
gnome_font_find_closest_from_weight_slant (family, weight, italic, size)
	const guchar *family
	gint weight
	gboolean italic
	gdouble size

##GList  *gnome_font_list (void);
void
gnome_font_list (class)
	SV * class
    PREINIT:
    	GList *list, *i;
    PPCODE:
    	list = gnome_font_list ();
	if (! list)
		XSRETURN_EMPTY;
	for (i = list; i != NULL; i = i->next)
		XPUSHs (sv_2mortal (newSVGChar (i->data)));
	/* according to docs, it's up to us to free this. */	
	gnome_font_list_free(list);

##void    gnome_font_list_free (GList *fontlist);

##GList  *gnome_font_family_list (void);
void
gnome_font_family_list (class)
	SV * class
    PREINIT:
    	GList *list, *i;
    PPCODE:
    	list = gnome_font_family_list ();
	if (! list)
		XSRETURN_EMPTY;
	for (i = list; i != NULL; i = i->next)
		XPUSHs (sv_2mortal (newSVGChar (i->data)));
	/* according to docs, it's up to us to free this. */	
	gnome_font_family_list_free(list);

##void    gnome_font_family_list_free (GList *fontlist);

##GList  *gnome_font_style_list (const guchar *family);
void
gnome_font_style_list (class, family)
	SV * class;
	const guchar * family
    PREINIT:
    	GList *list, *i;
    PPCODE:
    	list = gnome_font_style_list (family);
	if (! list)
		XSRETURN_EMPTY;
	for (i = list; i != NULL; i = i->next)
		XPUSHs (sv_2mortal (newSVGChar (i->data)));
	/* according to docs, it's up to us to free this. */	
	gnome_font_style_list_free (list);

##void    gnome_font_style_list_free (GList *styles);


##PangoFont            *gnome_font_get_closest_pango_font (const GnomeFont *font, PangoFontMap *map, gdouble dpi);
##PangoFontDescription *gnome_font_get_pango_description (const GnomeFont *font, gdouble dpi);

