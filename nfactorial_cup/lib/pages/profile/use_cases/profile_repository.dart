import 'package:nfactorial_cup/helpers/app_location.dart';

abstract class ProfileRepository {
  Future<AppLatLong> fetchProfile();
}
