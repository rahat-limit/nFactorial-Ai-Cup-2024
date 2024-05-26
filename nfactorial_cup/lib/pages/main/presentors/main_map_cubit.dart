import 'package:nfactorial_cup/global/cubits/app_message_cubit.dart';
import 'package:nfactorial_cup/helpers/app_conts.dart';
import 'package:nfactorial_cup/helpers/app_location.dart';
import 'package:nfactorial_cup/pages/main/entity/model/place_model.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';
import 'package:nfactorial_cup/pages/main/presentors/main_map_state.dart';
import 'package:nfactorial_cup/pages/main/use_cases/main_map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class MainMapCubit extends Cubit<MainMapState> {
  // Статические методы для прослушивания и получения кубита
  static MainMapState watchState(BuildContext context) =>
      context.watch<MainMapCubit>().state;
  static MainMapCubit read(BuildContext context) =>
      context.read<MainMapCubit>();

  MainMapCubit(
      {required MainMapRepository repository,
      required AppMessageCubit appMessager})
      : _repository = repository,
        _appMessager = appMessager,
        super(MainMapState(
            markers: [],
            status: InitMainMapStatus(),
            locations: null,
            searchLocations: null,
            currentCity: CurrentLocation(
                city: '',
                coordinates:
                    // 51.128201, 71.430429
                    const AppLatLong(lat: 51.128201, long: 71.430429))));

  final YandexGeocoder geocoder =
      YandexGeocoder(apiKey: AppConts.geocoderApikey);

  final MainMapRepository _repository;
  final AppMessageCubit _appMessager;

  void changeCurrentCity(CurrentLocation city) {
    emit(state.copyWith(currentCity: city));
  }

  void searchLocations(String text) async {
    emit(state.copyWith(status: LoadingMainMapStatus()));
    LocationsModel? locations = await _repository.searchLocations(text);
    try {
      print(locations!.response!.geoObjectCollection!.featureMember![0]
          .geoObject!.point!.pos);
      emit(state.copyWith(
          searchLocations: locations, status: OkMainMapStatus()));
    } catch (e) {
      _appMessager.showMessage(
          message: 'Error Appeard', type: MessageType.error);
    }
  }

  void displayPlacesOnMap(List<Feature> places) async {
    // emit(state.copyWith(status: LoadingMainMapStatus()));
    // await _repository.getMapPlaces();

    try {
      // Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: OkMainMapStatus(), markers: places));
      // ...state.places,
      // PlaceModel(
      //   title: 'Title',
      //   description: 'Description',
      //   coordinates: const AppLatLong(lat: 51.150235, long: 71.421672),
      // ),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.162744, long: 71.438227)),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.134344, long: 71.404386)),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.148018, long: 71.461948)),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.134240, long: 71.455793)),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.121085, long: 71.434809)),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.117909, long: 71.473777)),
      // PlaceModel(
      //     title: 'Title',
      //     description: 'Description',
      //     coordinates: const AppLatLong(lat: 51.134584, long: 71.402673)),
      // ]));
    } catch (e) {
      _appMessager.showMessage(
          message: 'Error Appeard', type: MessageType.error);
    }
  }

  void getInformationByCoord() async {
    final GeocodeResponse geocodeFromPoint =
        await geocoder.getGeocode(ReverseGeocodeRequest(
      pointGeocode: (lat: 55.771899, lon: 37.597576),
      lang: Lang.enEn,
    ));

    // print('dada: ${geocodeFromPoint.firstAddress?.formatted ?? 'null'}');
    // final GeocodeResponse geocodeFromAddress =
    //     await geocoder.getGeocode(DirectGeocodeRequest(
    //   addressGeocode: 'Moscow, 4th Tverskaya-Yamskaya street, 7',
    //   lang: Lang.enEn,
    // ));
  }

  // void sendGPTMessage(String prompt) async {
  //   try {
  //     emit(state.copyWith(status: LoadingMainMapStatus()));
  //     String data = await _repository.sendGPTMessage(prompt);
  //     emit(state.copyWith(
  //         status: OkMainMapStatus()));
  //   } on DioException catch (e) {
  //     print(e);
  //   }
}
