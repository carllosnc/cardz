import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';
import '/imports.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: "Cardz".pageTitle,
      ),
      bottomSheet: Container(
        width: 200,
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(20),
        child: VWButton(
          onTap: () {
            sharedPreferences.prefs.setBool('welcome', false);
            context.go('/home');
          },
          color: Colors.black,
          label: "Get Started",
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: VWColumn(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          verticalAlignment: MainAxisAlignment.center,
          horizontalAlignment: CrossAxisAlignment.center,
          gap: 20,
          children: [
            Image.asset(
              context.logo,
              width: 140,
            ),
            "Learn Faster,\nRemember Longer!".text.fontSize(20).center,
          ],
        ),
      ),
    );
  }
}
