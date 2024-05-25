import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';

class MainMapState {
  final LocationsModel? locations;
  final LocationsModel? searchLocations;
  final MainMapStatus status;
  final CurrentLocation currentCity;
  const MainMapState({
    required this.locations,
    required this.searchLocations,
    required this.currentCity,
    required this.status,
  });

  MainMapState copyWith(
      {MainMapStatus? status,
      LocationsModel? locations,
      CurrentLocation? currentCity,
      LocationsModel? searchLocations}) {
    return MainMapState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      currentCity: currentCity ?? this.currentCity,
      searchLocations: searchLocations ?? this.searchLocations,
    );
  }
}

abstract class MainMapStatus {}

class InitMainMapStatus extends MainMapStatus {}

class OkMainMapStatus extends MainMapStatus {}

class LoadingMainMapStatus extends MainMapStatus {}

class ErrorMainMapStatus extends MainMapStatus {}
