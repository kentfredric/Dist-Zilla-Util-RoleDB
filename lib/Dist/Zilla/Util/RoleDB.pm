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
  return @{ $self->items };
}

sub phases {
  my ($self) = @_;
  return grep { $_->is_phase } @{ $self->items };
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

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
