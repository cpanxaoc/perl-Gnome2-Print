#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 5;
BEGIN { use_ok('Gnome2::Print') };

#########################

use Gtk2;
Gtk2->init;

$config = Gnome2::Print::Config->default;
$job = Gnome2::Print::Job->new($config);

ok( $dialog = Gnome2::Print::Dialog->new($job, "Test", 0) );

$dialog->signal_connect(response => sub {
		ok( $_[1] == 1 );
		1;
	});

$dialog->show_all;
ok(1);

Glib::Idle->add( sub {
		$dialog->response(1);
		Gtk2->main_quit;
		0;
	});

Gtk2->main;
ok(1);
