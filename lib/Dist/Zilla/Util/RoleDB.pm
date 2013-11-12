use strict;
use warnings;

package Dist::Zilla::Util::RoleDB;
BEGIN {
  $Dist::Zilla::Util::RoleDB::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Util::RoleDB::VERSION = '0.001000';
}

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
  return ( my @list = sort { $a->name cmp $b->name } @{ $self->items } );
}


sub phases {
  my ($self) = @_;
  return ( my @list = sort { $a->name cmp $b->name } grep { $_->is_phase } @{ $self->items } );
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Util::RoleDB - Shared code for things that communicate data about C<dzil> roles.

=head1 VERSION

version 0.001000

=head1 METHODS

=head2 C<roles>

Returns a list of all roles in the database, sorted by name.

=head2 C<phases>

Returns a list of all roles that are also phases, sorted by name.

=head1 ATTRIBUTES

=head2 C<items>

Contains all items in this data set, as an array ref.

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
