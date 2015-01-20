use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::Util::RoleDB;

our $VERSION = '0.002002';

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

=head1 DESCRIPTION

This utility is a hard-coded list of various known C<Dist::Zilla> roles and their properties.

It's not generally usable by most people, and is more useful for query tools, such as

  dzil dumpphases

Certain entries may have additional markers indicating they are C<phase> roles,
and will have relevant data indicating what methods are invoked in that C<phase>.
