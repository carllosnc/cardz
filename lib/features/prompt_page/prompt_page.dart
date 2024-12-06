import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import './components/input_prompt.dart';
import './components/flash_card.dart';
import '/imports.dart';
import 'package:localize/localize.dart';

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
  final _scrollController = ScrollController();
  var _showFilter = false;
  FocusNode focus = FocusNode();
  List<FlashContent> flashContentList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await database.getAllFlashContentByLanguage(widget.languageToLearn);

    setState(() {
      flashContentList = database.flashContentList;
    });
  }

  filterWord(String word) {
    setState(() {
      flashContentList = database.flashContentList
          .where(
            (e) => e.word.toLowerCase().contains(word.toLowerCase()),
          )
          .toList();
    });
  }

  sendScrollToEnd() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        database.flashContentList.length * 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget filter() {
    if (_showFilter) {
      return SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) => filterWord(value),
          focusNode: focus,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: true,
            hintText: "filter word or sentence",
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
      );
    }

    return widget.languageToLearn.name.localize.pageTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: filter(),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_showFilter) {
                  _showFilter = false;
                  focus.unfocus();
                } else {
                  _showFilter = true;
                  focus.requestFocus();
                }
              });
            },
            icon: Icon(
              _showFilter ? Icons.close : Icons.search,
            ),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (database.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (flashContentList.isEmpty) {
          return SizedBox(
            width: double.infinity,
            child: VWColumn(
              gap: 10,
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              horizontalAlignment: CrossAxisAlignment.center,
              verticalAlignment: MainAxisAlignment.center,
              children: [
                "no flashcard created yet.".localize.text.fontSize(20).center.bold,
                "get started writing your first flashcard here.".localize.text.fontSize(16).center,
                "👇".text.fontSize(100).center,
              ],
            ),
          );
        }

        return ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) {
            return Divider(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              height: 5,
            );
          },
          itemCount: flashContentList.length,
          itemBuilder: (context, index) {
            return FlashCard(
              onDelete: () async {
                await getData();
              },
              flashContent: flashContentList[index],
              languageToLearn: widget.languageToLearn,
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: InputPrompt(
          onAdd: () async {
            await getData();
            sendScrollToEnd();
          },
          languageToLearn: widget.languageToLearn,
        ),
      ),
    );
  }
}
