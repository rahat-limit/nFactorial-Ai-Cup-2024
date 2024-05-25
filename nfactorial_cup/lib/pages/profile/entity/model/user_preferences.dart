class UserPreferences {
  final List<String> vacationTypes;
  final List<String> cuisineTypes;
  final List<String> foodRestrictions;

  UserPreferences(
      {required this.vacationTypes,
      required this.cuisineTypes,
      required this.foodRestrictions});
  UserPreferences copyWith(
      {List<String>? vacationTypes,
      List<String>? cuisineTypes,
      List<String>? foodRestrictions}) {
    return UserPreferences(
        vacationTypes: vacationTypes ?? this.vacationTypes,
        cuisineTypes: cuisineTypes ?? this.cuisineTypes,
        foodRestrictions: foodRestrictions ?? this.foodRestrictions);
  }
}
