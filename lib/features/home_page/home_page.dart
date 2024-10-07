import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';
import 'package:vw/vw.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: "Flashee".pageTitle,
        actions: [
          IconButton(
            icon: Icon(
              themeState.lightTheme //
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              themeState.setLightTheme(!themeState.lightTheme);
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: languages.length,
          itemBuilder: (context, index) {
            Language language = languages[index];

            return ListTile(
              title: language.name.text.fontSize(20),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              leading: VWBox(
                borderRadius: BorderRadius.circular(100),
                padding: const EdgeInsets.all(3),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
                child: Image.asset(
                  language.image,
                  width: 30,
                  height: 30,
                ),
              ),
              onTap: () {
                context.push('/prompt', extra: language);
              },
            );
          },
        ),
      ),
    );
  }
}
