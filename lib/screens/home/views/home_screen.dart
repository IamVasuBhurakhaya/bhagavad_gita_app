import 'dart:ui';
import 'package:bhagavad_gita_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bhagavad_gita_app/provider/json_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<int, String> appBarTitles = {
    0: 'श्रीमद भगवद्‍ गीता',
    1: 'श्रीमद् भगवद्गीता',
    2: 'Srimad Bhagavad Gita',
    3: 'શ્રીમદ્ ભગવદ ગીતા',
  };

  @override
  void initState() {
    context.read<JsonProvider>().getChapterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerR = context.read<JsonProvider>();
    final providerW = context.watch<JsonProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/appBar.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                appBarTitles[providerW.languageIndex] ?? '',
                style: const TextStyle(
                  fontSize: 36,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 85,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: DropdownButton<int>(
                  value: providerW.languageIndex,
                  dropdownColor: Colors.black87.withOpacity(0.6),
                  icon: const Icon(Icons.language, color: Colors.white),
                  underline: Container(color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "Sanskrit",
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Hindi"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("English"),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text("Gujarati"),
                    ),
                  ],
                  onChanged: (value) {
                    providerR.setLanguageIndex(value!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/cover2.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          ListView.builder(
            itemCount: providerW.chapterList.length,
            itemBuilder: (context, index) {
              final chapter = providerW.chapterList[index];

              final chapterName = providerW.languageIndex == 0
                  ? chapter.nameModel!.sanskrit
                  : providerW.languageIndex == 1
                      ? chapter.nameModel!.hindi
                      : providerW.languageIndex == 2
                          ? chapter.nameModel!.english
                          : chapter.nameModel!.gujarati;

              final chapterSubtitle = providerW.languageIndex == 0
                  ? chapter.chapterNumberModel!.sanskrit
                  : providerW.languageIndex == 1
                      ? chapter.chapterNumberModel!.hindi
                      : providerW.languageIndex == 2
                          ? chapter.chapterNumberModel!.english
                          : chapter.chapterNumberModel!.gujarati;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade100,
                          Colors.yellow.shade200,
                          Colors.deepOrange.shade100
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        providerR
                            .chapterWiseVerse(providerW.chapterList[index].id!);
                        Navigator.pushNamed(context, AppRoutes.verses,
                            arguments: providerW.chapterList[index]);
                      },
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.redAccent, Colors.yellowAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            chapter.id.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        chapterName ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(Icons.menu_book,
                              color: Colors.deepOrange, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            chapterSubtitle ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
