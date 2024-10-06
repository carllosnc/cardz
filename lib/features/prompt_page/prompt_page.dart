import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import './components/input_prompt.dart';
import './components/flash_card.dart';
import '/imports.dart';

class PromptPage extends StatefulWidget {
  final Language languageToLearn;

  const PromptPage({
    super.key,
    required this.languageToLearn,
  });

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> with SharedState {
  @override
  void initState() {
    super.initState();
    database.getAllFlashContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.languageToLearn.name.pageTitle,
        forceMaterialTransparency: true,
      ),
      body: Builder(builder: (context) {
        if (database.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (database.flashContentList.isEmpty) {
          return SizedBox(
            width: double.infinity,
            child: VWColumn(
              gap: 10,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              horizontalAlignment: CrossAxisAlignment.center,
              verticalAlignment: MainAxisAlignment.center,
              children: [
                "No flashcard created yet.".text.fontSize(20).center,
                "Get started writing your first flashcard here.".text.fontSize(16).center,
                "👇".text.fontSize(100).center,
              ],
            ),
          );
        }

        return ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              height: 5,
            );
          },
          itemCount: database.flashContentList.length,
          itemBuilder: (context, index) {
            return FlashCard(
              flashContent: database.flashContentList[index],
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const InputPrompt(),
      ),
    );
  }
}
