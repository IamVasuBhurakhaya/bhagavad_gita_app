import 'package:bhagavad_gita_app/provider/json_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late JsonProvider providerR;
  late JsonProvider providerW;

  @override
  void initState() {
    context.read<JsonProvider>().getChapterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<JsonProvider>();
    providerW = context.watch<JsonProvider>();
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          leading: Text("${providerW.chapterList[index].id}"),
        ),
        itemCount: providerW.chapterList.length,
      ),
    );
  }
}
