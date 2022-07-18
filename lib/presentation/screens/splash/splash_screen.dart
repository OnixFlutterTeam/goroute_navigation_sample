import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/widgets/common/toast.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 260,
                  height: 120,
                  child: Placeholder(),
                ),
              ),
              const Delimiter.height(16),
              const Text('Splash screen'),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Navigate to main screen',
                onTap: () {
                  context.go(AppRouter.pathMain);
                },
              ),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Navigate to auth screen flow',
                onTap: () {
                  context.go(AppRouter.pathSignIn);
                },
              ),
              const Delimiter.height(16),
              Platform.isAndroid
                  ? DefaultButton(
                      title: 'Create dynamic deep link to settings screen',
                      onTap: () async {
                        final url =
                            await dynamicLinkService().createDynamicLink(true);
                        if (!mounted) return;
                        _showSnackBar(context, url);
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text('Paste the link into the browser\n$message'),
      action: SnackBarAction(
        label: 'Copy link',
        onPressed: () {
          Clipboard.setData(ClipboardData(text: message));
          CustomToast.showToast('Copied');
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
