use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::Util::RoleDB;

our $VERSION = '0.002001';

# ABSTRACT: Shared code for things that communicate data about dzil roles.

# AUTHORITY

use Moose qw( has );
use MooseX::AttributeShortcuts;

=attr C<items>

Contains all items in this data set, as an array ref.

=cut

has items => (
  isa     => 'ArrayRef[Dist::Zilla::Util::RoleDB::Entry]',
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    require Dist::Zilla::Util::RoleDB::Items;
    return [ Dist::Zilla::Util::RoleDB::Items->all() ];
  },
);

=method C<roles>

Returns a list of all roles in the database, sorted by name.

=cut

sub roles {
  my ($self) = @_;
  return @{ [ sort { $a->name cmp $b->name } @{ $self->items } ] };
}

=method C<phases>

Returns a list of all roles that are also phases, sorted by name.

=cut

sub phases {
  my ($self) = @_;
  return @{ [ sort { $a->name cmp $b->name } grep { $_->is_phase } @{ $self->items } ] };
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
