import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';
import 'package:nfactorial_cup/pages/plans/ui/widgets/plan_map.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class PlanDetailPage extends StatefulWidget {
  const PlanDetailPage({super.key});

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final _controller = TextEditingController();
  void sendMessage() {
    // moveToCurrentLocation(const AppLatLong(lat: 50.976731, long: 71.553625),
    //     mapControllerCompleter);
    // if (_controller.text.isNotEmpty) {
    //   PlansCubit.read(context).sendGPTMessage(prompt: _controller.text);
    //   _controller.clear();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: PlanMap(mapControllerCompleter: mapControllerCompleter)),
          // SizedBox()

          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //       width: double.infinity,
          //       constraints:
          //           const BoxConstraints(maxHeight: 300, minHeight: 100),
          //       padding: const EdgeInsets.only(bottom: 80),
          //       color: Colors.black54,
          //       child: BlocBuilder<PlansCubit, PlanState>(
          //         builder: (context, state) {
          //           switch (state.status) {
          //             case LoadingPlanStatus():
          //               return const Center(
          //                 child: CircularProgressIndicator(),
          //               );
          //             case OkPlanStatus():
          //               return Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 20),
          //                 child: ListView.builder(
          //                     shrinkWrap: true,
          //                     itemCount: state.messages.length,
          //                     itemBuilder: (context, index) {
          //                       return Text(state.messages[index],
          //                           style:
          //                               const TextStyle(color: Colors.white));
          //                     }),
          //               );
          //             default:
          //               return const SizedBox();
          //           }
          //         },
          //       )),
          // ),
          // Positioned(
          //     bottom: 45,
          //     left: 20,
          //     right: 20,
          //     child: SizedBox(
          //         height: 55,
          //         child: CupertinoTextField(
          //           placeholder: 'Message',
          //           controller: _controller,
          //           padding: const EdgeInsets.symmetric(horizontal: 20),
          //           suffix: GestureDetector(
          //             onTap: sendMessage,
          //             child: Container(
          //                 width: 35,
          //                 height: 35,
          //                 margin: const EdgeInsets.all(10),
          //                 decoration: BoxDecoration(
          //                     color: Colors.blueGrey,
          //                     borderRadius: BorderRadius.circular(12)),
          //                 child: const Icon(Icons.arrow_upward,
          //                     color: Colors.white)),
          //           ),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(10),
          //               border: Border.all(color: Colors.black12)),
          //         ))),
        ],
      ),
    );
  }
}
