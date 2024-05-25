import 'dart:async';
import 'package:nfactorial_cup/pages/plans/use_cases/plan_repository_impl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CurrentLocation {
  final String city;
  final AppLatLong coordinates;

  CurrentLocation({required this.city, required this.coordinates});
}

class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

Future<void> initPermission(
    Completer<YandexMapController> mapControllerCompleter,
    {Function(AppLatLong)? saveToCurrentLocation}) async {
  if (!await PlanRepositoryImpl(plansApi: null).checkPermission()) {
    await PlanRepositoryImpl(plansApi: null).requestPermission();
  }
  await fetchCurrentLocation(mapControllerCompleter,
      saveToCurrentLocation: saveToCurrentLocation);
}

Future<void> fetchCurrentLocation(
    Completer<YandexMapController> mapControllerCompleter,
    {Function(AppLatLong)? saveToCurrentLocation}) async {
  AppLatLong location;
  // 51.163069, 71.408489
  const defLocation = AppLatLong(lat: 51.163069, long: 71.408489);
  try {
    location = await PlanRepositoryImpl(plansApi: null).getCurrentLocation();
    if (saveToCurrentLocation != null) {
      saveToCurrentLocation(location);
    }
  } catch (_) {
    location = defLocation;
  }
  moveToCurrentLocation(location, mapControllerCompleter);
}

Future<void> moveToCurrentLocation(
  AppLatLong appLatLong,
  Completer<YandexMapController> mapControllerCompleter,
) async {
  (await mapControllerCompleter.future).moveCamera(
    animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: Point(
          latitude: appLatLong.lat,
          longitude: appLatLong.long,
        ),
        zoom: 12,
      ),
    ),
  );
}
