#include "gnomeprintperl.h"

MODULE = Gnome2::Print::GluphList PACKAGE = Gnome2::Print::GlyphList PREFIX = gnome_glyphlist_


##GnomeGlyphList * gnome_glyphlist_new (void);
GnomeGlyphList_own *
gnome_glyphlist_new (SV * class)
    C_ARGS:
	/* void */		

##GnomeGlyphList * gnome_glyphlist_ref       (GnomeGlyphList *gl);
##GnomeGlyphList * gnome_glyphlist_unref     (GnomeGlyphList *gl);
##GnomeGlyphList * gnome_glyphlist_duplicate (GnomeGlyphList *gl);
##
##gboolean         gnome_glyphlist_check (const GnomeGlyphList *gl, gboolean rules);
##ArtDRect *       gnome_glyphlist_bbox  (const GnomeGlyphList *gl, const gdouble *transform, gint flags, ArtDRect *bbox);
##
##void gnome_glyphlist_advance     (GnomeGlyphList *gl, gboolean advance);
##void gnome_glyphlist_kerning     (GnomeGlyphList *gl, gdouble kerning);
##void gnome_glyphlist_letterspace (GnomeGlyphList *gl, gdouble letterspace);
##void gnome_glyphlist_font        (GnomeGlyphList *gl, GnomeFont *font);
##void gnome_glyphlist_color       (GnomeGlyphList *gl, guint32 color);
##void gnome_glyphlist_moveto      (GnomeGlyphList *gl, gdouble x, gdouble y);
##void gnome_glyphlist_rmoveto     (GnomeGlyphList *gl, gdouble x, gdouble y);
##void gnome_glyphlist_glyph       (GnomeGlyphList *gl, gint glyph);
##void gnome_glyphlist_glyphs      (GnomeGlyphList *gl, gint *glyphs, gint num_glyphs);
##
##
##void gnome_glyphlist_text_dumb       (GnomeGlyphList *gl, const guchar *text);
##void gnome_glyphlist_text_sized_dumb (GnomeGlyphList *gl, const guchar *text, gint length);
##
##GnomeGlyphList *gnome_glyphlist_from_text_dumb       (GnomeFont *font, guint32 color,
##						      gdouble kerning, gdouble letterspace,
##						      const guchar *text);
##GnomeGlyphList *gnome_glyphlist_from_text_sized_dumb (GnomeFont *font, guint32 color,
##						      gdouble kerning, gdouble letterspace,
##						      const guchar *text, gint length);
