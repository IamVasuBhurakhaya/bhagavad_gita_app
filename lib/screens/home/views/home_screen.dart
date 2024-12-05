import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bhagavad_gita_app/provider/json_provider.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "श्रीमद भगवत गीता",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              // Add functionality for grid view here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: providerW.chapterList.length,
        itemBuilder: (context, index) {
          final chapter = providerW.chapterList[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              onTap: () {
                // Handle onTap navigation to chapter details
              },
              leading: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Text(
                  chapter.id.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                "${providerW.chapterList[index].nameModel!.sanskrit}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text("${providerW.chapterList[index].nameModel!.hindi}"),
            ),
          );
        },
      ),
    );
  }
}
