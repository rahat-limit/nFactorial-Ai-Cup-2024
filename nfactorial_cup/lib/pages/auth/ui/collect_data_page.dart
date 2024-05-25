import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/choose_cousine.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/choose_food_restrictions.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/choose_tourism_type.dart';
import 'package:nfactorial_cup/pages/profile/entity/model/user_preferences.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';
import 'package:nfactorial_cup/routes/app_router.dart';

@RoutePage()
class CollectDataPage extends StatefulWidget {
  const CollectDataPage({super.key});

  @override
  State<CollectDataPage> createState() => _CollectDataPageState();
}

class _CollectDataPageState extends State<CollectDataPage> {
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  List<int> vacationTypeIndexes = [];
  List<int> cousineIndexes = [];
  List<int> foodRestrictionIndexes = [];
  Future<bool> isValid() async {
    if (vacationTypeIndexes.isEmpty) {
      AppMessageCubit.read(context).showMessage(
          message: 'Choose vacation type(s)', type: MessageType.error);
      await controller.animateToPage(0,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
      return false;
    }
    if (cousineIndexes.isEmpty) {
      AppMessageCubit.read(context).showMessage(
          message: 'Choose cousine type(s)', type: MessageType.error);
      await controller.animateToPage(1,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
      return false;
    }
    return true;
  }

  Future setProfilePreferences() async {
    await isValid().then((val) {
      if (val) {
        List<String> cuisineTypes =
            cousineIndexes.map((e) => vacationCuisine[e]).toList();
        List<String> vacationType =
            vacationTypeIndexes.map((e) => vacationTypes[e]).toList();
        List<String> foodRestriction =
            foodRestrictionIndexes.map((e) => foodRestrictions[e]).toList();
        UserPreferences preferences = UserPreferences(
            cuisineTypes: cuisineTypes,
            vacationTypes: vacationType,
            foodRestrictions: foodRestriction);
        ProfileCubit.read(context).setProfilePreferences(preferences);
        context.router.replace(const NavigationRoute());
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabBarContentPages = [
      ChooseTourismType(
          controller: controller, vacationTypeIndexes: vacationTypeIndexes),
      ChooseCousine(controller: controller, cousineIndexes: cousineIndexes),
      ChooseFoodRestrictions(
          controller: controller,
          foodRestrictionIndexes: foodRestrictionIndexes,
          callback: setProfilePreferences)
    ];
    return Scaffold(
        backgroundColor: AppColors.navbarColors,
        body: SafeArea(
            child: Column(children: [
          const SizedBox(height: 25),
          SmoothPageIndicator(
            controller: controller,
            count: tabBarContentPages.length,
            effect: ExpandingDotsEffect(
                dotWidth: 13,
                dotHeight: 13,
                // ignore: use_full_hex_values_for_flutter_colors
                activeDotColor: AppColors.white),
          ),
          Expanded(
              child: PageView.builder(
                  controller: controller,
                  itemCount: tabBarContentPages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 45, horizontal: 30),
                      child:
                          tabBarContentPages[index % tabBarContentPages.length],
                    );
                  }))
        ])));
  }
}
