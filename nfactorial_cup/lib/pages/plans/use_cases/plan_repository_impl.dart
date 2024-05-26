import 'package:geolocator/geolocator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfactorial_cup/data/local_db/context_storage.dart';
import 'package:nfactorial_cup/data/local_db/token_storage.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/entity/api/places_api.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';
import 'package:nfactorial_cup/pages/plans/entity/api/plans_api.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plans_repository.dart';
import 'package:dio/dio.dart';

class PlanRepositoryImpl extends PlansRepository {
  final PlansApi? plansApi;
  final PlacesApi? placesApi;
  final TokenStorage? tokenStorage;

  PlanRepositoryImpl(
      {required this.placesApi, this.plansApi, this.tokenStorage});

  @override
  Future<bool> checkPermission() async {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError((err) => print(err));
    // return AppLatLong(lat: 55.755864, long: 37.617698);
  }

  @override
  Future<bool> requestPermission() async {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<String> sendGPTMessage(String prompt, String context) async {
    if (plansApi == null) return '';
    final result =
        await plansApi!.sendGPTMessage(prompt: prompt, context: context);
    return result;
  }

  @override
  Future<GetMenuContext> getMenuContext(int placeId) async {
    final result = await plansApi!.getMenuContext(placeId: placeId);

    return result!;
  }

  @override
  Future<YandexPlacesModel?> getYandexPlaces(
      {required String prompt,
      int maxQuantity = 15,
      String type = 'biz',
      required String ll}) async {
    final result = await placesApi!.getPlaces(
        prompt: prompt, maxQuantity: maxQuantity, type: type, ll: ll);
    return result;
  }
}
