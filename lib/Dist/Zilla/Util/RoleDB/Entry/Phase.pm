use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry::Phase;

our $VERSION = '0.002000';

# ABSTRACT: Extracted meta-data about a role that represents a phase

# AUTHORITY

use Moose;
use MooseX::AttributeShortcuts;

extends 'Dist::Zilla::Util::RoleDB::Entry';

=method C<is_phase>

Returns true.

=cut

sub is_phase {
  return 1;
}

=attr C<phase_method>

Returns the method C<Dist::Zilla> calls to implement this phase

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

