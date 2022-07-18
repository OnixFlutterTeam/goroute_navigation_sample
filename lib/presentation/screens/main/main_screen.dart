import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/widgets/common/will_pop_dialog.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopDialog.onTryCloseApp(context),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('MAIN'),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Navigate to home screen',
                  onTap: () {
                    context.goNamed(AppRouter.homeRouteName,
                        params: {'tab': 'list'});
                  },
                ),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Navigate to profile screen',
                  onTap: () {
                    context.go(AppRouter.pathProfile);
                  },
                ),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Navigate to splash screen',
                  onTap: () {
                    context.go(AppRouter.pathSplash);
                  },
                ),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Navigate to add product screen',
                  onTap: () {
                    // context.navigateTo(
                    //   const HomeRoute(children: [
                    //     ProductsRouter(children: [
                    //       ProductListRouter(),
                    //       AddProductRoute(),
                    //     ])
                    //   ]),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
