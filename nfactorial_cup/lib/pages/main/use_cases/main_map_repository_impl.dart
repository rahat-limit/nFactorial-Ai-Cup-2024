import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/entity/api/gpt_api.dart';
import 'package:nfactorial_cup/pages/main/entity/api/places_api.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';
import 'package:nfactorial_cup/pages/main/use_cases/main_map_repository.dart';

class MainMapRepositoryImpl extends MainMapRepository {
  PlacesApi api;
  GptApi gptApi;
  MainMapRepositoryImpl({required this.api, required this.gptApi});
  @override
  Future<List<AppLatLong>> getMapPlaces() async {
    await gptApi.generateText('Hello!');
    return [];
  }

  @override
  Future<LocationsModel?> searchLocations(String text) async {
    LocationsModel? model = await api.searchForLocations(prompt: text);

    return model;
  }
}
