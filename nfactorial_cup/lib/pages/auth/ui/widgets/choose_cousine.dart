import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/expanded_button.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/option_item.dart';

class ChooseCousine extends StatefulWidget {
  final PageController controller;
  final List<int> cousineIndexes;
  const ChooseCousine(
      {super.key, required this.controller, required this.cousineIndexes});

  @override
  State<ChooseCousine> createState() => _ChooseCousineState();
}

class _ChooseCousineState extends State<ChooseCousine> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(
        vacationCuisine.length,
        (index) => OptionItem(
              active: widget.cousineIndexes.contains(index),
              text: vacationCuisine[index],
              callback: () {
                setState(() {
                  if (widget.cousineIndexes.contains(index)) {
                    widget.cousineIndexes.remove(index);
                  } else {
                    widget.cousineIndexes.add(index);
                  }
                });
              },
            ));
    return Column(children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Text('Hello👋', style: AppFonts.w400s16.copyWith(fontSize: 19)),
            Text('Which one do you prefer?',
                style: AppFonts.w800s32.copyWith(fontSize: 42)),
            const SizedBox(height: 40),
            Wrap(spacing: 10, runSpacing: 12, children: children)
          ]))),
      ExpandedButton(callback: () async {
        await widget.controller.nextPage(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut);
      })
    ]);
  }
}
