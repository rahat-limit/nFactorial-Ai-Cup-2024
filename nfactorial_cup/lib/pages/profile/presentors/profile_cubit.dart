import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/pages/profile/entity/model/user_preferences.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_state.dart';
import 'package:nfactorial_cup/pages/profile/use_cases/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  // Статические методы для прослушивания и получения кубита
  static ProfileState watchState(BuildContext context) =>
      context.watch<ProfileCubit>().state;
  static ProfileCubit read(BuildContext context) =>
      context.read<ProfileCubit>();

  ProfileCubit({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileState(
            email: 'mail@gmail.com',
            nickname: 'Rakhat',
            status: InitProfileStatus(),
            currentLocation: const AppLatLong(lat: 51.128201, long: 71.430429),
            preferences: UserPreferences(cuisineTypes: [
              '🚫 🥩 🐟  Vegetarian'
            ], vacationTypes: [
              '🏝  Beach holidays',
            ], foodRestrictions: [
              '🥛  Dairy products'
            ])));

  final ProfileRepository _repository;

  void changeCurrentLocation(AppLatLong coords) {
    state.copyWith(currentLocation: coords);
  }

  void getProfile() async {
    try {
      emit(state.copyWith(status: LoadingProfileStatus()));
      AppLatLong position = await _repository.fetchProfile();
      emit(
          state.copyWith(status: OkProfileStatus(), currentLocation: position));
    } on DioException catch (e) {
      print(e);
    }
  }

  void setProfilePreferences(UserPreferences preferences) {
    emit(state.copyWith(preferences: preferences));
  }

  void setVacationTypesPreferences(List<String> types) {
    emit(state.copyWith(
        preferences: UserPreferences(
            vacationTypes: types,
            cuisineTypes: state.preferences.cuisineTypes,
            foodRestrictions: state.preferences.foodRestrictions)));
  }

  void setCuisineTypesPreferences(List<String> types) {
    emit(state.copyWith(
        preferences: UserPreferences(
            vacationTypes: state.preferences.vacationTypes,
            cuisineTypes: types,
            foodRestrictions: state.preferences.foodRestrictions)));
  }

  void setFoodRestrictionsPreferences(List<String> types) {
    emit(state.copyWith(
        preferences: UserPreferences(
            vacationTypes: state.preferences.vacationTypes,
            cuisineTypes: state.preferences.cuisineTypes,
            foodRestrictions: types)));
  }
}
