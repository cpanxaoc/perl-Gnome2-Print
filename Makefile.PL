#
# $Header$
#

use 5.008;
use Cwd;
use File::Spec;
use ExtUtils::MakeMaker;
use ExtUtils::Depends;
use Glib::PkgConfig;
use Gtk2::CodeGen;


%pkgcfg = Glib::PkgConfig->find ('libgnomeprintui-2.2');

mkdir 'build', 0777;

#
# autogeneration
#
Gtk2::CodeGen->parse_maps ('gnomeprintperl');
Gtk2::CodeGen->write_boot (ignore => '^Gnome2::Print$');

# now we're ready to start creating the makefile.
# we need to use ExtUtils::Depends to get relevant information out of
# the Glib extension, and to save config information for other modules which
# will chain from this one.

my %pm_files = (
    'Print.pm'		=> '$(INST_LIBDIR)/Print.pm',
    'pm/Config.pm'	=> '$(INST_LIBDIR)/Print/Config.pm',
    'pm/Font.pm'	=> '$(INST_LIBDIR)/Print/Font.pm',
);

my %pod_files = (
    'Print.pm'		=> '$(INST_MAN3DIR)/Print.$(MAN3EXT)',
    'pm/Config.pm'	=> '$(INST_MAN3DIR)/Print::Config.$(MAN3EXT)',
    'pm/Font.pm'	=> '$(INST_MAN3DIR)/Print::Font.$(MAN3EXT)',
);

$gnomeprint2 = ExtUtils::Depends->new ('Gnome2::Print', 'Gnome2', 'Gtk2', 'Glib');
$gnomeprint2->set_inc ($pkgcfg{cflags} . ' -I. -I./build ');
$gnomeprint2->set_libs ($pkgcfg{libs});
$gnomeprint2->add_xs (<xs/*.xs>);
$gnomeprint2->add_pm (%pm_files);
my $cwd = cwd();
$gnomeprint2->add_typemaps (map {File::Spec->catfile($cwd,$_)} 'build/gnomeprintperl.typemap');
$gnomeprint2->add_headers ('gnomeprintperl.h');

$gnomeprint2->install (qw(gnomeprintperl.h build/gnomeprintperl-autogen.h));
$gnomeprint2->save_config ('build/IFiles.pm');

WriteMakefile(
    NAME          => 'Gnome2::Print',
    VERSION_FROM  => 'Print.pm', # finds $VERSION
    PREREQ_PM     => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM => 'Print.pm', # retrieve abstract from module
    XSPROTOARG    => '-noprototypes',
    MAN3PODS	  => \%pod_files,
    $gnomeprint2->get_makefile_vars,
    DEFINE        => '-DLIBGNOMEPRINT_VER=\"' . $pkgcfg{modversion} .'\"',
);

#
# there's a bug in the MakeMaker output which results in .xs files in a
# subdirectory being turned into .o files in this dir.  the bug is a missing
# -o on the compiler command line.  this is a hackish fix for it.
#
package MY;
sub const_cccmd {
	my $inherited = shift->SUPER::const_cccmd (@_);
	$inherited .= ' -o $@';
	$inherited;
}

sub postamble
{
	"
realclean ::
	-rm -Rf build
"
}
package MAIN;
