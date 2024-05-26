import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';

class PlacesApi {
  final Dio dio;
  final Dio placesDio;

  PlacesApi({required this.dio, required this.placesDio});
  Future<LocationsModel?> searchForLocations(
      {required String prompt,
      int maxQuantity = 50,
      String type = 'locality'}) async {
    final res = await dio
        .get('&geocode=$prompt&kind=$type&rusults=$maxQuantity&format=json');
    if (res.statusCode == 200) {
      return LocationsModel.fromJson(res.data);
    } else {
      return null;
    }
  }

  Future<YandexPlacesModel?> getPlaces(
      {required String prompt,
      int maxQuantity = 15,
      required String ll,
      String type = 'biz'}) async {
    final res = await placesDio
        .get('&text=$prompt&type=$type&results=$maxQuantity&ll=$ll');
    if (res.statusCode == 200) {
      return YandexPlacesModel.fromJson(res.data);
    } else {
      return null;
    }
  }
}
