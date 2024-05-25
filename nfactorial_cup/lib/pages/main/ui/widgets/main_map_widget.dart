import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainMap extends StatefulWidget {
  final Completer<YandexMapController> mapControllerCompleter;
  const MainMap({super.key, required this.mapControllerCompleter});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((val) {
      initPermission(
        widget.mapControllerCompleter,
        saveToCurrentLocation: (location) {
          MainMapCubit.read(context).changeCurrentCity(
              CurrentLocation(city: 'Not Selected', coordinates: location));
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainMapCubit, MainMapState>(
        listenWhen: (previous, current) =>
            previous.currentCity != current.currentCity,
        listener: (context, state) {
          // print(state.status);
          if (state.status is OkMainMapStatus) {
            moveToCurrentLocation(
                state.currentCity.coordinates, widget.mapControllerCompleter);
          }
        },
        builder: (context, state) {
          List<AppLatLong> coordinates = [];
          if (state.locations?.response?.geoObjectCollection?.featureMember !=
              null) {
            coordinates = state
                .locations!.response!.geoObjectCollection!.featureMember!
                .map((e) => AppLatLong(
                    lat: double.parse(e.geoObject!.point!.pos!.split(' ')[1]),
                    long: double.parse(e.geoObject!.point!.pos!.split(' ')[0])))
                .toList();
          }
          switch (state.status) {
            case OkMainMapStatus():
              return YandexMap(
                  nightModeEnabled: true,
                  mapObjects: _getPlacemarkObjects(coordinates),
                  //  _getPlacemarkObjects(context),
                  onMapCreated: (controller) {
                    widget.mapControllerCompleter.complete(controller);
                  });
            case LoadingMainMapStatus():
              return YandexMap(
                  nightModeEnabled: true,
                  // mapObjects: _getPlacemarkObjects([currentLocation]),
                  //  _getPlacemarkObjects(context),
                  onMapCreated: (controller) {
                    widget.mapControllerCompleter.complete(controller);
                  });
            default:
              return YandexMap(
                  nightModeEnabled: true,
                  // mapObjects: _getPlacemarkObjects([currentLocation]),
                  //  _getPlacemarkObjects(context),
                  onMapCreated: (controller) {
                    widget.mapControllerCompleter.complete(controller);
                  });
          }
        });
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(List<AppLatLong> objects) {
    return objects
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject ${point.lat}, ${point.long}'),
            point: Point(latitude: point.lat, longitude: point.long),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage('assets/pngs/point.png'),
                scale: 3.5,
              ),
            ),
          ),
        )
        .toList();
  }
}
