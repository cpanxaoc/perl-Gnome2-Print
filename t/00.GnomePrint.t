#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 2;
BEGIN { use_ok('Gnome2::Print') };

#########################

ok( Gnome2::Print->get_version_info );
