#
# $Header$
#

use 5.008;
use Cwd;
use File::Spec;
use ExtUtils::MakeMaker;

# minimum required version of dependancies we need to build
our %build_reqs = (
	'perl-ExtUtils-Depends'   => '0.1',
	'perl-ExtUtils-PkgConfig' => '0.1',
	'perl-Glib'               => '1.00rc1',
	'perl-Gtk2'               => '1.00rc1',
	'GnomePrint'              => '2.2.0.0',
);

# minimum required version of dependancies we need to run
our %runtime_reqs = (
	'GnomePrint'	=> undef,
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
           . "1") {
   warn "$@\n";
   WriteMakefile(
         PREREQ_FATAL => 1,
         PREREQ_PM    => {
            Glib::                => $build_reqs{'perl-Glib'},
            Gtk2::                => $build_reqs{'perl-Gtk2'},
            ExtUtils::Depends::   => $build_reqs{'perl-ExtUtils-Depends'},
            ExtUtils::PkgConfig:: => $build_reqs{'perl-ExtUtils-PkgConfig'},
         },
   );
   exit 1; # not reached
}

%pkgcfg = ExtUtils::PkgConfig->find ('libgnomeprintui-2.2 >= '
				     .$build_reqs{GnomePrint});

$runtime_reqs{GnomePrint} = $pkgcfg{modversion};

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
    'Print.pm'		=> '$(INST_MAN3DIR)/Gnome2::Print.$(MAN3EXT)',
    'pm/Config.pm'	=> '$(INST_MAN3DIR)/Gnome2::Print::Config.$(MAN3EXT)',
    'pm/Font.pm'	=> '$(INST_MAN3DIR)/Gnome2::Print::Font.$(MAN3EXT)',
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
use Cwd;

sub const_cccmd {
	my $inherited = shift->SUPER::const_cccmd (@_);
	$inherited .= ' -o $@';
	$inherited;
}

sub postamble
{
	my @dirs = qw{rpms rpms/BUILD rpms/RPMS rpms/SOURCES
		      rpms/SPECS rpms/SRPMS};
	my $cwd = getcwd();
	
	my %subs = (
		'VERSION' => '$(VERSION)',
		'SOURCE' => '$(DISTNAME)-$(VERSION).tar.gz',
		'GNOMEPRINT_RUN' => $runtime_reqs{'GnomePrint'},
		'GNOMEPRINT' => $build_reqs{'GnomePrint'},
		'PERL_EXTUTILS_DEPENDS' => 
			$build_reqs{'perl-ExtUtils-Depends'},
		'PERL_EXTUTILS_PKGCONFIG' => 
			$build_reqs{'perl-ExtUtils-PkgConfig'},
		'PERL_GLIB' => $build_reqs{'perl-Glib'},
		'PERL_GTK' => $build_reqs{'perl-Gtk2'},
	);
	
	my $substitute = '$(PERL) -npe \''.join('; ', map {
			"s/\\\@$_\\\@/$subs{$_}/g";
		} keys %subs).'\'';

	"
realclean ::
	-\$(RM_RF) build perl-\$(DISTNAME).spec

rpms/:
	-mkdir @dirs

SUBSTITUTE=$substitute

perl-\$(DISTNAME).spec: perl-\$(DISTNAME).spec.in \$(VERSION_FROM) Makefile
	\$(SUBSTITUTE) \$< > \$@

dist-rpms: Makefile dist perl-\$(DISTNAME).spec rpms/
	cp \$(DISTNAME)-\$(VERSION).tar.gz rpms/SOURCES/
	rpmbuild -ba --define \"_topdir $cwd/rpms\" perl-\$(DISTNAME).spec
"
}
package MAIN;
