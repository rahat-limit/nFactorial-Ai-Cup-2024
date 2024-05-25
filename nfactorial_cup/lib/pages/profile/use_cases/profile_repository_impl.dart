import 'package:geolocator/geolocator.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/profile/entity/api/profile_api.dart';
import 'package:nfactorial_cup/pages/profile/use_cases/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileApi profileApi;
  // final TokenStorag? tokenStorage;

  ProfileRepositoryImpl(this.profileApi);

  @override
  Future<AppLatLong> fetchProfile() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError((err) => print(err));
  }
}
