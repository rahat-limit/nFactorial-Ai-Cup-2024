import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/expanded_button.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/option_item.dart';

class ChooseTourismType extends StatefulWidget {
  final PageController controller;
  final List<int> vacationTypeIndexes;
  const ChooseTourismType(
      {super.key, required this.controller, required this.vacationTypeIndexes});

  @override
  State<ChooseTourismType> createState() => _ChooseTourismTypeState();
}

class _ChooseTourismTypeState extends State<ChooseTourismType> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Hello Sofia👋', style: AppFonts.w400s16.copyWith(fontSize: 19)),
          Text('What type(s) of vacation do you like?',
              style: AppFonts.w800s32.copyWith(fontSize: 42)),
          const SizedBox(height: 40),
          Wrap(
              spacing: 10,
              runSpacing: 12,
              children: List.generate(
                  vacationTypes.length,
                  (index) => OptionItem(
                        text: vacationTypes[index],
                        active: widget.vacationTypeIndexes.contains(index),
                        callback: () {
                          setState(() {
                            if (widget.vacationTypeIndexes.contains(index)) {
                              widget.vacationTypeIndexes.remove(index);
                            } else {
                              widget.vacationTypeIndexes.add(index);
                            }
                          });
                        },
                      )))
        ]),
      )),
      ExpandedButton(callback: () async {
        await widget.controller.nextPage(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut);
      })
    ]);
  }
}
