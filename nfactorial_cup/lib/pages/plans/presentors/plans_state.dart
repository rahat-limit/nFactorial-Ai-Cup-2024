import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';

class Plan {
  final List<String> finalPlanIds;

  Plan({required this.finalPlanIds});
}

class PlanState {
  final List<String> messages;
  final PlanStatus status;
  final MenuStatus menuStatus;
  final GetMenuContext menu;
  final List<String> foodRestrictionIds;
  final YandexPlacesModel? accommodation;
  final YandexPlacesModel? breakfast;
  final YandexPlacesModel? lunch;
  final YandexPlacesModel? dinner;
  final YandexPlacesModel? places;
  final List<Plan>? plans;
  final List<Map<String, List<Feature>>> plansData;
  const PlanState(
      {required this.breakfast,
      required this.lunch,
      required this.dinner,
      required this.places,
      required this.messages,
      required this.status,
      required this.menu,
      required this.menuStatus,
      required this.foodRestrictionIds,
      required this.accommodation,
      required this.plans,
      required this.plansData});

  PlanState copyWith(
      {PlanStatus? status,
      List<String>? messages,
      GetMenuContext? menu,
      MenuStatus? menuStatus,
      List<String>? foodRestrictionIds,
      YandexPlacesModel? accommodation,
      YandexPlacesModel? breakfast,
      YandexPlacesModel? lunch,
      YandexPlacesModel? dinner,
      YandexPlacesModel? places,
      List<Plan>? plans,
      List<Map<String, List<Feature>>>? plansData}) {
    return PlanState(
        status: status ?? this.status,
        messages: messages ?? this.messages,
        menu: menu ?? this.menu,
        menuStatus: menuStatus ?? this.menuStatus,
        foodRestrictionIds: foodRestrictionIds ?? this.foodRestrictionIds,
        accommodation: accommodation ?? this.accommodation,
        breakfast: breakfast ?? this.breakfast,
        lunch: lunch ?? this.lunch,
        dinner: dinner ?? this.dinner,
        places: places ?? this.places,
        plans: plans ?? this.plans,
        plansData: plansData ?? this.plansData);
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
