part of 'map_cubit.dart';

@immutable
sealed class MapState extends Equatable {
  final Set<Marker> markers;
  final LatLng location;

  MapState({Set<Marker>? markers, LatLng? location})
      : markers = markers ?? {},
        location = location ?? const LatLng(45.521563, -122.677433);

  @override
  List<Object?> get props => [markers, location];
}

final class MapInitial extends MapState {}

final class MapLoaded extends MapState {}

final class MapDrawLocation extends MapState {
  MapDrawLocation(Set<Marker> markers, LatLng location)
      : super(markers: markers, location: location);
}

final class MapLocationError extends MapState {}

final class MapSaveLocation extends MapState {
  final String address;

  MapSaveLocation(Set<Marker> markers, LatLng location, this.address)
      : super(markers: markers, location: location);

  @override
  List<Object?> get props => [markers, location, address];
}
