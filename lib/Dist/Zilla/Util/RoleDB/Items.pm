use strict;
use warnings;

package Dist::Zilla::Util::RoleDB::Items;

# ABSTRACT: An aggregate pre-provisioned index of roles

my @items;

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
