#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 4;
BEGIN { use_ok('Gnome2::Print') };

#########################

ok( $default_unit = Gnome2::Print::Unit->get_default );
ok( $pixel_unit = Gnome2::Print::Unit->get_by_name("Inch") );

ok( $distance = $default_unit->convert_distance($pixel_unit) );
