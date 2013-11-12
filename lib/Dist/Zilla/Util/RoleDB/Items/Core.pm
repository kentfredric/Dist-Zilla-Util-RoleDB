use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Items::Core;
BEGIN {
  $Dist::Zilla::Util::RoleDB::Items::Core::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Util::RoleDB::Items::Core::VERSION = '0.001000';
}

require Dist::Zilla::Util::RoleDB::Entry;

my @items;

sub all {
  return @items;
}

sub _entry {
  my (@args) = @_;
  push @items, Dist::Zilla::Util::RoleDB::Entry->new(@args);
}

_entry(
  name         => q[-AfterBuild] =>,
  description  => q[something that runs after building is mostly complete],
  phase_method => 'after_build'
);
_entry(
  name         => q[-AfterMint] =>,
  description  => q[something that runs after minting is mostly complete],
  phase_method => 'after_mint'
);
_entry(
  name         => q[-AfterRelease] =>,
  description  => q[something that runs after release is mostly complete],
  phase_method => 'after_release'
);
_entry(
  name         => q[-BeforeArchive] =>,
  description  => q[something that runs before the archive file is built],
  phase_method => 'before_archive',
);
_entry(
  name         => q[-BeforeBuild] =>,
  description  => q[something that runs before building really begins],
  phase_method => 'before_build',
);
_entry(
  name         => q[-BeforeMint] =>,
  description  => q[something that runs before minting really begins],
  phase_method => 'before_mint'
);
_entry(
  name         => q[-BeforeRelease] =>,
  description  => q[something that runs before release really begins],
  phase_method => 'before_release',
);
_entry( name => q[-BuildPL] =>, description => q[Common ground for Build.PL based builders] );
_entry(
  name         => q[-BuildRunner] =>,
  description  => q[something used as a delegating agent during 'dzil run'],
  phase_method => 'build'
);
_entry( name => q[-Chrome]       =>, description => q[something that provides a user interface for Dist::Zilla] );
_entry( name => q[-ConfigDumper] =>, description => q[something that can dump its (public, simplified) configuration] );
_entry(
  name         => q[-EncodingProvider] =>,
  description  => q[something that sets a files' encoding],
  phase_method => 'set_file_encoding',
);
_entry( name => q[-ExecFiles]      =>, description => q[something that finds files to install as executables] );
_entry( name => q[-FileFinderUser] =>, description => q[something that uses FileFinder plugins] );
_entry( name => q[-FileFinder]     =>, description => q[something that finds files within the distribution] );
_entry(
  name         => q[-FileGatherer] =>,
  description  => q[something that gathers files into the distribution],
  phase_method => 'gather_files'
);
_entry( name => q[-FileInjector] =>, description => q[something that can add files to the distribution] );
_entry(
  name         => q[-FileMunger] =>,
  description  => q[something that alters a file's destination or content],
  phase_method => 'munge_files'
);
_entry(
  name         => q[-FilePruner] =>,
  description  => q[something that removes found files from the distribution],
  phase_method => prune_files =>
);
_entry( name => q[-File] =>, description => q[something that can act like a file] );
_entry(
  name         => q[-InstallTool] =>,
  description  => q[something that creates an install program for a dist],
  phase_method => 'setup_installer',
);
_entry(
  name         => q[-LicenseProvider] =>,
  description  => q[something that provides a license for the dist],
  phase_method => 'provide_license',
);
_entry(
  name         => q[-MetaProvider] =>,
  description  => q[something that provides metadata (for META.yml/json)],
  phase_method => 'metadata',
);
_entry( name => q[-MintingProfile::ShareDir] =>, description => q[something that keeps its minting profile in a sharedir] );
_entry(
  name         => q[-MintingProfile] =>,
  description  => q[something that can find a minting profile dir],
  phase_method => 'profile_dir',
);
_entry(
  name         => q[-ModuleMaker] =>,
  description  => q[something that injects module files into the dist],
  phase_method => 'make_module',
);
_entry( name => q[-MutableFile] =>, description => q[something that can act like a file with changeable contents] );
_entry(
  name         => q[-NameProvider] =>,
  description  => q[something that provides a name for the dist],
  phase_method => 'provide_name',
);
_entry( name => q[-PPI] =>, description => q[a role for plugins which use PPI] );
_entry( name => q[-PluginBundle::Easy] =>, description => q[something that bundles a bunch of plugins easily] );
_entry(
  name         => q[-PluginBundle] =>,
  description  => q[something that bundles a bunch of plugins],
  phase_method => 'bundle_config',
);
_entry( name => q[-Plugin] =>, description => q[something that gets plugged in to Dist::Zilla] );
_entry(
  name         => q[-PrereqSource] =>,
  description  => q[something that registers prerequisites],
  phase_method => 'register_prereqs',
);
_entry(
  name         => q[-Releaser] =>,
  description  => q[something that makes a release of the dist],
  phase_method => 'release',
);
_entry(
  name         => q[-ShareDir] =>,
  description  => q[something that picks a directory to install as shared files],
  phase_method => 'share_dir_map',
);
_entry( name => q[-Stash::Authors] =>, description => q[a stash that provides a list of author strings] );
_entry( name => q[-Stash::Login]   =>, description => q[a stash with username/password credentials] );
_entry( name => q[-Stash]          =>, description => q[something that stores options or data for later reference] );
_entry( name => q[-StubBuild]      =>, description => q[provides an empty BUILD methods] );
_entry(
  name         => q[-TestRunner] =>,
  description  => q[something used as a delegating agent to 'dzil test'],
  phase_method => 'test',
);
_entry( name => q[-TextTemplate] =>, description => q[something that renders a Text::Template template string] );
_entry(
  name         => q[-VersionProvider] =>,
  description  => q[something that provides a version number for the dist],
  phase_method => 'provide_version',
);

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Util::RoleDB::Items::Core

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
