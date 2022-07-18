import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/logger.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/dependency/service_locator.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/widgets/common/toast.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  final _textController = TextEditingController(text: 'some_password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Password screen'),
                const Delimiter.height(16),
                TextField(
                  controller: _textController,
                  maxLines: 1,
                ),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Confirm password',
                  onTap: () async {
                    final result = await validateEmailAndPassword(
                        email, _textController.text);
                    if (result) {
                      context.go(AppRouter.pathMain);
                    }
                  },
                ),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Navigate to sign in screen',
                  onTap: () {
                    context.go(AppRouter.pathSignIn);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> validateEmailAndPassword(
    String email,
    String password,
  ) async {
    Logger.log('email: $email, password: $password');
    CustomToast.showToast('email: $email, password: $password');
    authService().completeSignUp(email, password);
    await Future.delayed(const Duration(milliseconds: 1000));
    return true;
  }
}
