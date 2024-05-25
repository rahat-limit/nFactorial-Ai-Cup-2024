import 'package:nfactorial_cup/helpers/app_location.dart';

class UserModel {
  final int id;
  final List<PlanModel> plans;
  const UserModel({required this.id, required this.plans});
}

class PlanModel {
  final List<AppLatLong> coordinates;
  const PlanModel({required this.coordinates});
}
