use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry;

# ABSTRACT: Extracted metadata about a role

use Moose;
use MooseX::AttributeShortcuts;

=attr C<name>

=cut

has name => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[The unprefixed version of the role name, ie: -Foo => DZR::Foo]
);

=attr C<full_name>

=cut

has full_name => (
  isa           => Str =>,
  is            => ro  =>,
  lazy          => 1,
  documentation => q[The fully qualified version of the role name],
  builder       => sub {
    my ($self) = @_;
    my $role_name = $self->name;
    return $role_name unless $role_name =~ /\A-/msx;
    $role_name =~ s{\A-}{Dist::Zilla::Role::}msx;
    return $role_name;
  }
);

=attr C<required_modules>

=cut

has required_modules => (
  isa           => 'ArrayRef[Str]' =>,
  is            => ro              =>,
  lazy          => 1,
  documentation => q[
        A list of things that must be manually require()d for the module to exist.
        Note: This should not be needed for anything, as its really only intended
        as a way to make hidden packages require()able.
        Usually, this will be exactly one item, and it will be the same as the modules name.
    ],
  builder => sub {
    my ($self) = @_;
    return [ $self->full_name ];
  },
);

sub is_phase { return }

=attr C<description>

=cut

has description => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[A text description of the role. A copy of ABSTRACT would be fine],
);

=attr C<deprecated>

=cut

has deprecated => (
  isa           => Bool =>,
  is            => ro   =>,
  lazy          => 1,
  documentation => q[Set this to 1 if this role is deprecated],
  builder       => sub  { return }
);

=method C<require_module>

=cut

sub require_module {
  my ($self) = @_;
  require Module::Runtime;
  for my $module ( @{ $self->required_modules } ) {
    Module::Runtime::require_module($module);
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

