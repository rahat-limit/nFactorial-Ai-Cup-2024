import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plans_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class PlansCubit extends Cubit<PlanState> {
  // Статические методы для прослушивания и получения кубита
  static PlanState watchState(BuildContext context) =>
      context.watch<PlansCubit>().state;
  static PlansCubit read(BuildContext context) => context.read<PlansCubit>();

  PlansCubit({
    required PlansRepository repository,
    required AppMessageCubit messageCubit,
  })  : _repository = repository,
        _messageCubit = messageCubit,
        super(PlanState(
            status: InitPlanStatus(),
            messages: [],
            foodRestrictionIds: [],
            menu: GetMenuContext(context: []),
            menuStatus: InitMenuStatus()));

  final YandexGeocoder geocoder =
      YandexGeocoder(apiKey: AppConts.geocoderApikey);

  final PlansRepository _repository;
  final AppMessageCubit _messageCubit;

  void defineMenuRestrictions({List<String>? foodRestriction}) async {
    try {
      // print(foodRestriction.join(','));
      emit(state.copyWith(menuStatus: LoadingMenuStatus()));
      String data = '';
      if (foodRestriction != null) {
        String menu = state.menu.context
            .map((e) => '{${e.id},${e.title},${e.description}}')
            .join(',');
        String restrictions = foodRestriction.join(',');
        String menuContext = 'Use Data: $menu';

        data = await _repository.sendGPTMessage(
            'I have an allergies. Provide only the Full IDs, Full Explanation Why its been chosen in format ID:Explanation, ALSO add comma after each and without unnecessary words, of items that with a high probability contain these ingredients: $restrictions, separated by commas. Example: 321:With high probability chef added ... ingridients 452:Because they might append some cheese in it',
            menuContext);
        // await Future.delayed(const Duration(milliseconds: 1500));
        // data =
        //     "13599346902524:Contains mascarpone and milk products,13599346902525:Contains cheesecake, which typically includes cream cheese or other dairy products,13599346902526:Contains mascarpone cheese,13599346902532:Contains syrups and fresshes, which may contain milk or dairy products";
      } else {
        return _messageCubit.showMessage(
            message: 'Something went wrong:(', type: MessageType.error);
      }

      var ids =
          data.split(',').map(((e) => e.split(':').first.trim())).toList();
      var explns =
          data.split(',').map(((e) => e.split(':').last.trim())).toList();

      List<MenuItemModel> items = state.menu.context;

      for (var item in items) {
        if (ids.contains(item.id)) {
          int index = ids.indexOf(item.id);
          var newItem = item.copyWith(explanation: explns[index]);
          items.remove(item);
          items.add(newItem);
        }
      }

      emit(state.copyWith(
          menuStatus: OkMenuStatus(),
          foodRestrictionIds: ids,
          menu: GetMenuContext(context: items)));
    } on DioException catch (e) {
      _messageCubit.showMessage(
          message: e.message ?? 'Error', type: MessageType.error);
    }
  }

  void getInformationByCoord() async {
    final GeocodeResponse geocodeFromPoint =
        await geocoder.getGeocode(ReverseGeocodeRequest(
      pointGeocode: (lat: 55.771899, lon: 37.597576),
      lang: Lang.enEn,
    ));
    print('dada: ${geocodeFromPoint.firstAddress?.formatted ?? 'null'}');
    // final GeocodeResponse geocodeFromAddress =
    //     await geocoder.getGeocode(DirectGeocodeRequest(
    //   addressGeocode: 'Moscow, 4th Tverskaya-Yamskaya street, 7',
    //   lang: Lang.enEn,
    // ));
  }

  void getMenuPreferencesInfo(int placeId) async {
    try {
      final menuData = await _repository.getMenuContext(placeId);
      emit(state.copyWith(menu: menuData));
    } on DioException catch (e) {
      _messageCubit.showMessage(
          message: e.message ?? 'Error', type: MessageType.error);
    }
  }
}
