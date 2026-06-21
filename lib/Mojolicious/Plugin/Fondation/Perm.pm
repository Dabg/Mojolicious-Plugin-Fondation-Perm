package Mojolicious::Plugin::Fondation::Perm;
use Mojo::Base 'Mojolicious::Plugin', -signatures;
use DBIx::Class::Relationship::ManyToMany::Async;

# ABSTRACT: Permission management plugin for Fondation

our $VERSION = '0.01';

sub fondation_meta {
    return {
        dependencies => [
            'Fondation::Model::DBIx::Async',
            ],
        defaults => {
            title           => 'Permission Management',
            openapi_exclude => ['GroupPerm'],
            models          => {
                perm => {
                    source  => 'Perm',
                    backend => undef,  # must be set in app config
                },
                group_perm => {
                    source  => 'GroupPerm',
                    backend => undef,  # must be set in app config
                },
            },
        },
    };
}

sub register ($self, $app, $conf) {
    return $self;
}

sub fondation_finalyze ($self, $app, $long_name) {
    my $registry = $app->fondation->registry;

    # Only establish perm↔group relation if Group plugin is loaded
    if ($registry->{'Mojolicious::Plugin::Fondation::Group'}) {
        many_to_many_async('Mojolicious::Plugin::Fondation::Perm::Schema::Result::Perm',  'groups', 'group_perm', 'group');
        many_to_many_async('Mojolicious::Plugin::Fondation::Group::Schema::Result::Group', 'perms',  'group_perm', 'perm');
    }

    return 1;
}

1;
