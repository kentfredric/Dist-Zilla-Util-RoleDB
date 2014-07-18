use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry::Phase;
$Dist::Zilla::Util::RoleDB::Entry::Phase::VERSION = '0.001001';
# ABSTRACT: Extracted meta-data about a role that represents a phase

use Moose;
use MooseX::AttributeShortcuts;

extends 'Dist::Zilla::Util::RoleDB::Entry';







sub is_phase {
  return 1;
}







has phase_method => (
  isa           => 'Str' =>,
  is            => ro    =>,
  required      => 1,
  documentation => q[The method dzil calls on the phase],
);

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Util::RoleDB::Entry::Phase - Extracted meta-data about a role that represents a phase

=head1 VERSION

version 0.001001

=head1 METHODS

=head2 C<is_phase>

Returns true.

=head1 ATTRIBUTES

=head2 C<phase_method>

Returns the method C<Dist::Zilla> calls to implement this phase

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
