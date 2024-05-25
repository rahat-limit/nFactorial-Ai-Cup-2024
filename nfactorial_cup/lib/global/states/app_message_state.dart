part of '../cubits/app_message_cubit.dart';

enum MessageType { info, error, system, none, popUp, success }

class AppMessageState {
  final MessageType messageType;
  final String message;
  final int durationInSeconds;
  final bool shouldUpdateApp;

  AppMessageState({
    required this.message,
    required this.messageType,
    this.durationInSeconds = 4,
    this.shouldUpdateApp = false,
  });
}
