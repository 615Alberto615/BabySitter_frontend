import '../models/LocationDto.dart';
import 'babysitter_state.dart';

class LocationLoaded extends BabysitterState {
  final LocationDto location;

  LocationLoaded(this.location);
}
