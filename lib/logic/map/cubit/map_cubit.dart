import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../resources/resources.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  late GoogleMapController mapController;

  MapCubit() : super(MapInitial());

  void emitInitializeMap(GoogleMapController controller) {
    mapController = controller;
    emit(MapLoaded());
  }

  void emitDrawLocation({
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    if (latitude != null && longitude != null) {
      await _animateCamera(latitude, longitude);
      emit(MapDrawLocation(
        _getMarkers(latitude, longitude),
        LatLng(latitude, longitude),
      ));
    } else {
      emitDrawCurrentLocation();
    }
  }

  void emitDrawCurrentLocation() async {
    try {
      final position = await _determineCurrentPosition();
      await _animateCamera(position.latitude, position.longitude);
      emit(MapDrawLocation(
        _getMarkers(position.latitude, position.longitude),
        LatLng(position.latitude, position.longitude),
      ));
    } catch (_) {
      emit(MapLocationError());
    }
  }

  void emitSetLocation() async {
    final address =
        await _getAddress(state.location.latitude, state.location.longitude);
    emit(MapSaveLocation(state.markers, state.location, address));
  }

  Future<void> _animateCamera(double latitude, double longitude) async {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
          latitude,
          longitude,
        ),
        zoom: 14,
      ),
    );
    await mapController.animateCamera(cameraUpdate);
  }

  Future<Position> _determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Future.error('location service is disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        await Future.error('location permission denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Set<Marker> _getMarkers(double latitude, double longitude) {
    return {
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(
          latitude,
          longitude,
        ),
      )
    };
  }

  Future<String> _getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first.name ?? '';
  }

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }
}
