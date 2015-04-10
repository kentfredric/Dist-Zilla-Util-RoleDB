use 5.006;
use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry::Phase;

our $VERSION = '0.003002';

# ABSTRACT: Extracted meta-data about a role that represents a phase

# AUTHORITY

use Moo qw( has extends );
use Carp qw( croak );

## no critic (NamingConventions)
my $is_Str = sub { 'SCALAR' eq ref \$_[0] or 'SCALAR' eq ref \( my $val = $_[0] ) };

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
  isa => sub { $is_Str->( $_[0] ) or croak 'phase_method must be a Str' },
  is            => ro =>,
  required      => 1,
  documentation => q[The method dzil calls on the phase],
);

no Moo;
1;

