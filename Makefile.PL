#
# $Header$
#

use 5.008;
use strict;
use warnings;
use Cwd;
use File::Spec;
use ExtUtils::MakeMaker;

# minimum required version of dependancies we need to build
our %build_reqs = (
	'perl-ExtUtils-Depends'   => '0.1',
	'perl-ExtUtils-PkgConfig' => '0.1',
	'perl-Glib'               => '1.020',
	'perl-Gtk2'               => '1.020',
	'GnomePrint'              => '2.2.0.0',
);

# Writing a fake Makefile ensures that CPAN will pick up the correct
# dependencies and install them.
unless (eval "use ExtUtils::Depends;"
           . "use ExtUtils::PkgConfig;"
	   . "use Gtk2::CodeGen;"
           # just seeing if Glib is available isn't enough, make sure
           # it's recent enough, too 
           . "use Glib '$build_reqs{'perl-Glib'}';"
           . "use Gtk2 '$build_reqs{'perl-Gtk2'}';"
           . "use Glib::MakeHelper;"
           . "1") {
   warn "$@\n";
   WriteMakefile(
         PREREQ_FATAL => 1,
         PREREQ_PM    => {
            'Glib'                => $build_reqs{'perl-Glib'},
            'Gtk2'                => $build_reqs{'perl-Gtk2'},
            'ExtUtils::Depends'   => $build_reqs{'perl-ExtUtils-Depends'},
            'ExtUtils::PkgConfig' => $build_reqs{'perl-ExtUtils-PkgConfig'},
         },
   );
   exit 1; # not reached
}

mkdir 'build', 0777;

our %pkgcfg = ExtUtils::PkgConfig->find ('libgnomeprintui-2.2 >= '
				     .$build_reqs{GnomePrint});

#
# autogeneration
#
Gtk2::CodeGen->parse_maps ('gnomeprintperl');
Gtk2::CodeGen->write_boot (ignore => '^Gnome2::Print$');

# now we're ready to start creating the makefile.
# we need to use ExtUtils::Depends to get relevant information out of
# the Glib extension, and to save config information for other modules which
# will chain from this one.

our @xs_files = <xs/*.xs>;
our %pm_files = (
    'Print.pm'		=> '$(INST_LIBDIR)/Print.pm',
    'pm/Config.pm'	=> '$(INST_LIBDIR)/Print/Config/Constants.pm',
    'pm/Font.pm'	=> '$(INST_LIBDIR)/Print/Font/Constants.pm',
);
our %pod_files = (
    'Print.pm'		=> '$(INST_MAN3DIR)/Gnome2::Print.$(MAN3EXT)',
    'pm/Config.pm'	=> '$(INST_MAN3DIR)/Gnome2::Print::Config::Constants.$(MAN3EXT)',
    'pm/Font.pm'	=> '$(INST_MAN3DIR)/Gnome2::Print::Font::Constants.$(MAN3EXT)',
    Glib::MakeHelper->do_pod_files (@xs_files),
);

open VERSION, ">build/gnomeprintperl-version.h";

my $stem = "GNOMEPRINT";
my @modversion = split /\./, $pkgcfg{ modversion };
print VERSION "#define $stem\_MAJOR_VERSION   ($modversion[0])\n";
print VERSION "#define $stem\_MINOR_VERSION   ($modversion[1])\n";
print VERSION "#define $stem\_MICRO_VERSION   (" . ($modversion[2] || 0) . ")\n";
print VERSION
    "#define $stem\_CHECK_VERSION(major,minor,micro) \\\n"
  . "    ($stem\_MAJOR_VERSION > (major) || \\\n"
  . "     ($stem\_MAJOR_VERSION == (major) && $stem\_MINOR_VERSION > (minor)) || \\\n"
  . "     ($stem\_MAJOR_VERSION == (major) && $stem\_MINOR_VERSION == (minor) && \\\n"
  . "      $stem\_MICRO_VERSION >= (micro)))\n";

close VERSION;

my $gnomeprint2 = ExtUtils::Depends->new ('Gnome2::Print', 'Gnome2', 'Gnome2::VFS', 'Gtk2', 'Glib');
$gnomeprint2->set_inc ($pkgcfg{cflags} . ' -I. -I./build ');
$gnomeprint2->set_libs ($pkgcfg{libs});
$gnomeprint2->add_xs (@xs_files);
$gnomeprint2->add_pm (%pm_files);
my $cwd = cwd();
$gnomeprint2->add_typemaps (map {File::Spec->catfile($cwd,$_)} 'build/gnomeprintperl.typemap');
$gnomeprint2->add_headers ('gnomeprintperl.h');
$gnomeprint2->install (qw(gnomeprintperl.h
		build/gnomeprintperl-autogen.h
		build/gnomeprintperl-version.h));
$gnomeprint2->save_config ('build/IFiles.pm');

WriteMakefile(
    NAME          => 'Gnome2::Print',
    VERSION_FROM  => 'Print.pm', # finds $VERSION
    PREREQ_PM     => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM => 'Print.pm', # retrieve abstract from module
    XSPROTOARG    => '-noprototypes',
    MAN3PODS	  => \%pod_files,
    $gnomeprint2->get_makefile_vars,
);

#
# there's a bug in the MakeMaker output which results in .xs files in a
# subdirectory being turned into .o files in this dir.  the bug is a missing
# -o on the compiler command line.  this is a hackish fix for it.
#
package MY;
use Cwd;

sub const_cccmd {
	my $inherited = shift->SUPER::const_cccmd (@_);
	$inherited .= ' -o $@';
	$inherited;
}

sub postamble
{
	return Glib::MakeHelper->postamble_clean ()
	     . Glib::MakeHelper->postamble_docs (@main::xs_files)
	     . Glib::MakeHelper->postamble_rpms (
		'GNOMEPRINT' => $build_reqs{'GnomePrint'},
		'PERL_EXTUTILS_DEPENDS' => 
			$build_reqs{'perl-ExtUtils-Depends'},
		'PERL_EXTUTILS_PKGCONFIG' => 
			$build_reqs{'perl-ExtUtils-PkgConfig'},
		'PERL_GLIB' => $build_reqs{'perl-Glib'},
		'PERL_GTK' => $build_reqs{'perl-Gtk2'},
	       );
}
package MAIN;
