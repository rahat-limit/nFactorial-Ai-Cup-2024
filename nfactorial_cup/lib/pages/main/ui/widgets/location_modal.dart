import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/helpers/helper_functions.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_state.dart';

class LocationModal extends StatefulWidget {
  const LocationModal({super.key});

  @override
  State<LocationModal> createState() => _LocationModalState();
}

class _LocationModalState extends State<LocationModal> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showLocationsModal(context);
      },
      child: Container(
          margin: const EdgeInsets.only(top: 25),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.bottomModal,
          ),
          child: Row(children: [
            Image.asset('assets/pngs/search.png', width: 24, height: 24),
            Container(
                width: 1.5,
                height: 25,
                color: AppColors.secondary,
                margin: const EdgeInsets.symmetric(horizontal: 15)),
            Expanded(
                child: BlocBuilder<MainMapCubit, MainMapState>(
                    buildWhen: (previous, current) =>
                        previous.currentCity != current.currentCity,
                    builder: (context, state) {
                      return Text(state.currentCity.city,
                          style: AppFonts.w700s20,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1);
                    }))
          ])),
    );
  }
}
