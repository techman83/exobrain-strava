package Exobrain::Strava;
use Moose;
use WebService::Strava;

# ABSTRACT: Strava components for Exobrain
# VERSION

with 'Exobrain::Component';


sub component { "strava" };

sub services {
  return (
    source => 'Strava::Source',
  );
}

sub setup {
  my $strava = WebService::Strava->new();
  $strava->auth->setup();
  return;
}

1;

=for Pod::Coverage setup services component
