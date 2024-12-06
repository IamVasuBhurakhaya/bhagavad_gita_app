import 'package:bhagavad_gita_app/model/json_model/chapter_model.dart';
import 'package:bhagavad_gita_app/provider/json_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VersesScreen extends StatefulWidget {
  const VersesScreen({super.key});

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late JsonProvider providerR;
  late JsonProvider providerW;

  @override
  void initState() {
    context.read<JsonProvider>().getVersesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<JsonProvider>();
    providerW = context.watch<JsonProvider>();
    ChapterModel model =
        ModalRoute.of(context)!.settings.arguments as ChapterModel;

    return Scaffold(
        body: ListView.builder(
      itemCount: providerW.versesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text("${providerW.chapterWiseVersesList[index].id}"),
        );
      },
    ));
  }
}
