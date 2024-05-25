import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';

class PlanState {
  final List<String> messages;
  final PlanStatus status;
  final MenuStatus menuStatus;
  final GetMenuContext menu;
  final List<String> foodRestrictionIds;
  const PlanState(
      {required this.messages,
      required this.status,
      required this.menu,
      required this.menuStatus,
      required this.foodRestrictionIds});

  PlanState copyWith(
      {PlanStatus? status,
      List<String>? messages,
      GetMenuContext? menu,
      MenuStatus? menuStatus,
      List<String>? foodRestrictionIds}) {
    return PlanState(
        status: status ?? this.status,
        messages: messages ?? this.messages,
        menu: menu ?? this.menu,
        menuStatus: menuStatus ?? this.menuStatus,
        foodRestrictionIds: foodRestrictionIds ?? this.foodRestrictionIds);
  }
}

abstract class PlanStatus {}

class InitPlanStatus extends PlanStatus {}

class OkPlanStatus extends PlanStatus {}

class LoadingPlanStatus extends PlanStatus {}

class ErrorPlanStatus extends PlanStatus {}

abstract class MenuStatus {}

class InitMenuStatus extends MenuStatus {}

class OkMenuStatus extends MenuStatus {}

class LoadingMenuStatus extends MenuStatus {}

class ErrorMenuStatus extends MenuStatus {}
