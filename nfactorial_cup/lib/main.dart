import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nfactorial_cup/services/service_locator.dart';
import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/helpers/exception_tracker.dart';
import 'package:nfactorial_cup/helpers/internet_connection_validator.dart';
import 'package:nfactorial_cup/helpers/multi_bloc_wrapper.dart';
import 'package:nfactorial_cup/routes/app_router.dart';
import 'package:nfactorial_cup/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  await sl.allReady();
  GetIt.I.isReady<SharedPreferences>().then((_) {
    runApp(const AppSetup());
  });
}

class AppSetup extends StatelessWidget {
  const AppSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocWrapper(
        child: MaterialApp.router(
      theme: ThemeData(fontFamily: 'BlinkerSemiBold'),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return InternetConnectionValidator(
            child: BlocListener<AppMessageCubit, AppMessageState>(
                listener: (context, state) {
                  ExceptionTracker()
                      .appearByMessageType(context: context, state: state);
                },
                child: child));
      },
      routerConfig: AppRouter().config(),
    ));
  }
}
