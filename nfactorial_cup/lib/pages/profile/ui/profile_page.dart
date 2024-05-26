import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/option_item.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_state.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String>? vacationTypeIndexes;
  List<String>? cuisineTypeIndexes;
  List<String>? foodRestrictionsIndexes;
  ProfileState? state;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = ProfileCubit.watchState(context);
    vacationTypeIndexes = state!.preferences.vacationTypes;
    cuisineTypeIndexes = state!.preferences.cuisineTypes;
    foodRestrictionsIndexes = state!.preferences.foodRestrictions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColors,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(state!.nickname, style: AppFonts.w800s32),
                      Text(state!.email,
                          style:
                              AppFonts.w700s20.copyWith(color: Colors.white70)),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Colors.white60,
                      ),
                      ...vacationTypesWidgets(),
                      ...cuisineWidgets(),
                      ...foodRestrictionsWidgets(),
                    ]),
              )),
        ));
  }

  List<Widget> vacationTypesWidgets() {
    return List.of([
      const SizedBox(
        height: 30,
      ),
      Text('What type(s) of vacation do you like?',
          style: AppFonts.w800s32.copyWith(fontSize: 42)),
      const SizedBox(height: 40),
      BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>
              previous.preferences.vacationTypes.length !=
              current.preferences.vacationTypes.length,
          builder: (context, state) {
            print('Types inited');
            return Wrap(
                spacing: 10,
                runSpacing: 12,
                children: List.generate(vacationTypes.length, (index) {
                  return OptionItem(
                    text: vacationTypes[index],
                    active: vacationTypeIndexes!.contains(vacationTypes[index]),
                    callback: () {
                      if (vacationTypeIndexes != null) {
                        if (vacationTypeIndexes!
                            .contains(vacationTypes[index])) {
                          vacationTypeIndexes!.remove(vacationTypes[index]);
                          ProfileCubit.read(context)
                              .setVacationTypesPreferences(
                                  vacationTypeIndexes!);
                        } else {
                          vacationTypeIndexes!.add(vacationTypes[index]);
                          ProfileCubit.read(context)
                              .setVacationTypesPreferences(
                                  vacationTypeIndexes!);
                        }
                      }
                    },
                  );
                }));
          }),
    ]);
  }

  List<Widget> foodRestrictionsWidgets() {
    return List.of([
      const SizedBox(
        height: 30,
      ),
      Text('Any allergies or food restrictions?',
          style: AppFonts.w800s32.copyWith(fontSize: 42)),
      const SizedBox(height: 40),
      BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>
              previous.preferences.foodRestrictions.length !=
              current.preferences.foodRestrictions.length,
          builder: (context, state) {
            print('Food inited');
            return Wrap(
                spacing: 10,
                runSpacing: 12,
                children: List.generate(foodRestrictions.length, (index) {
                  return OptionItem(
                    text: foodRestrictions[index],
                    active: foodRestrictionsIndexes!
                        .contains(foodRestrictions[index]),
                    callback: () {
                      if (foodRestrictionsIndexes != null) {
                        if (foodRestrictionsIndexes!
                            .contains(foodRestrictions[index])) {
                          cuisineTypeIndexes!.remove(foodRestrictions[index]);
                          ProfileCubit.read(context)
                              .setFoodRestrictionsPreferences(
                                  foodRestrictionsIndexes!);
                        } else {
                          foodRestrictionsIndexes!.add(foodRestrictions[index]);
                          ProfileCubit.read(context)
                              .setFoodRestrictionsPreferences(
                                  foodRestrictionsIndexes!);
                        }
                      }
                    },
                  );
                }));
          })
    ]);
  }

  List<Widget> cuisineWidgets() {
    return List.of([
      const SizedBox(
        height: 30,
      ),
      Text('Which one do you prefer?',
          style: AppFonts.w800s32.copyWith(fontSize: 42)),
      const SizedBox(height: 40),
      BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>
              previous.preferences.cuisineTypes.length !=
              current.preferences.cuisineTypes.length,
          builder: (context, state) {
            print('Cuisine inited');
            return Wrap(
                spacing: 10,
                runSpacing: 12,
                children: List.generate(vacationCuisine.length, (index) {
                  return OptionItem(
                    text: vacationCuisine[index],
                    active:
                        cuisineTypeIndexes!.contains(vacationCuisine[index]),
                    callback: () {
                      if (cuisineTypeIndexes != null) {
                        if (cuisineTypeIndexes!
                            .contains(vacationCuisine[index])) {
                          cuisineTypeIndexes!.remove(vacationCuisine[index]);
                          ProfileCubit.read(context)
                              .setCuisineTypesPreferences(cuisineTypeIndexes!);
                        } else {
                          cuisineTypeIndexes!.add(vacationCuisine[index]);
                          ProfileCubit.read(context)
                              .setCuisineTypesPreferences(cuisineTypeIndexes!);
                        }
                      }
                    },
                  );
                }));
          })
    ]);
  }
}
