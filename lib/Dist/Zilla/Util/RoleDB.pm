use strict;
use warnings;

package Dist::Zilla::Util::RoleDB;

# ABSTRACT: Shared code for things that communicate data about C<dzil> roles.

use Moose;
use MooseX::AttributeShortcuts;

has items => (
  isa     => 'ArrayRef[Dist::Zilla::Util::RoleDB::Entry]',
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    my ($self) = @_;
    require Dist::Zilla::Util::RoleDB::Items;
    return [ Dist::Zilla::Util::RoleDB::Items::all() ];
  },
);

sub roles {
  my ($self) = @_;
  return @{ $self->items };
}

sub phases {
  my ($self) = @_;
  return grep { $_->is_phase } @{ $self->items };
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
