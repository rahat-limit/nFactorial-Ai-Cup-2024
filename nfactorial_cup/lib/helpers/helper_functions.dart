import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_state.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';

void changeMainMapLocation(
    BuildContext context, String city, AppLatLong coordinates) {
  CurrentLocation location =
      CurrentLocation(city: city, coordinates: coordinates);
  MainMapCubit.read(context).changeCurrentCity(location);
  ProfileCubit.read(context).changeCurrentLocation(location.coordinates);
  // var _location = MainMapCubit.watchState(context).currentCity.coordinates;
  // String ll = '${_location.long},${_location.lat}';

  // // // Сперва получаю данные
  // PlansCubit.read(context).getYandexPlaces(prompt: 'гостиница', ll: ll);
  // PlansCubit.read(context).getYandexPlaces(
  //     prompt: 'завтрак', placeType: PlaceType.breakfast, ll: ll);
  // PlansCubit.read(context)
  //     .getYandexPlaces(prompt: 'обед', placeType: PlaceType.lunch, ll: ll);
  // PlansCubit.read(context)
  //     .getYandexPlaces(prompt: 'ужин', placeType: PlaceType.dinner, ll: ll);
  // var type = ProfileCubit.watchState(context).preferences.vacationTypes;
  // PlansCubit.read(context).getYandexPlaces(
  //     prompt: '', placeType: PlaceType.places, vacationType: type, ll: ll);
  // // После отдаю гпт на
  // Future.delayed(const Duration(seconds: 4)).then((val) {
  //   PlansCubit.read(context).generatePlan();
  // });
  Navigator.pop(context);
}

void showLocationsModal(BuildContext context) {
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: AppColors.navbarColors,
                borderRadius: BorderRadius.circular(25)),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 8,
                horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 18),
            child: Column(
              children: [
                CupertinoTextField(
                    onSubmitted: (val) {
                      MainMapCubit.read(context).searchLocations(val);
                    },
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:
                            Border.all(color: AppColors.secondary, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    placeholder: 'City',
                    placeholderStyle:
                        AppFonts.w800s24.copyWith(color: AppColors.secondary),
                    style: AppFonts.w800s24),
                const SizedBox(height: 10),
                BlocBuilder<MainMapCubit, MainMapState>(
                    buildWhen: (previous, current) =>
                        previous.searchLocations != current.searchLocations,
                    builder: (context, state) {
                      List<Widget> content = [];
                      if (state.searchLocations?.response?.geoObjectCollection
                              ?.featureMember !=
                          null) {
                        content = state.searchLocations!.response!
                            .geoObjectCollection!.featureMember!
                            .map((e) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [
                                      e.geoObject?.name == null
                                          ? Text('No Title',
                                              style: AppFonts.w800s20)
                                          : Expanded(
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      elevation: 0,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  onPressed: () {
                                                    var coordinates;
                                                    if (e.geoObject?.point
                                                            ?.pos !=
                                                        null) {
                                                      coordinates = e.geoObject!
                                                          .point!.pos!
                                                          .split(' ');
                                                      changeMainMapLocation(
                                                          context,
                                                          e.geoObject?.name ??
                                                              '',
                                                          AppLatLong(
                                                              lat: double.parse(
                                                                  coordinates[
                                                                      1]),
                                                              long: double.parse(
                                                                  coordinates[
                                                                      0])));
                                                    }
                                                  },
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  e.geoObject
                                                                          ?.name ??
                                                                      '',
                                                                  style: AppFonts
                                                                      .w800s20,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  e.geoObject
                                                                          ?.description ??
                                                                      '',
                                                                  style: AppFonts
                                                                      .w700s16
                                                                      .copyWith(
                                                                          color: AppColors
                                                                              .secondary),
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )))
                                    ],
                                  )
                                ],
                              )),
                              Icon(CupertinoIcons.location_solid,
                                  color: AppColors.navbarMainButton, size: 32),
                            ],
                          );
                        }).toList();
                      }
                      switch (state.status) {
                        case OkMainMapStatus():
                          return Expanded(child: ListView(children: content));
                        case LoadingMainMapStatus():
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          return const SizedBox();
                      }
                    })
              ],
            ));
      });
}
