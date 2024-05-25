import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/profile/entity/model/user_preferences.dart';

class ProfileState {
  final String email;
  final String nickname;
  final AppLatLong currentLocation;
  final ProfileStatus status;
  final UserPreferences preferences;
  const ProfileState(
      {required this.email,
      required this.nickname,
      required this.status,
      required this.currentLocation,
      required this.preferences});

  ProfileState copyWith(
      {ProfileStatus? status,
      AppLatLong? currentLocation,
      UserPreferences? preferences,
      String? email,
      String? nickname}) {
    return ProfileState(
        status: status ?? this.status,
        currentLocation: currentLocation ?? this.currentLocation,
        preferences: preferences ?? this.preferences,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email);
  }
}

abstract class ProfileStatus {}

class InitProfileStatus extends ProfileStatus {}

class OkProfileStatus extends ProfileStatus {}

class LoadingProfileStatus extends ProfileStatus {}

class ErrorProfileStatus extends ProfileStatus {}
