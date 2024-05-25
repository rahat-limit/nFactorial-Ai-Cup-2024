import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plan_repository_impl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlanMap extends StatefulWidget {
  final Completer<YandexMapController> mapControllerCompleter;
  const PlanMap({super.key, required this.mapControllerCompleter});

  @override
  State<PlanMap> createState() => _PlanMapState();
}

class _PlanMapState extends State<PlanMap> {
  @override
  void initState() {
    super.initState();
    initPermission(widget.mapControllerCompleter).ignore();
  }

  @override
  Widget build(BuildContext context) {
    return YandexMap(
        nightModeEnabled: true,
        onMapCreated: (controller) {
          widget.mapControllerCompleter.complete(controller);
        });
  }
}
