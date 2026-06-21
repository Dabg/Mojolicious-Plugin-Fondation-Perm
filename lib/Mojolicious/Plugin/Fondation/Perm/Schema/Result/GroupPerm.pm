package Mojolicious::Plugin::Fondation::Perm::Schema::Result::GroupPerm;

# ABSTRACT: DBIx::Class Result class for group_perm pivot table

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/TimeStamp Core/);

__PACKAGE__->table('group_perm');

__PACKAGE__->add_columns(
    id       => { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
    group_id => { data_type => 'integer', is_nullable => 0 },
    perm_id  => { data_type => 'integer', is_nullable => 0 },

    created_at => { data_type => 'datetime', is_nullable => 0, set_on_create => 1, set_on_update => 1 },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    'perm',
    'Mojolicious::Plugin::Fondation::Perm::Schema::Result::Perm',
    'perm_id',
);

1;
