import 'package:flutter/cupertino.dart';
import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:flutter/material.dart';

class ExceptionTracker {
  appearByMessageType(
      {required BuildContext context, required AppMessageState state}) {
    switch (state.messageType) {
      case MessageType.system:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message,
                style: AppFonts.w400s14.copyWith(color: AppColors.white)),
            backgroundColor: AppColors.darkGrey2));
      case MessageType.error:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message,
                style: AppFonts.w400s14.copyWith(color: AppColors.white)),
            backgroundColor: Colors.redAccent));
      case MessageType.info:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message,
                style: AppFonts.w400s14.copyWith(color: AppColors.white)),
            backgroundColor: Colors.orangeAccent));
      case MessageType.success:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message,
                style: AppFonts.w400s14.copyWith(color: AppColors.white)),
            backgroundColor: Colors.green[400]));

      default:
    }
    if (state.messageType == MessageType.system) {}
  }
}
