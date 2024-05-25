import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/routes/app_router.dart';

@RoutePage()
class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationState();
}

class _NavigationState extends State<NavigationPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        routes: const [PlansListRoute(), MainRoute(), ProfileRoute()],
        bottomNavigationBuilder: (_, tabController) {
          return BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.navbarColors,
              currentIndex: tabController.activeIndex,
              onTap: (value) async {
                if (tabController.activeIndex == value) {
                  tabController.popTop();
                } else {
                  tabController.setActiveIndex(value);
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/pngs/Shortlist.png',
                    width: 40,
                    height: 40,
                  ),
                  label: '',
                  activeIcon: Image.asset(
                    'assets/pngs/Shortlist_active.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.navbarMainButton,
                            boxShadow: const [
                              BoxShadow(blurRadius: 4, color: Colors.white38)
                            ],
                            borderRadius: BorderRadius.circular(25)),
                        child: Image.asset('assets/pngs/Address.png',
                            width: 40, height: 40)),
                    activeIcon: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.navbarMainButton,
                            boxShadow: const [
                              BoxShadow(blurRadius: 4, color: Colors.white38)
                            ],
                            borderRadius: BorderRadius.circular(25)),
                        child: Image.asset('assets/pngs/Address.png',
                            width: 40, height: 40)),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/pngs/Person.png',
                        width: 45, height: 45),
                    activeIcon: Image.asset('assets/pngs/Person_active.png',
                        width: 45, height: 45),
                    label: '')
              ]);
        });
  }
}
