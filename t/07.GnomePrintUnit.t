#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 5;
BEGIN { use_ok('Gnome2::Print') };

#########################

ok( $default_unit = Gnome2::Print::Unit->get_default );
ok( $inch_unit = Gnome2::Print::Unit->get_by_name("Inch") );
ok( $point_unit = Gnome2::Print::Unit->get_by_abbreviation("pt") );

ok( $unit = Gnome2::Print::Unit->get_identity ($default_unit->base) );
