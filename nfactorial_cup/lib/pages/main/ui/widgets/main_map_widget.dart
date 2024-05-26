import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_state.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';
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
              CurrentLocation(city: 'Astana', coordinates: location));
        },
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var state = PlansCubit.watchState(context);
    MainMapCubit.read(context)
        .displayPlacesOnMap(state.plansData.first['plan-0']!);
  }

  @override
  Widget build(BuildContext context) {
    List<String> restrs =
        ProfileCubit.watchState(context).preferences.foodRestrictions;
    return BlocConsumer<MainMapCubit, MainMapState>(
        listenWhen: (previous, current) =>
            previous.currentCity != current.currentCity,
        listener: (context, state) {
          // print(state.status);
          if (state.status is OkMainMapStatus) {
            moveToCurrentLocation(
                state.currentCity.coordinates, widget.mapControllerCompleter);
            var location = ProfileCubit.watchState(context).currentLocation;
            String ll = '${location.long},${location.lat}';
            PlansCubit.read(context)
                .getYandexPlaces(prompt: 'гостиница', ll: ll);
            PlansCubit.read(context).getYandexPlaces(
                prompt: 'завтрак', placeType: PlaceType.breakfast, ll: ll);
            PlansCubit.read(context).getYandexPlaces(
                prompt: 'обед', placeType: PlaceType.lunch, ll: ll);
            PlansCubit.read(context).getYandexPlaces(
                prompt: 'ужин', placeType: PlaceType.dinner, ll: ll);
            var type =
                ProfileCubit.watchState(context).preferences.vacationTypes;
            PlansCubit.read(context).getYandexPlaces(
                prompt: '',
                placeType: PlaceType.places,
                vacationType: type,
                ll: ll);
            // После отдаю гпт на
            Future.delayed(const Duration(seconds: 4)).then((val) {
              PlansCubit.read(context).generatePlan();
            });
          }
        },
        builder: (context, state) {
          List<AppLatLong> coordinates = [];
          if (state.markers.isNotEmpty) {
            coordinates = state.markers
                .map((e) => AppLatLong(
                    id: e.properties!.companyMetaData!.id,
                    lat: e.geometry!.coordinates[1],
                    long: e.geometry!.coordinates.first))
                .toList();
          }
          // if (state.locations?.response?.geoObjectCollection?.featureMember !=
          //     null) {
          //   coordinates = state
          //       .locations!.response!.geoObjectCollection!.featureMember!
          //       .map((e) => AppLatLong(
          //           lat: double.parse(e.geoObject!.point!.pos!.split(' ')[1]),
          //           long: double.parse(e.geoObject!.point!.pos!.split(' ')[0])))
          //       .toList();
          // }
          switch (state.status) {
            case OkMainMapStatus():
              return YandexMap(
                  nightModeEnabled: true,
                  mapObjects: _getPlacemarkObjects(coordinates, (String id) {
                    PlansCubit.read(context)
                        .getMenuPreferencesInfo(int.parse(id));
                    Future.delayed(const Duration(seconds: 1)).then((val) {
                      PlansCubit.read(context)
                          .defineMenuRestrictions(foodRestriction: restrs);
                    });
                  }),
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

  List<PlacemarkMapObject> _getPlacemarkObjects(
      List<AppLatLong> objects, Function(String) ontap) {
    return objects
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject ${point.lat}, ${point.long}'),
            point: Point(latitude: point.lat, longitude: point.long),
            opacity: 1,
            onTap: (place, pointt) {
              ontap(point.id);
            },
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage('assets/pngs/point.png'),
                scale: 4.5,
              ),
            ),
          ),
        )
        .toList();
  }
}
