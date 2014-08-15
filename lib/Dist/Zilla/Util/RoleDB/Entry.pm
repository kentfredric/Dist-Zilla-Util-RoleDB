use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::Util::RoleDB::Entry;

our $VERSION = '0.002001';

# ABSTRACT: Extracted meta-data about a role

# AUTHORITY

use Moose qw( has extends );
use MooseX::AttributeShortcuts;

=attr C<name>

Contains the short name for the role, in a form acceptable by C<Dist::Zilla>'s C<plugins_with> method.

e.g:

    -FileGatherer

Because

    zilla->plugins_with(-FileGatherer)

=cut

has name => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[The unprefixed version of the role name, ie: -Foo => DZR::Foo],
);

=attr C<full_name>

Contains the fully qualified version of the role.

For instance, when C<name> is C<-FileGatherer>, C<full_name> will be C<Dist::Zilla::Role::FileGatherer>

=cut

has full_name => (
  isa           => Str =>,
  is            => ro  =>,
  lazy          => 1,
  documentation => q[The fully qualified version of the role name],
  builder       => sub {
    my ($self) = @_;
    my $role_name = $self->name;
    return $role_name unless $role_name =~ /\A-/msx;
    $role_name =~ s{\A-}{Dist::Zilla::Role::}msx;
    return $role_name;
  },
);

=attr C<required_modules>

This contains an C<ArrayRef> of Modules that are required if one ever intends to use the module in C<full_name>.

Note, that this is not intended to be really used. It only exists as a helper in the event one wishes to document
a roles existence in a file other than one matching its name.

For example:


    Foo.pm:

        package Foo;

        use Moose::Role;

        package Bar;

        use Moose::Role;

In such a scenario, one cannot get Bar without C<require Foo>

So here,

    ->new( name => 'Foo' ); # required_modules is automatically [Foo]
    ->new( name => 'Bar', required_modules => ['Foo'] );

Also, if a role has peculiar load order requirements ( like seen in Class::MOP ) that means
certain other libraries must be C<require>'d before C<require>ing the module itself, this would be a convenient place to put such information.

This mechanism is mostly to support C<< $entry->require_module >>

=cut

has required_modules => (
  isa  => 'ArrayRef[Str]' =>,
  is   => ro              =>,
  lazy => 1,
  ## no critic (ProhibitImplicitNewlines)
  documentation => <<'EOF',
A list of things that must be manually require()d for the module to exist.
Note: This should not be needed for anything, as its really only intended
as a way to make hidden packages require()able.
Usually, this will be exactly one item, and it will be the same as the modules name.
EOF
  builder => sub {
    my ($self) = @_;
    return [ $self->full_name ];
  },
);

=method is_phase

Returns false

=cut

sub is_phase { return }

=attr C<description>

Contains a textual description of the Role.

Usually, a copy of the Roles "ABSTRACT" will do the trick.

=cut

has description => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[A text description of the role. A copy of ABSTRACT would be fine],
);

=attr C<deprecated>

If a role is deprecated, setting this may be useful.

=cut

has deprecated => (
  isa           => Bool =>,
  is            => ro   =>,
  lazy          => 1,
  documentation => q[Set this to 1 if this role is deprecated],
  builder       => sub  { return },
);

=method C<require_module>

Load the module itself.

Usually, this just amounts to requiring C<full_name>, but it might not be
in the case somebody has manually modified C<required_modules>

=cut

sub require_module {
  my ($self) = @_;
  require Module::Runtime;
  for my $module ( @{ $self->required_modules } ) {
    Module::Runtime::require_module($module);
  }
  return $self->full_name;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

    use Dist::Zilla::Util::RoleDB::Entry;
    my $entry = Dist::Zilla::Util::RoleDB::Entry->new(
        name => "-FileGatherer",
        description => "A thing that adds files to your dist"
    );

=cut
