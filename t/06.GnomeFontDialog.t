#########################
# GnomePrint2 Tests
#       - ebb
#########################

#########################

use Test::More tests => 13;
BEGIN { use_ok('Gnome2::Print') };

#########################

use Gtk2;
Gtk2->init;

ok( $dialog = Gnome2::Print::FontDialog->new("test font dialog") );
$dialog->signal_connect(response => sub {
		ok( $_[1] == -5 );
		1;
	});

$dialog->show_all;
ok(1);

ok( $selection = $dialog->get_fontsel );
ok( $selection->get_face );
ok( $selection->get_size );
ok( $font = $selection->get_font );
$selection->set_font($font);
ok(1);

ok( $preview = $dialog->get_preview );
$preview->set_phrase("Just Another Perl Hacker");
ok(1);
$preview->set_font($font);
ok(1);

$dialog->hide;
Glib::Idle->add( sub {
		$dialog->response('ok');
		Gtk2->main_quit;
		0;
	});

Gtk2->main;
ok(1);
