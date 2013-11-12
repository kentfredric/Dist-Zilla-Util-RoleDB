use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Items;
BEGIN {
  $Dist::Zilla::Util::RoleDB::Items::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Util::RoleDB::Items::VERSION = '0.001000';
}

# ABSTRACT: An aggregate pre-provisioned index of roles

my @items;

sub all {
  return @items if @items;
  _add_items();
  return @items;
}

sub _entry {
  my (@args) = @_;
  require Dist::Zilla::Util::RoleDB::Entry;
  push @items, Dist::Zilla::Util::RoleDB::Entry->new(@args);
}

sub _add_entry {
  my ( $name, $description, @extra ) = @_;
  _entry( name => $name, description => $description, @extra );
}

sub _add_phase {
  my ( $name, $description, $phase_method, @extra ) = @_;
  _add_entry( $name, $description, phase_method => $phase_method );
}

sub _add_items {
  require Dist::Zilla::Util::RoleDB::Items::Core;
  push @items, Dist::Zilla::Util::RoleDB::Items::Core->all;

## 3rd Party

  _add_entry( q[-Bootstrap]              => q[Shared logic for bootstrap things.] );
  _add_entry( q[-BundleDeps]             => q[Automatically add all plugins in a bundle as dependencies] );
  _add_entry( q[-Git::DirtyFiles]        => q[provide the allow_dirty & changelog attributes] );
  _add_entry( q[-Git::LocalRepository]   => q[A plugin which works with a local git repository as its Dist::Zilla source.] );
  _add_entry( q[-Git::Remote::Branch]    => q[Parts to enable aggregated specification of remote branches.] );
  _add_entry( q[-Git::Remote::Check]     => q[Check a remote branch is not ahead of a local one] );
  _add_entry( q[-Git::Remote::Update]    => q[Update tracking data for a remote repository] );
  _add_entry( q[-Git::Remote]            => q[Git Remote specification and validation for plugins.] );
  _add_entry( q[-Git::Repo]              => q[Provide repository information for Git plugins] );
  _add_entry( q[-MetaProvider::Provider] => q[A Role for Metadata providers specific to the 'provider' key.] );
  _add_entry( q[-PluginBundle::Config::Slicer] => q[Pass Portions of Bundle Config to Plugins] );
  _add_entry( q[-PluginBundle::PluginRemover]  => q[Add '-remove' functionality to a bundle] );
}
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Util::RoleDB::Items - An aggregate pre-provisioned index of roles

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
