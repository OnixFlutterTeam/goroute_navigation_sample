import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router_demo/arch/logger.dart';
import 'package:go_router_demo/internal/router/app_router.dart';

class DynamicLinkService {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<String> createDynamicLink(bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://autoroutedemo.page.link',
      link: Uri.parse('https://autoroutedemo.page.link/signIn'),
      androidParameters: const AndroidParameters(
        packageName: 'com.demo.gorouter.go_router_demo',
        minimumVersion: 1,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    return url.toString();
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();
      if (data != null) {
        _handleDeepLink(data, context);
      }
      dynamicLinks.onLink.listen((dynamicLinkData) {
        _handleDeepLink(dynamicLinkData, context);
      }).onError((error) {
        Logger.printException(error);
      });
    } catch (e) {
      Logger.printException(e);
    }
  }

  Future<void> _handleDeepLink(
      PendingDynamicLinkData data, BuildContext context) async {
    final Uri deepLink = data.link;
    Logger.log('deepLink: $deepLink, ${deepLink.pathSegments.last}');
    AppRouter.router.go('/${deepLink.pathSegments.last}');
  }
}
