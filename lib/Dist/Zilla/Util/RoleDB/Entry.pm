use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry;

# ABSTRACT: Extracted metadata about a role

use Moose;
use MooseX::AttributeShortcuts;

has name => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[The unprefixed version of the role name, ie: -Foo => DZR::Foo]
);

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
has is_phase => (
  isa           => Bool =>,
  is            => ro   =>,
  lazy          => 1,
  documentation => q[This should be true if the role is a special role for dzil phase control],
  builder       => sub {
    my ($self) = @_;
    if ( $self->has_phase_method ) {
      return 1;
    }
    return;
  }
);
has phase_method => (
  isa           => 'Maybe[Str]'       =>,
  is            => ro                 =>,
  lazy          => 1,
  predicate     => 'has_phase_method' =>,
  documentation => q[If this entry is a phase role, this property should be specified],
  builder       => sub {
    my ($self) = @_;
    return unless $self->is_phase;
    require Carp;
    Carp::croak('phase_method not defined, but is_phase is true');
  },
);
has description => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[A text description of the role. A copy of ABSTRACT would be fine],
);

has deprecated => (
  isa           => Bool =>,
  is            => ro   =>,
  lazy          => 1,
  documentation => q[Set this to 1 if this role is deprecated],
  builder       => sub  { return }
);

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

