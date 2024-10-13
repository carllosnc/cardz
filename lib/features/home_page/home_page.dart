import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';
import 'package:vw/vw.dart';
import 'package:localize/localize.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SharedState, LocalizeMixin {
  @override
  void initState() {
    super.initState();

    for (var language in languages) {
      database.countFlashContentByLanguage(language);
    }
  }

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
            var cards = database.countByLanguage[language.name];

            return ListTile(
              title: language.name.localize.text.fontSize(20).bold,
              subtitle: "$cards Card" //
                  .localize
                  .pluralize(cards)
                  .text
                  .fontSize(16)
                  .color(context.primary),
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
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: VWRow(
          horizontalAlignment: MainAxisAlignment.center,
          verticalAlignment: CrossAxisAlignment.center,
          gap: 10,
          children: [
            "my native language is".localize.text.fontSize(16).bold,
            VWButton(
              color: Colors.transparent,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                width: 1,
              ),
              label: languages //
                  .where((element) => element.abbr == localizeState.currentLanguage)
                  .first
                  .name
                  .localize,
              onTap: () {
                VWSheet.open(
                  isScrollControlled: false,
                  appBar: AppBar(
                    title: "native language".pageTitle,
                  ),
                  context: context,
                  body: ListView.builder(
                    itemCount: localizeState.languages.length,
                    itemBuilder: (context, index) {
                      var flag = languages.where((element) => element.abbr == localizeState.languages[index]).first.flag;
                      var name = languages.where((element) => element.abbr == localizeState.languages[index]).first.name;

                      return ListTile(
                        leading: flag.text.fontSize(18),
                        title: name.localize.text.fontSize(18),
                        onTap: () {
                          localizeState.setLanguage(localizeState.languages[index]);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
