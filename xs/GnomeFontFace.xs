#include "gnomeprintperl.h"

MODULE = Gnome2::Print::FontFace PACKAGE = Gnome2::Print::FontFace


GnomeFontFace_noinc *
gnome_font_face_find (class, name)
	SV * class
	const guchar * name
    C_ARGS:
     	name

GnomeFontFace_noinc *
gnome_font_face_find_closest (class, name)
	SV * class
	const guchar * name
    C_ARGS:
    	name

GnomeFontFace_noinc *
gnome_font_face_find_closest_from_weight_slant (class, family, weight, italic)
	SV * class
	const guchar *family
	gint weight
	gboolean italic
    C_ARGS:
    	family, weight, italic

GnomeFontFace_noinc *
gnome_font_face_find_closest_from_pango_font (class, pfont)
	SV * class
	PangoFont * pfont
    C_ARGS:
    	pfont

GnomeFontFace_noinc *
gnome_font_face_find_closest_from_pango_description (class, desc)
	SV * class
	PangoFontDescription * desc
    C_ARGS:
    	desc
	
GnomeFontFace_noinc *
gnome_font_face_find_from_family_and_style (class, family, style)
	SV * class
	const guchar * family
	const guchar * style
    C_ARGS:
    	family, style


GnomeFont_noinc *
gnome_font_face_get_font (face, size, xres, yres)
	GnomeFontFace * face
	gdouble size
	gdouble xres
	gdouble yres

GnomeFont_noinc *
gnome_font_face_get_font_default (face, size)
	GnomeFontFace * face
	gdouble size

##const guchar * gnome_font_face_get_name         (const GnomeFontFace *face);
##const guchar * gnome_font_face_get_ps_name      (const GnomeFontFace *face);
##const guchar * gnome_font_face_get_family_name  (const GnomeFontFace *face);
##const guchar * gnome_font_face_get_species_name (const GnomeFontFace *face);

##const ArtDRect *gnome_font_face_get_stdbbox (GnomeFontFace *face);
##ArtDRect       *gnome_font_face_get_glyph_stdbbox (GnomeFontFace *face, gint glyph, ArtDRect * bbox);
##ArtPoint       *gnome_font_face_get_glyph_stdadvance (GnomeFontFace *face, gint glyph, ArtPoint * advance);
##const ArtBpath *gnome_font_face_get_glyph_stdoutline (GnomeFontFace *face, gint glyph);
##ArtPoint       *gnome_font_face_get_glyph_stdkerning (GnomeFontFace *face, gint glyph0, gint glyph1, ArtPoint *kerning);

##GnomeFontWeight gnome_font_face_get_weight_code (GnomeFontFace *face);

gboolean
gnome_font_face_is_italic (face)
	GnomeFontFace * face

gboolean
gnome_font_face_is_fixed_width (face)
	GnomeFontFace * face

gdouble
gnome_font_face_get_ascender (face)
	GnomeFontFace * face
	
gdouble
gnome_font_face_get_descender (face)
	GnomeFontFace * face
	
gdouble
gnome_font_face_get_underline_position  (face)
	GnomeFontFace * face
	
gdouble
gnome_font_face_get_underline_thickness (face)
	GnomeFontFace * face

gint
gnome_font_face_get_num_glyphs (face)
	GnomeFontFace * face

gdouble
gnome_font_face_get_glyph_width (face, glyph)
	GnomeFontFace * face
	gint glyph
	
gdouble
gnome_font_face_get_glyph_kerning (face, glyph1, glyph2)
	GnomeFontFace * face
	gint glyph1
	gint glyph2

##const guchar   *gnome_font_face_get_glyph_ps_name (GnomeFontFace *face, gint glyph);
