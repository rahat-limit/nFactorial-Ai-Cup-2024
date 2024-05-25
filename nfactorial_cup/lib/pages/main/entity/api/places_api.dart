import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';

class PlacesApi {
  final Dio dio;
  PlacesApi({required this.dio});
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
}
