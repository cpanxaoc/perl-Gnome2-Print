#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 2;
use_ok('Gnome2::Print');

#########################

is( scalar (@{ [Gnome2::Print->get_version_info] }), 3 );
