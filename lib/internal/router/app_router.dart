import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/presentation/screens/auth/sign_in/sign_in_screen.dart';
import 'package:go_router_demo/presentation/screens/auth/sign_up/email_screen.dart';
import 'package:go_router_demo/presentation/screens/auth/sign_up/password_screen.dart';
import 'package:go_router_demo/presentation/screens/main/home/home_screen.dart';
import 'package:go_router_demo/presentation/screens/main/main_screen.dart';
import 'package:go_router_demo/presentation/screens/main/product/product_screen.dart';
import 'package:go_router_demo/presentation/screens/main/profile/profile_screen.dart';
import 'package:go_router_demo/presentation/screens/main/settings/settings_screen.dart';
import 'package:go_router_demo/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String pathSplash = '/';
  static const String pathSignIn = '/signIn';
  static const String pathEmail = '/email';
  static const String pathPassword = '/password';
  static const String pathMain = '/main';
  static const String pathProfile = '/profile';
  static const String pathSettings = '/settings';
  static const String pathHome = '/home/:tab';
  static const String pathProduct = '/product';
  static const String pathProductList = '/product_list';
  static const String pathFavourite = '/fav';
  static const String pathInfo = '/info';

  static const String homeRouteName = 'home';

  static final router = GoRouter(
    initialLocation: pathSplash,
    routes: <GoRoute>[
      GoRoute(
        path: pathSplash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: pathSignIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: pathEmail,
        builder: (context, state) => EmailScreen(),
      ),
      GoRoute(
        path: pathPassword,
        builder: (context, state) => PasswordScreen(
          email: state.extra as String,
        ),
      ),
      GoRoute(
        redirect: _authRedirect,
        path: pathMain,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: pathProfile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: pathSettings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: homeRouteName,
        path: pathHome,
        builder: (context, state) {
          final tab = state.params['tab']!;
          return HomeScreen(tab: tab);
        },
      ),
      GoRoute(
        path: pathProductList,
        redirect: (state) =>
            state.namedLocation(homeRouteName, params: {'tab': 'list'}),
      ),
      GoRoute(
        path: pathFavourite,
        redirect: (state) =>
            state.namedLocation(homeRouteName, params: {'tab': 'fav'}),
      ),
      GoRoute(
        path: pathInfo,
        redirect: (state) =>
            state.namedLocation(homeRouteName, params: {'tab': 'info'}),
      ),
      GoRoute(
        path: pathProduct,
        name: 'ProductItemRouter',
        builder: (context, state) => ProductScreen(
          productId: state.extra as int,
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );

  static String? _authRedirect(state) {
    final loggedIn = authService().isLoggedIn;
    final loggingIn = state.subloc == pathSignIn;
    if (!loggedIn) return loggingIn ? null : pathSignIn;
    if (loggingIn) return pathMain;
    return null;
  }
}
