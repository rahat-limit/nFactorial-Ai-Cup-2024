import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../states/app_message_state.dart';

class AppMessageCubit extends Cubit<AppMessageState> {
  // Статические методы для прослушивания и получения кубита
  static AppMessageState watchState(BuildContext context) =>
      context.watch<AppMessageCubit>().state;
  static AppMessageCubit read(BuildContext context) =>
      context.read<AppMessageCubit>();

  AppMessageCubit()
      : super(AppMessageState(message: '', messageType: MessageType.none));

  void refreshApp() {
    emit(AppMessageState(message: '', messageType: MessageType.none));
  }

  void showMessage({required String message, required MessageType type}) {
    emit(AppMessageState(message: message, messageType: type));
  }
}
