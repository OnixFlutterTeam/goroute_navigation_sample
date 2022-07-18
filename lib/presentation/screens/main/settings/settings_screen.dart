import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/arch/widget/common/misk.dart';
import 'package:go_router_demo/presentation/widgets/misk.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Delimiter.height(16),
            const Text('Settings screen'),
            const Delimiter.height(16),
            DefaultButton(
              title: 'Pop',
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
