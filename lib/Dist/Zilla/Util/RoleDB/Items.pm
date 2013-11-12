use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Items;
BEGIN {
  $Dist::Zilla::Util::RoleDB::Items::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Util::RoleDB::Items::VERSION = '0.001000';
}

require Dist::Zilla::Util::RoleDB::Entry;
require Dist::Zilla::Util::RoleDB::Items::Core;

my @items;

sub all {
  return @items;
}

sub _entry {
  my (@args) = @_;
  push @items, Dist::Zilla::Util::RoleDB::Entry->new(@args);
}


push @items, Dist::Zilla::Util::RoleDB::Items::Core->all;

## 3rd Party

_entry( name => q[-Bootstrap]       =>, description => q[Shared logic for bootstrap things.] );
_entry( name => q[-BundleDeps]      =>, description => q[Automatically add all plugins in a bundle as dependencies] );
_entry( name => q[-Git::DirtyFiles] =>, description => q[provide the allow_dirty & changelog attributes] );
_entry(
  name        => q[-Git::LocalRepository] =>,
  description => q[A plugin which works with a local git repository as its Dist::Zilla source.]
);
_entry( name => q[-Git::Remote::Branch]    =>, description => q[Parts to enable aggregated specification of remote branches.] );
_entry( name => q[-Git::Remote::Check]     =>, description => q[Check a remote branch is not ahead of a local one] );
_entry( name => q[-Git::Remote::Update]    =>, description => q[Update tracking data for a remote repository] );
_entry( name => q[-Git::Remote]            =>, description => q[Git Remote specification and validation for plugins.] );
_entry( name => q[-Git::Repo]              =>, description => q[Provide repository information for Git plugins] );
_entry( name => q[-MetaProvider::Provider] =>, description => q[A Role for Metadata providers specific to the 'provider' key.] );
_entry( name => q[-PluginBundle::Config::Slicer] =>, description => q[Pass Portions of Bundle Config to Plugins] );
_entry( name => q[-PluginBundle::PluginRemover]  =>, description => q[Add '-remove' functionality to a bundle] );

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Util::RoleDB::Items

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
