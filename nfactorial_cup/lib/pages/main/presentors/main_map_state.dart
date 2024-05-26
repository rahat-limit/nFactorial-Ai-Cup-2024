import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';

class MainMapState {
  final LocationsModel? locations;
  final LocationsModel? searchLocations;
  final MainMapStatus status;
  final CurrentLocation currentCity;
  final List<Feature> markers;
  const MainMapState({
    required this.markers,
    required this.locations,
    required this.searchLocations,
    required this.currentCity,
    required this.status,
  });

  MainMapState copyWith(
      {MainMapStatus? status,
      List<Feature>? markers,
      LocationsModel? locations,
      CurrentLocation? currentCity,
      LocationsModel? searchLocations}) {
    return MainMapState(
        status: status ?? this.status,
        locations: locations ?? this.locations,
        currentCity: currentCity ?? this.currentCity,
        searchLocations: searchLocations ?? this.searchLocations,
        markers: markers ?? this.markers);
  }
}

abstract class MainMapStatus {}

class InitMainMapStatus extends MainMapStatus {}

class OkMainMapStatus extends MainMapStatus {}

class LoadingMainMapStatus extends MainMapStatus {}

class ErrorMainMapStatus extends MainMapStatus {}
