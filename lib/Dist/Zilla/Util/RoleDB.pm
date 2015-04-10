use 5.006;
use strict;
use warnings;

package Dist::Zilla::Util::RoleDB;

our $VERSION = '0.003002';

# ABSTRACT: Shared code for things that communicate data about dzil roles.

# AUTHORITY

use Moo qw( has );
use Carp qw( croak );

## no critic (NamingConventions)
my $is_ArrayRef = sub {
  return 'ARRAY' eq ref $_[0] unless $_[1];
  return unless 'ARRAY' eq ref $_[0];
  for ( @{ $_[0] } ) {
    return unless $_[1]->($_);
  }
  1;
};

=attr C<items>

Contains all items in this data set, as an array ref.

=cut

has items => (
  isa => sub {
    $is_ArrayRef->( $_[0], sub { $_[0]->isa('Dist::Zilla::Util::RoleDB::Entry') } ) or croak 'Must be ArrayRef[ RoleDB::Entry ]';
  },
  is      => ro =>,
  lazy    => 1,
  builder => '_build_items',
);

no Moo;

sub _build_items {
  require Dist::Zilla::Util::RoleDB::Items;
  return [ Dist::Zilla::Util::RoleDB::Items->all() ];
}

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

1;

=head1 DESCRIPTION

This utility is a hard-coded list of various known C<Dist::Zilla> roles and their properties.

It's not generally usable by most people, and is more useful for query tools, such as

  dzil dumpphases

Certain entries may have additional markers indicating they are C<phase> roles,
and will have relevant data indicating what methods are invoked in that C<phase>.
