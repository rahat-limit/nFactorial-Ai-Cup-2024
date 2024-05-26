import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';
import 'package:nfactorial_cup/pages/plans/ui/widgets/place_card.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class PlansListPage extends StatefulWidget {
  const PlansListPage({super.key});

  @override
  State<PlansListPage> createState() => _PlansListPageState();
}

class _PlansListPageState extends State<PlansListPage> {
  final controller = PageController(viewportFraction: 0.9, keepPage: true);

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // PlansCubit.read(context).getMenuPreferencesInfo(135993469025);
    // // get currentlocation ll
    if (mounted) {
      var location = ProfileCubit.watchState(context).currentLocation;
      String ll = '${location.long},${location.lat}';
      // // Сперва получаю данные
      PlansCubit.read(context).getYandexPlaces(prompt: 'гостиница', ll: ll);
      PlansCubit.read(context).getYandexPlaces(
          prompt: 'завтрак', placeType: PlaceType.breakfast, ll: ll);
      PlansCubit.read(context)
          .getYandexPlaces(prompt: 'обед', placeType: PlaceType.lunch, ll: ll);
      PlansCubit.read(context)
          .getYandexPlaces(prompt: 'ужин', placeType: PlaceType.dinner, ll: ll);
      var type = ProfileCubit.watchState(context).preferences.vacationTypes;
      PlansCubit.read(context).getYandexPlaces(
          prompt: '', placeType: PlaceType.places, vacationType: type, ll: ll);
      // После отдаю гпт на

      Future.delayed(const Duration(seconds: 3)).then((val) {
        PlansCubit.read(context).generatePlan();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColors,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(child: Text('Plan', style: AppFonts.w800s32)),
                    BlocBuilder<PlansCubit, PlanState>(
                      builder: (context, state) {
                        if (state.status == LoadingPlanStatus()) {
                          return CircularProgressIndicator();
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                planListView(PlaceType.accommodation, controller),
                const SizedBox(
                  height: 15,
                ),
                planListView(PlaceType.breakfast, controller),
                const SizedBox(
                  height: 15,
                ),
                planListView(PlaceType.places, controller),
                const SizedBox(
                  height: 15,
                ),
                planListView(PlaceType.lunch, controller),
                const SizedBox(
                  height: 15,
                ),
                planListView(PlaceType.placesAfterLunch, controller),
                const SizedBox(
                  height: 15,
                ),
                planListView(PlaceType.dinner, controller),
                const SizedBox(
                  height: 15,
                ),
                planListView(PlaceType.placesAfterDinner, controller),
              ],
            ),
          ),
        ));
  }

  Widget planListView(PlaceType type, PageController controller) {
    return BlocBuilder<PlansCubit, PlanState>(
      builder: (context, state) {
        switch (state.status) {
          case OkPlanStatus():
            if (state.plans == null || state.plans!.isEmpty) return SizedBox();

            List<Feature> features = [];
            int idx;
            switch (type) {
              case PlaceType.places:
                if (state.places != null) {
                  features = state.places!.features;
                }
                idx = 2;
              case PlaceType.accommodation:
                idx = 0;
                if (state.accommodation != null) {
                  features = state.accommodation!.features;
                }
              case PlaceType.breakfast:
                idx = 1;
                if (state.breakfast != null) {
                  features = state.breakfast!.features;
                }
              case PlaceType.lunch:
                idx = 3;
                if (state.lunch != null) {
                  features = state.lunch!.features;
                }
              case PlaceType.dinner:
                idx = 5;
                if (state.dinner != null) {
                  features = state.dinner!.features;
                }
              case PlaceType.placesAfterLunch:
                idx = 4;
                if (state.places != null) {
                  features = state.places!.features;
                }
              case PlaceType.placesAfterDinner:
                idx = 6;
                if (state.dinner != null) {
                  features = state.places!.features;
                }
              default:
                idx = 0;
            }

            List<Widget?> places = List.generate(state.plans!.length, (index) {
              for (var item in features) {
                try {
                  if (item.properties!.companyMetaData!.id.trim() ==
                      state.plans![index].finalPlanIds[idx].trim()) {
                    return PlaceCard(feature: item, type: type);
                  }
                } on RangeError catch (_) {
                  return null;
                }
              }
            });
            places.removeWhere((e) => e == null);
            if (places.isNotEmpty) {
              return SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: controller,
                  padEnds: false,
                  itemCount: places.length,
                  itemBuilder: (_, index) {
                    return places[index % places.length];
                  },
                ),
              );
            } else {
              return SizedBox();
            }

          default:
            return SizedBox();
        }
      },
    );
  }
}
