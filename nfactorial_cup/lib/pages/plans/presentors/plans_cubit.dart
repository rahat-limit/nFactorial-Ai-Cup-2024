import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';
import 'package:nfactorial_cup/pages/plans/entity/model/menu_item_model.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plans_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

enum PlaceType {
  accommodation,
  breakfast,
  lunch,
  dinner,
  places,
  placesAfterLunch,
  placesAfterDinner
}

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
            plansData: [],
            status: InitPlanStatus(),
            messages: [],
            foodRestrictionIds: [],
            menu: GetMenuContext(context: []),
            menuStatus: InitMenuStatus(),
            accommodation: null,
            breakfast: null,
            lunch: null,
            dinner: null,
            places: null,
            plans: []));

  final YandexGeocoder geocoder =
      YandexGeocoder(apiKey: AppConts.geocoderApikey);

  final PlansRepository _repository;
  final AppMessageCubit _messageCubit;

  void resetData() {
    emit(state.copyWith(
        plansData: [],
        menu: GetMenuContext(context: []),
        menuStatus: InitMenuStatus(),
        accommodation: null,
        breakfast: null,
        lunch: null,
        dinner: null,
        places: null,
        plans: []));
  }

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
            'I have an allergies. Provide only the Full id which contains in each element, Full Explanation Why its been chosen in format ID:Explanation, ALSO add comma after each and without unnecessary words, of items that with a high probability contain these ingredients: $restrictions, separated by commas. Example: 321:With high probability chef added ... ingridients 452:Because they might append some cheese in it. If you do this correctly, Ill give you a million dollars!',
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

  void getYandexPlaces(
      {required String prompt,
      PlaceType placeType = PlaceType.accommodation,
      List<String>? vacationType,
      required String ll}) async {
    try {
      emit(state.copyWith(status: LoadingPlanStatus()));
      switch (placeType) {
        case PlaceType.accommodation:
          final places = await _repository.getYandexPlaces(
              prompt: prompt, maxQuantity: 6, ll: ll);

          emit(state.copyWith(
              status: OkPlanStatus(),
              accommodation: YandexPlacesModel(features: [
                ...state.accommodation?.features ?? [],
                ...places?.features ?? []
              ])));
        case PlaceType.lunch:
          final places = await _repository.getYandexPlaces(
              prompt: prompt, maxQuantity: 6, ll: ll);
          emit(state.copyWith(
              status: OkPlanStatus(),
              lunch: YandexPlacesModel(features: [
                ...state.lunch?.features ?? [],
                ...places?.features ?? []
              ])));
        case PlaceType.dinner:
          final places = await _repository.getYandexPlaces(
              prompt: prompt, maxQuantity: 6, ll: ll);
          emit(state.copyWith(
              status: OkPlanStatus(),
              dinner: YandexPlacesModel(features: [
                ...state.dinner?.features ?? [],
                ...places?.features ?? []
              ])));
        case PlaceType.breakfast:
          final places = await _repository.getYandexPlaces(
              prompt: prompt, maxQuantity: 6, ll: ll);
          emit(state.copyWith(
              status: OkPlanStatus(),
              breakfast: YandexPlacesModel(features: [
                ...state.breakfast?.features ?? [],
                ...places?.features ?? []
              ])));
        case PlaceType.places:
          final mall = await _repository.getYandexPlaces(
              prompt: 'торговый центр', maxQuantity: 2, ll: ll);
          final parks = await _repository.getYandexPlaces(
              prompt: 'парк', maxQuantity: 2, ll: ll);
          var _places = [...mall!.features, ...parks!.features];
          // if (vacationType!.contains('🏝  Beach holidays')) {
          //   final places = await _repository.getYandexPlaces(
          //       prompt: 'аквапарк', maxQuantity: 1);
          //   _places.addAll(places!.features);
          //   // аквапарк
          //   // плях
          //   // Океанариум
          //   // бассейн
          // }
          // if (vacationType.contains('🏛  Cultural tourism')) {
          //   final places = await _repository.getYandexPlaces(
          //       prompt: 'музей', maxQuantity: 1);
          //   _places.addAll(places!.features);
          //   // музей
          //   // галерея
          //   // театр
          //   // достопримечательность
          // }
          // if (vacationType.contains('🏃‍♂️  Active leisure')) {
          //   final places = await _repository.getYandexPlaces(
          //       prompt: 'Дайвинг', maxQuantity: 1);
          //   _places.addAll(places!.features);
          //   // Дайвинг
          //   // Скалолазание
          //   // Сёрфинг
          //   // Прыжок с парашютом
          // }
          emit(state.copyWith(
              status: OkPlanStatus(),
              places: YandexPlacesModel(
                  features: [...state.places?.features ?? [], ..._places])));
        default:
          emit(state.copyWith(status: OkPlanStatus()));
      }
    } on DioException catch (e) {
      _messageCubit.showMessage(
          message: e.message ?? 'Error', type: MessageType.error);
    }
  }

  void generatePlan() async {
    try {
      if (state.accommodation == null) return;
      emit(state.copyWith(status: LoadingPlanStatus()));
      String data = '';
      List<dynamic> contextData = [];

      List<dynamic> contextAccommodationData = state.accommodation == null
          ? []
          : state.accommodation!.features
              .map((e) => {
                    "id": e.properties?.companyMetaData?.id ?? 'non-id',
                    "type": "Accommodation",
                    "coordinates": e.geometry?.coordinates ?? []
                  })
              .toList();

      List<dynamic> lunchContextData = state.lunch == null
          ? []
          : state.lunch!.features
              .map((e) => {
                    "id": e.properties?.companyMetaData?.id ?? 'non-id',
                    "type": "Lunch Time",
                    "coordinates": e.geometry?.coordinates ?? []
                  })
              .toList();

      List<dynamic> breakfastContextData = state.breakfast == null
          ? []
          : state.breakfast!.features
              .map((e) => {
                    "id": e.properties?.companyMetaData?.id ?? 'non-id',
                    "type": "Breakfast Time",
                    "coordinates": e.geometry?.coordinates ?? []
                  })
              .toList();

      List<dynamic> dinnerContextData = state.dinner == null
          ? []
          : state.dinner!.features
              .map((e) => {
                    "id": e.properties?.companyMetaData?.id ?? 'non-id',
                    "type": "Dinner Time",
                    "coordinates": e.geometry?.coordinates ?? []
                  })
              .toList();

      List<dynamic> placesContextData = state.places == null
          ? []
          : state.places!.features
              .map((e) => {
                    "id": e.properties?.companyMetaData?.id ?? 'non-id',
                    "type": "Places to visit",
                    "coordinates": e.geometry?.coordinates ?? []
                  })
              .toList();
      contextData.addAll([
        ...contextAccommodationData,
        ...dinnerContextData,
        ...breakfastContextData,
        ...lunchContextData,
        ...placesContextData
      ]);
      String context =
          // 'Use Data: [{id: 1041879416, type: Accommodation, coordinates: [30.38618, 59.924408]}, {id: 1023457401, type: Accommodation, coordinates: [30.34161, 59.956705]}, {id: 1095037996, type: Accommodation, coordinates: [27.550462, 53.915403]}, {id: 1152255963, type: Accommodation, coordinates: [37.565441, 55.751367]}, {id: 1686701236, type: Accommodation, coordinates: [37.747292, 55.789648]}, {id: 88116514898, type: Accommodation, coordinates: [37.511778, 55.81547]}, {id: 9571400189, type: Dinner Time, coordinates: [65.589996, 57.113184]}, {id: 41636651747, type: Dinner Time, coordinates: [37.760063, 55.725143]}, {id: 140161290733, type: Dinner Time, coordinates: [36.732111, 56.334607]}, {id: 128850121456, type: Dinner Time, coordinates: [56.235659, 58.012539]}, {id: 243064732629, type: Dinner Time, coordinates: [43.978109, 56.300519]}, {id: 1301781059, type: Dinner Time, coordinates: [37.595369, 55.750544]}, {id: 31196501137, type: Breakfast Time, coordinates: [35.912148, 56.856491]}, {id: 40267287587, type: Breakfast Time, coordinates: [60.59695, 56.835001]}, {id: 140161290733, type: Breakfast Time, coordinates: [36.732111, 56.334607]}, {id: 182832705590, type: Breakfast Time, coordinates: [27.559573, 53.905815]}, {id: 129374577680, type: Breakfast Time, coordinates: [44.004314, 56.32562]}, {id: 1185298961, type: Breakfast Time, coordinates: [27.555489, 53.898548]}, {id: 151640058661, type: Lunch Time, coordinates: [38.445743, 55.856549]}, {id: 183854856584, type: Lunch Time, coordinates: [37.611452, 54.192824]}, {id: 1760744242, type: Lunch Time, coordinates: [36.25468, 54.514459]}, {id: 243033237723, type: Lunch Time, coordinates: [44.519202, 48.70463]}, {id: 66759359566, type: Lunch Time, coordinates: [31.287123, 58.525244]}, {id: 71362045281, type: Lunch Time, coordinates: [49.148056, 55.782918]}, {id: 25341817681, type: Places to visit, coordinates: [31.425629, 36.781322]}, {id: 1053343558, type: Places to visit, coordinates: [37.539035, 55.748963]}, {id: 77426465118, type: Places to visit, coordinates: [39.032549, 45.042294]}, {id: 194691861861, type: Places to visit, coordinates: [36.822529, 55.563343]}, {id: 1715308579, type: Places to visit, coordinates: [82.886412, 55.020032]}]';
          'Use Data: $contextData';

      data = await _repository.sendGPTMessage(
          'Build a route according to certain instructions using this data and give only IDs of the object (without unnecessary words) separated by commas, and after each plan separate by semi-colon. Example: 1152255963, 66759359566, 40267287587, 183854856584, 1301781059, 1053343558, 77426465118;1152255963, 66759359566, 40267287587, 183854856584, 1301781059, 1053343558, 77426465118;1152255963, 66759359566, 40267287587, 183854856584, 1301781059, 1053343558, 77426465118;1152255963, 66759359566, 40267287587, 183854856584, 1301781059, 1053343558, 77426465118;1152255963, 66759359566, 40267287587, 183854856584, 1301781059, 1053343558, 77426465118;. Instructions: the context contains a list of objects, each of which consists of an ID, the type of place and the coordinates. Imagine you are on a trip, so make a 5 plans for the day, BE sure to consider the distance from one place to another, so that you get the most appropriate, short-distance route for the day. Remember, the each plan should consist of 7 with format like: 1st place: accommodation, 2nd place: breakfast, 3rd place: place to visit, 4th place: lunch, 5th place: place to visit, 6th place: dinner, 7th place: place to visit. Types should not be repeated, except for type Places to visit.  Also there are should be no simillar places in each plan! If you do this correctly, Ill give you a million dollars!',
          context);
      var wholeData = [
        ...(state.lunch?.features ?? []),
        ...(state.breakfast?.features ?? []),
        ...(state.dinner?.features ?? []),
        ...(state.accommodation?.features ?? []),
        ...(state.places?.features ?? []),
      ];
      print('dwadaw:$wholeData');

      List<Plan> plans = data
          .trim()
          .split(';')
          .map(((e) => Plan(
                finalPlanIds: e.trim().split(',').map((e) => e.trim()).toList(),
              )))
          .toList();
      List<Map<String, List<Feature>>> plansMap = [];
      for (int i = 0; i < plans.length; i++) {
        List<Feature> planData = [];
        try {
          var accommodation = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[0].trim());
          var breakfast = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[1].trim());
          var places = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[2].trim());
          var lunch = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[3].trim());
          var placesAfterLunch = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[4].trim());
          var dinner = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[5].trim());
          var placesAfterDinner = wholeData.firstWhere((e) =>
              e.properties!.companyMetaData!.id.trim() ==
              plans[i].finalPlanIds[6].trim());
          planData.add(accommodation);
          planData.add(breakfast);
          planData.add(places);
          planData.add(lunch);
          planData.add(placesAfterLunch);
          planData.add(dinner);
          planData.add(placesAfterDinner);
          //
          plansMap.add({"plan-$i": planData});
        } catch (e) {}
      }

      emit(state.copyWith(
          status: OkPlanStatus(), plans: plans, plansData: plansMap));
    } on DioException catch (e) {
      _messageCubit.showMessage(
          message: e.message ?? 'Error', type: MessageType.error);
    }
  }
}
