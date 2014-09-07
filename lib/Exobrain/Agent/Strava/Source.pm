package Exobrain::Agent::Strava::Source;
use Moose;
use Method::Signatures;

with 'Exobrain::Agent::Strava';
with 'Exobrain::Agent::Poll';

use constant LAST_CHECK => 'last_check';

# ABSTRACT: Send Strava events to the exobrain bus
# VERSION

has last_check => (
  is => 'rw',
  isa => 'Int', 
  trigger => \&_last_check_update,
  builder => '_build_last_check',
);

method _build_last_check() {
  return $self->cache->compute(LAST_CHECK, undef, sub { time() } );
}

method _last_check_update($value!, ...) {
  $self->cache->set(LAST_CHECK, $value);
}

method poll() {
  my $checktime = time();
  my $last_check = $self->last_check;
  my $athlete = $self->strava->athlete();
  my $activities = $athlete->list_activities(after => $last_check); 
  
  foreach my $activity (reverse @$activities) {
    # Do things here


      #my $name = ( $checkin->{user}{firstName} // "" ) . " "
      #         . ( $checkin->{user}{lastName}  // "" );
  
      #my $time = localtime($checkin->{createdAt});
  
      #my $user = $checkin->{user}{id};
  
      #warn "Displaying checkin at $checkin->{venue}{name} by $name\n"
      #    if DEBUG;
  
      #$self->exobrain->measure('Geo::Foursquare',
      #    checkin => $checkin,
      #);
  }
  
  # Finally, update our check-time.
  $self->last_check( $checktime );
}

1;

=for Pod::Coverage DEBUG LAST_CHECK
