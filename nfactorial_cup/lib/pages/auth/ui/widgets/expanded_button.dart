import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';

class ExpandedButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const ExpandedButton(
      {super.key, this.text = 'Continue', required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: callback,
          child: Text(text,
              style: AppFonts.w600s16
                  .copyWith(color: Colors.black, fontSize: 18))),
    );
  }
}
