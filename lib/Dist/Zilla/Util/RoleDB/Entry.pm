use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Entry;
BEGIN {
  $Dist::Zilla::Util::RoleDB::Entry::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::Util::RoleDB::Entry::VERSION = '0.001000';
}

# ABSTRACT: Extracted metadata about a role

use Moose;
use MooseX::AttributeShortcuts;


has name => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[The unprefixed version of the role name, ie: -Foo => DZR::Foo]
);


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
  }
);


has required_modules => (
  isa           => 'ArrayRef[Str]' =>,
  is            => ro              =>,
  lazy          => 1,
  documentation => q[
        A list of things that must be manually require()d for the module to exist.
        Note: This should not be needed for anything, as its really only intended
        as a way to make hidden packages require()able.
        Usually, this will be exactly one item, and it will be the same as the modules name.
    ],
  builder => sub {
    my ($self) = @_;
    return [ $self->full_name ];
  },
);

sub is_phase { return }


has description => (
  isa           => Str =>,
  is            => ro  =>,
  required      => 1,
  documentation => q[A text description of the role. A copy of ABSTRACT would be fine],
);


has deprecated => (
  isa           => Bool =>,
  is            => ro   =>,
  lazy          => 1,
  documentation => q[Set this to 1 if this role is deprecated],
  builder       => sub  { return }
);


sub require_module {
  my ($self) = @_;
  require Module::Runtime;
  for my $module ( @{ $self->required_modules } ) {
    Module::Runtime::require_module($module);
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Util::RoleDB::Entry - Extracted metadata about a role

=head1 VERSION

version 0.001000

=head1 METHODS

=head2 C<require_module>

=head1 ATTRIBUTES

=head2 C<name>

=head2 C<full_name>

=head2 C<required_modules>

=head2 C<description>

=head2 C<deprecated>

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
