import 'package:continental_app/logic/logic.dart';
import 'package:continental_app/logic/map/cubit/map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mocks/mocks.dart';

void main() {
  late MapCubit mapCubit;
  late GoogleMapControllerMock googleMapControllerMock;
  const randomLocation = LatLng(0, 0);
  const markers = Marker(
    markerId: MarkerId('currentLocation'),
    position: randomLocation,
  );

  setUp(() {
    googleMapControllerMock = GoogleMapControllerMock();
    mapCubit = MapCubit();
  });

  test('The initial state for the MapCubit', () {
    expect(mapCubit.state, MapInitial());
  });

  blocTest(
    'The MapCubit loaded map',
    build: () => mapCubit,
    act: (cubit) => cubit.emitInitializeMap(googleMapControllerMock),
    expect: () => [
      MapLoaded(),
    ],
  );

  group('MapCubit failing', () {
    blocTest(
      'The MapCubit loaded map',
      setUp: () {
        mapCubit.emitInitializeMap(googleMapControllerMock);
      },
      build: () {
        final cameraUpdate = CameraUpdate.newLatLng(randomLocation);
        when(googleMapControllerMock.animateCamera(cameraUpdate))
            .thenAnswer((_) => Future.value());
        return mapCubit;
      },
      act: (cubit) => cubit.emitDrawLocation(
        latitude: randomLocation.latitude,
        longitude: randomLocation.longitude,
      ),
      expect: () => [
        MapDrawLocation(
          {markers},
          randomLocation,
        ),
      ],
    );
  });
}
