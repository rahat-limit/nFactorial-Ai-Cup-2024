import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PlansListPage extends StatefulWidget {
  const PlansListPage({super.key});

  @override
  State<PlansListPage> createState() => _PlansListPageState();
}

class _PlansListPageState extends State<PlansListPage> {
  @override
  void initState() {
    super.initState();
    // PlansCubit.read(context).getMenuPreferencesInfo(135993469025);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Plans List')));
  }
}
