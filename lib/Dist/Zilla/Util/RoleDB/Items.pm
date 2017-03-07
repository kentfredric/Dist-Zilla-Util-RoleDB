use 5.006;
use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Items;

our $VERSION = '0.004002';

# ABSTRACT: An aggregate provisioned index of roles

# AUTHORITY

my @items;

=method C<all>

Returns all items in this item set, as a list

    my @entries = $class->all();.

=cut

sub all {
  return @items if @items;
  _add_items();
  return @items;
}

sub _add_items {
  require Dist::Zilla::Util::RoleDB::Items::Core;
  push @items, Dist::Zilla::Util::RoleDB::Items::Core->all;
  require Dist::Zilla::Util::RoleDB::Items::ThirdParty;
  push @items, Dist::Zilla::Util::RoleDB::Items::ThirdParty->all;
  return;
}
1;
