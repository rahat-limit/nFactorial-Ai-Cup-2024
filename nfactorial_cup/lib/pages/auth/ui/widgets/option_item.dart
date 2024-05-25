import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';

class OptionItem extends StatefulWidget {
  final String text;
  final VoidCallback callback;
  final bool active;
  final double height;
  final EdgeInsetsGeometry? padding;
  const OptionItem(
      {super.key,
      required this.text,
      required this.callback,
      required this.active,
      this.height = 70,
      this.padding});

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: widget.padding,
                backgroundColor: widget.active
                    ? const Color.fromARGB(255, 81, 155, 100)
                    : Colors.transparent,
                elevation: 0,
                // backgroundColor: AppColors.optionColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(8),
                )),
            onPressed: () {
              widget.callback();
            },
            child: Text(widget.text,
                style: AppFonts.w700s20
                    .copyWith(fontFamily: 'Roboto', color: Colors.white))));
  }
}
