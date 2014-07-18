use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::Util::RoleDB::Items;

our $VERSION = '0.002000';

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
