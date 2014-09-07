package Exobrain::Agent::Strava;
use Moose::Role;
use WebService::Strava;
use Method::Signatures;
use Date::Manip::Date;

# VERSION
# ABSTRACT: Provide common functions for Strava agents.

with 'Exobrain::Agent';

sub component_name { "Strava" };

has strava => (
    is => 'ro',
    isa => 'WebService::Strava',
    lazy => 1,
    builder => '_build_strava',
    handles => [ qw( list_activities ) ],
);

method _build_strava() {
  return WebService::Strava->new();
}

1;

=for Pod::Coverage component_name
