#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 12;
BEGIN { use_ok('Gnome2::Print') };

#########################

ok( $font = Gnome2::Print::Font->find_closest("Sans Serif", 12) );
ok( $font->get_name );

ok( $weight = Gnome2::Print::Font->bold );

use_ok('Gnome2::Print::Font');
ok( $weight = Gnome2::Print::Font->GNOME_FONT_BOLD );

ok( @font_list = Gnome2::Print::Font->list );
ok( @family_list = Gnome2::Print::Font->family_list );
ok( @style_list = Gnome2::Print::Font->style_list($family_list[0]) );

ok( $face = Gnome2::Print::FontFace->find_closest("Sans") );
ok( $face->get_family_name );
($x0, $y0, $x1, $y1) = $face->get_stdbbox;
ok(1);
