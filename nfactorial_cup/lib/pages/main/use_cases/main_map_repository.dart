import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';

abstract class MainMapRepository {
  Future<List<AppLatLong>> getMapPlaces();
  Future<LocationsModel?> searchLocations(String text);
}
