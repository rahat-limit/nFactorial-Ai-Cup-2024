import 'package:nfactorial_cup/data/local_db/context_storage.dart';
import 'package:nfactorial_cup/data/local_db/token_storage.dart';
import 'package:nfactorial_cup/data/local_db/theme_storage.dart';
import 'package:nfactorial_cup/data/network/dio_provider.dart';
import 'package:nfactorial_cup/pages/main/entity/api/gpt_api.dart';
import 'package:nfactorial_cup/pages/main/entity/api/places_api.dart';
import 'package:nfactorial_cup/pages/main/use_cases/main_map_repository.dart';
import 'package:nfactorial_cup/pages/main/use_cases/main_map_repository_impl.dart';
import 'package:nfactorial_cup/pages/plans/entity/api/plans_api.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plan_repository_impl.dart';
import 'package:nfactorial_cup/pages/plans/use_cases/plans_repository.dart';
import 'package:nfactorial_cup/pages/posts/entity/api/posts_api.dart';
import 'package:nfactorial_cup/helpers/theme_notifier.dart';
import 'package:nfactorial_cup/pages/posts/use_cases/posts_repository.dart';
import 'package:nfactorial_cup/pages/posts/use_cases/posts_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfactorial_cup/pages/profile/entity/api/profile_api.dart';
import 'package:nfactorial_cup/pages/profile/use_cases/profile_repository.dart';
import 'package:nfactorial_cup/pages/profile/use_cases/profile_repository_impl.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerSingletonAsync(() async => await SharedPreferences.getInstance());

  Future.delayed(const Duration(seconds: 5));

  sl.registerLazySingleton<ThemeStorage>(() => ThemeStorage(prefs: sl()));
  sl.registerLazySingleton<ContextStorage>(() => const ContextStorage());

  sl.registerLazySingleton<ThemeNotifier>(
      () => ThemeNotifier(themeStorage: sl()));

  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(prefs: sl()));
  sl.registerLazySingleton<Dio>(() => DioProvider().get());

  // API
  sl.registerLazySingleton<PostApi>(() => PostApi(sl()));

  sl.registerLazySingleton<ProfileApi>(() => ProfileApi(dio: sl()));
  sl.registerLazySingleton<PlacesApi>(() => PlacesApi(
      dio: DioProvider(type: UrlType.geocode).get(),
      placesDio: DioProvider(type: UrlType.places).get()));
  sl.registerLazySingleton<PlansApi>(() => PlansApi(
      scraperApi: DioProvider(type: UrlType.scraper).get(),
      dio: DioProvider(type: UrlType.gpt).get()));
  sl.registerLazySingleton<GptApi>(
      () => GptApi(dio: sl(), contextStorage: sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(postsApi: sl(), tokenStorage: sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<MainMapRepository>(
      () => MainMapRepositoryImpl(api: sl(), gptApi: sl()));
  sl.registerLazySingleton<PlansRepository>(() =>
      PlanRepositoryImpl(placesApi: sl(), plansApi: sl(), tokenStorage: sl()));
}
