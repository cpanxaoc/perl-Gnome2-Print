#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 2;
BEGIN { use_ok('Gnome2::Print') };

#########################

ok( $config = Gnome2::Print::Config->default );
