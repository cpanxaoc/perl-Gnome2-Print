#
# $Header$
#

package Gnome2::Print;

use 5.008;
use strict;
use warnings;

use Gtk2;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Gnome2::Print ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.5';

sub dl_load_flags { 0x01 }

require XSLoader;
XSLoader::load('Gnome2::Print', $VERSION);

# Preloaded methods go here.

1;
__END__
=head1 NAME

Gnome2::Print - Perl wrappers for the Gnome Print utilities.

=head1 SYNOPSIS

  use Gnome2::Print;

  my $job = Gnome2::Print::Job->new;
  my $config = $job->get_config;
  my $pc = $job->get_context;

  my ($width, $height) = $config->get_page_size;
  
  $pc->beginpage("1");
  
  $pc->setlinewidth(3.0);
  $pc->rect_stroked($width * .1, $height * .1, $width * .9, $height * .9);
  
  $pc->showpage;
  
  $job->render($pc);
  $job->close;

=head1 ABSTRACT

  Perl bindings to the 2.2 series of the Gnome Print libraries,
  for use with gtk2-perl.

=head1 DESCRIPTION

This module allows you to use the GNOME Print libraries within your
applications written using the gtk2-perl wrapper.  The GNOME Print libraries
(also known as libgnomeprint and libgnomeprintui) allow you to create
printable documents (using various frontends) and offer standard widgets in
order to mainatin a UI consistent for all GNOME applications.

To discuss gtk2-perl, ask questions and flame/praise the authors,
join gtk-perl-list@gnome.org at lists.gnome.org.

Find out more about Gnome+ at http://www.gnome.org.

=head1 SEE ALSO

perl(1), Glib(3pm), Gtk2(3pm), Gnome2(3pm).

=head1 AUTHOR

Emmanuele Bassi E<lt>emmanuele.bassi@iol.itE<gt>,
muppet E<lt>scott at asofyet dot orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Emmanuele Bassi

Copyright 2003 by muppet

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
