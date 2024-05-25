import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';

abstract class PlansRepository {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();

  Future<String> sendGPTMessage(String prompt, String context);

  Future<GetMenuContext> getMenuContext(int placeId);
}
