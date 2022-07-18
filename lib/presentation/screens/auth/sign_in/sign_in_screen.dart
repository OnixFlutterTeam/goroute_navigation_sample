import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/widgets/common/toast.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sign in screen'),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Make auto sign in -> navigate to main screen',
                onTap: () async {
                  authService().login('some_email@some.com', 'some_password');
                  CustomToast.showToast(
                    'signed in with credentials: some_email@some.com/some_password',
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  await Future.delayed(const Duration(seconds: 1));
                  if (!mounted) return;
                  context.go(AppRouter.pathMain);
                },
              ),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Try to navigate to main screen (without sign in)',
                onTap: () {
                  context.go(AppRouter.pathMain);
                },
              ),
              const Delimiter.height(16),
              DefaultButton(
                title: 'Navigate to sign up screen',
                onTap: () {
                  context.go(AppRouter.pathEmail);
                  // context.navigateTo(const SignUpRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
