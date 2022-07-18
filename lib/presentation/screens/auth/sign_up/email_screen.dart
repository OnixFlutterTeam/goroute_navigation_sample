import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/internal/router/app_router.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({Key? key}) : super(key: key);

  final _textController = TextEditingController(text: 'some_email@some.com');

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
                const Text('Email screen'),
                const Delimiter.height(16),
                TextField(
                  controller: _textController,
                  maxLines: 1,
                ),
                const Delimiter.height(16),
                DefaultButton(
                  title: 'Confirm email',
                  onTap: () {
                    context.go(
                      AppRouter.pathPassword,
                      extra: _textController.text,
                    );
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
}
