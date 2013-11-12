use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry::Phase;

# ABSTRACT: Extracted metadata about a role that represents a phase

use Moose;
use MooseX::AttributeShortcuts;

extends 'Dist::Zilla::Util::RoleDB::Entry';

=attr C<is_phase>

=cut

sub is_phase {
  return 1;
}

=attr C<phase_method>

=cut

has phase_method => (
  isa           => 'Str' =>,
  is            => ro    =>,
  required      => 1,
  documentation => q[The method dzil calls on the phase],
);

no Moose;
__PACKAGE__->meta->make_immutable;
1;

