#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 4;
BEGIN { use_ok('Gnome2::Print') };

#########################

ok( $config = Gnome2::Print::Config->default );
ok( $key_paper_size = Gnome2::Print::Config->key_paper_size );
ok( $config->get($key_paper_size) );
