import 'package:go_router/go_router.dart';

import '../../../logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static var name = 'map_screen';

  final double? latitude;
  final double? longitude;
  final String? address;
  const MapScreen({
    this.latitude,
    this.longitude,
    this.address,
    super.key,
  });

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ubicación'),
        ),
        body: _ui(),
      ),
    );
  }

  _ui() {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLoaded) {
          BlocProvider.of<MapCubit>(context).emitDrawLocation(
            latitude: widget.latitude,
            longitude: widget.longitude,
            address: widget.address,
          );
        }
        if (state is MapSaveLocation) {
          BlocProvider.of<UserProfileCubit>(context).emitEditAdress(
            state.address,
            state.location.latitude,
            state.location.longitude,
          );
          context.pop();
        }
      },
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            GoogleMap(
              markers: state.markers,
              mapType: MapType.normal,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (controller) => BlocProvider.of<MapCubit>(context)
                  .emitInitializeMap(controller),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  state.location.latitude,
                  state.location.longitude,
                ),
                zoom: 11.0,
              ),
              onTap: (argument) async {
                BlocProvider.of<MapCubit>(context).emitDrawLocation(
                  latitude: argument.latitude,
                  longitude: argument.longitude,
                );
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<MapCubit>(context).emitSetLocation();
                  },
                  child: const Icon(Icons.save),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () async {
                    BlocProvider.of<MapCubit>(context)
                        .emitDrawCurrentLocation();
                  },
                  child: const Icon(Icons.location_on),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
