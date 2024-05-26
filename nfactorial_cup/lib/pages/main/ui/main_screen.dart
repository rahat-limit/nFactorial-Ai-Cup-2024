import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/main/ui/widgets/location_modal.dart';
import 'package:nfactorial_cup/pages/main/ui/widgets/main_map_widget.dart';
import 'package:nfactorial_cup/pages/main/ui/widgets/menu_widget.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  late double _panelHeightOpen;
  double _percentage = 0;
  void sendMessage() {
    moveToCurrentLocation(const AppLatLong(lat: 55.755864, long: 37.617698),
        mapControllerCompleter);
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // MainMapCubit.read(context).displayPlacesOnMap();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // ----- Get menu from from scrapper
  //   // PlansCubit.read(context).getMenuPreferencesInfo(135993469025);
  //   // ----- Get food restrictions
  //   // List<String> restrs =
  //   //     ProfileCubit.watchState(context).preferences.foodRestrictions;
  //   // ----- Define restrictions from menu using gpt
  //   // PlansCubit.read(context).defineMenuRestrictions(foodRestriction: restrs);
  // }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .60;
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            left: 0,
            top: 0,
            child: MainMap(mapControllerCompleter: mapControllerCompleter)),
        // Positioned(
        //     top: 10,
        //     left: 0,
        //     child: SizedBox(
        //         width: MediaQuery.of(context).size.width,
        //         height: 100,
        //         child: const Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [LocationModal()],
        //         ))),
        SlidingUpPanel(
            onPanelSlide: _slidePosition, //add this line
            maxHeight: _panelHeightOpen,
            minHeight: MediaQuery.of(context).size.height * .2,
            parallaxEnabled: true,
            padding: const EdgeInsets.all(15.0),
            color: AppColors.bottomPanel,
            parallaxOffset: 0.5,
            panelBuilder: _panel,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)))
      ],
    ));
  }

  void _slidePosition(double percent) {
    //add this line
    if (percent > _percentage) {
    } else if (percent < _percentage) {}
    _percentage = percent; //add this line
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: [
          Center(
            child: Container(
              width: 70,
              height: 7.5,
              decoration: BoxDecoration(
                color: AppColors.secondaryTextColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          height: .5,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(horizontal: 15))),
                  Text('Menu', style: AppFonts.w700s16.copyWith(fontSize: 23)),
                  Expanded(
                      child: Container(
                          height: .5,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(horizontal: 15)))
                ],
              )),
          const MenuWidget()
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(children: <Widget>[
      Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ])),
      SizedBox(height: 12.0),
      Text(label)
    ]);
  }
}
