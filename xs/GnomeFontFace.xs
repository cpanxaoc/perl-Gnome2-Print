#include "gnomeprintperl.h"

MODULE = Gnome2::Print::FontFace PACKAGE = Gnome2::Print::FontFace


##GnomeFontFace *gnome_font_face_find         (const guchar *name);
##GnomeFontFace *gnome_font_face_find_closest (const guchar *name);
##GnomeFontFace *gnome_font_face_find_closest_from_weight_slant (const guchar *family, GnomeFontWeight weight, gboolean italic);
##GnomeFontFace *gnome_font_face_find_closest_from_pango_font        (PangoFont *pfont);
##GnomeFontFace *gnome_font_face_find_closest_from_pango_description (const PangoFontDescription *desc);
##GnomeFontFace *gnome_font_face_find_from_family_and_style (const guchar *family, const guchar *style);

##GnomeFont *gnome_font_face_get_font (GnomeFontFace *face, gdouble size, gdouble xres, gdouble yres);
##GnomeFont *gnome_font_face_get_font_default (GnomeFontFace *face, gdouble size);

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
##gboolean        gnome_font_face_is_italic       (GnomeFontFace *face);
##gboolean        gnome_font_face_is_fixed_width  (GnomeFontFace *face);

##gdouble         gnome_font_face_get_ascender  (GnomeFontFace *face);
##gdouble         gnome_font_face_get_descender (GnomeFontFace *face);
##gdouble         gnome_font_face_get_underline_position  (GnomeFontFace *face);
##gdouble         gnome_font_face_get_underline_thickness (GnomeFontFace *face);

##gint            gnome_font_face_get_num_glyphs    (GnomeFontFace *face);

##gdouble         gnome_font_face_get_glyph_width   (GnomeFontFace *face, gint glyph);
##gdouble         gnome_font_face_get_glyph_kerning (GnomeFontFace *face, gint glyph1, gint glyph2);
##const guchar   *gnome_font_face_get_glyph_ps_name (GnomeFontFace *face, gint glyph);
