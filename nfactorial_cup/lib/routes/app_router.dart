import 'package:auto_route/auto_route.dart';
import 'package:nfactorial_cup/pages/auth/ui/collect_data_page.dart';
import 'package:nfactorial_cup/pages/main/ui/main_screen.dart';
import 'package:nfactorial_cup/pages/navigation/ui/navigation.dart';
import 'package:nfactorial_cup/pages/plans/ui/plan_detail_page.dart';
import 'package:nfactorial_cup/pages/plans/ui/plans_list_page.dart';
import 'package:nfactorial_cup/pages/posts/ui/posts_page.dart';
import 'package:nfactorial_cup/pages/profile/ui/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // AutoRoute(
        //       initial: true,
        //       page: PlanDetailRoute.page,
        //     ),
        AutoRoute(
          // initial: true,
          page: CollectDataRoute.page,
        ),
        AutoRoute(initial: true, page: NavigationRoute.page, children: [
          AutoRoute(page: PlansListRoute.page, initial: true),
          AutoRoute(
            page: MainRoute.page,
            // initial: true
          ),
          AutoRoute(page: ProfileRoute.page)
        ])
      ];
}
