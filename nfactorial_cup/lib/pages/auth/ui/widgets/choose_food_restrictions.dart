import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/expanded_button.dart';
import 'package:nfactorial_cup/pages/auth/ui/widgets/option_item.dart';

class ChooseFoodRestrictions extends StatefulWidget {
  final PageController controller;
  final List<int> foodRestrictionIndexes;
  final VoidCallback callback;
  const ChooseFoodRestrictions(
      {super.key,
      required this.controller,
      required this.foodRestrictionIndexes,
      required this.callback});

  @override
  State<ChooseFoodRestrictions> createState() => _ChooseFoodRestrictionsState();
}

class _ChooseFoodRestrictionsState extends State<ChooseFoodRestrictions> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(
        foodRestrictions.length,
        (index) => OptionItem(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              active: widget.foodRestrictionIndexes.contains(index),
              text: foodRestrictions[index],
              callback: () {
                setState(() {
                  if (widget.foodRestrictionIndexes.contains(index)) {
                    widget.foodRestrictionIndexes.remove(index);
                  } else {
                    widget.foodRestrictionIndexes.add(index);
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
            Text('Hello Sofia👋',
                style: AppFonts.w400s16.copyWith(fontSize: 19)),
            Text('Any allergies or food restrictions?',
                style: AppFonts.w800s32.copyWith(fontSize: 42)),
            const SizedBox(height: 40),
            Wrap(spacing: 10, runSpacing: 12, children: children)
          ]))),
      ExpandedButton(
          text: 'Lets Start!',
          callback: () async {
            // await widget.controller.nextPage(
            //     duration: const Duration(milliseconds: 600),
            //     curve: Curves.easeInOut);
            widget.callback();
          })
    ]);
  }
}
