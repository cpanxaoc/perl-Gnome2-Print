#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 3;
BEGIN { use_ok('Gnome2::Print') };

#########################

use Data::Dumper;

ok( $default_page = Gnome2::Print::Paper->get_default );
ok( $a4_page = Gnome2::Print::Paper->get_by_name ('A4') );

#print Dumper $default_page;
#print Dumper $a4_page;
