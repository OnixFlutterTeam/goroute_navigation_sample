import 'package:get_it/get_it.dart';
import 'package:go_router_demo/arch/data/local/prefs/base_preferences.dart';
import 'package:go_router_demo/data/local/source/preferences_source/preferences_source.dart';
import 'package:go_router_demo/data/local/source/preferences_source/preferences_source_impl.dart';
import 'package:go_router_demo/data/local/source/product/product_source.dart';
import 'package:go_router_demo/data/local/source/product/product_source_impl.dart';
import 'package:go_router_demo/data/services/auth_service.dart';
import 'package:go_router_demo/data/services/dynamic_link_service.dart';
import 'package:go_router_demo/domain/repository/favourite/product_favourite_repository.dart';
import 'package:go_router_demo/domain/repository/favourite/product_favourite_repository_impl.dart';
import 'package:go_router_demo/domain/repository/product/product_repository.dart';
import 'package:go_router_demo/domain/repository/product/product_repository_impl.dart';
import 'package:go_router_demo/presentation/screens/main/home/bloc/home_bloc.dart';
import 'package:go_router_demo/presentation/screens/main/home/inner_screens/favourites/bloc/fav_bloc.dart';

GetIt getIt = GetIt.I;

void setUpServiceLocator() {
  //SERVICE
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerLazySingleton<DynamicLinkService>(() => DynamicLinkService());

  // REPOSITORY
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  getIt.registerLazySingleton<ProductFavouriteRepository>(
      () => ProductFavouriteRepositoryImpl());

  // SOURCE
  getIt.registerSingleton<ProductSource>(ProductSourceImpl(
    getIt.get<ProductRepository>(),
    getIt.get<ProductFavouriteRepository>(),
  ));
  getIt.registerLazySingleton<PreferencesSource>(
      () => PreferencesSourceImpl(getIt.get<BasePreferences>()));

  // PREFS
  getIt.registerLazySingleton(() => BasePreferences());

  // BLOC
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerFactory<FavouriteBloc>(() => FavouriteBloc());
}

// SOURCE
ProductSource productSource() => getIt.get<ProductSource>();

PreferencesSource preferencesSource() => getIt.get<PreferencesSource>();

//SERVICE
AuthService authService() => getIt.get<AuthService>();

DynamicLinkService dynamicLinkService() => getIt<DynamicLinkService>();
