import 'package:firebase_core/firebase_core.dart';
import 'package:go_router_demo/arch/logger.dart';
import 'package:go_router_demo/data/services/mock_service.dart';
import 'package:go_router_demo/dependency/service_locator.dart';

class AppInitialization {
  AppInitialization._privateConstructor();

  static final AppInitialization _instance =
      AppInitialization._privateConstructor();

  static AppInitialization get I => _instance;

  Future<void> initApp() async {
    var app = await Firebase.initializeApp();

    setUpServiceLocator();
    MockService().create();
    Logger.log('APP Init: done');
  }
}
