import 'package:geolocator/geolocator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfactorial_cup/data/local_db/context_storage.dart';
import 'package:nfactorial_cup/data/local_db/token_storage.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/plans/entity/api/plans_api.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plans_repository.dart';
import 'package:dio/dio.dart';

class PlanRepositoryImpl extends PlansRepository {
  final PlansApi? plansApi;
  final TokenStorage? tokenStorage;

  PlanRepositoryImpl({this.plansApi, this.tokenStorage});

  // final model =
  //     GenerativeModel(model: 'gemini-pro', apiKey: AppConts.geminiApiKey);

  // ContextStorage contextStorage = const ContextStorage();

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
    // final content = [
    // Content.text('${contextStorage.context} Question: $prompt')
    // ];

    // final response = await model.generateContent(content);
    // await model.generateContent(content);
    // return response.text ?? 'No Info';
    return result;
  }

  @override
  Future<GetMenuContext> getMenuContext(int placeId) async {
    final result = await plansApi!.getMenuContext(placeId: placeId);

    return result!;
  }
}
