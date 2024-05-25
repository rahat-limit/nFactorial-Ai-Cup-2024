import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_cubit.dart';
import 'package:nfactorial_cup/pages/main/use_cases/main_map_repository.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plan_repository_impl.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plans_repository.dart';
import 'package:nfactorial_cup/pages/posts/presentors/posts_cubit.dart';
import 'package:nfactorial_cup/pages/posts/use_cases/posts_repository.dart';
import 'package:nfactorial_cup/pages/profile/presentors/profile_cubit.dart';
import 'package:nfactorial_cup/pages/profile/use_cases/profile_repository.dart';
import 'package:nfactorial_cup/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => AppMessageCubit(),
        ),
        BlocProvider(
            lazy: false,
            create: (_) => PostCubit(repository: sl<PostRepository>())),
        BlocProvider(
            lazy: false,
            create: (_) => PlansCubit(
                repository: sl<PlansRepository>(),
                messageCubit: AppMessageCubit.read(_))),
        BlocProvider(
            lazy: false,
            create: (_) => ProfileCubit(repository: sl<ProfileRepository>())),
        BlocProvider(
            lazy: false,
            create: (_) => MainMapCubit(
                repository: sl<MainMapRepository>(),
                appMessager: AppMessageCubit.read(_))),
      ],
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
