import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Profile screen'),
              const Delimiter.height(16),
              DefaultButton(
                title: 'LogOut -> navigate to sign in screen',
                onTap: () {
                  authService().logOut();
                  context.go(AppRouter.pathSplash);
                },
              ),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Navigate to settings screen',
                onTap: () {
                  context.push(AppRouter.pathSettings);
                },
              ),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Navigate to main screen',
                onTap: () {
                  context.go(AppRouter.pathMain);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
