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
  late JsonProvider providerR;
  late JsonProvider providerW;

  // Language state
  String selectedLanguage = 'sanskrit'; // Default language

  final Map<String, String> appBarTitles = {
    'sanskrit': 'श्रीमद भगवद्‍  गीता',
    'hindi': 'श्रीमद् भगवद्गीता',
    'english': 'Srimad Bhagavad Gita',
    'gujarati': 'શ્રીમદ્ ભગવદ ગીતા',
  };

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Stack(
          children: [
            // Background Image in AppBar
            Positioned.fill(
              child: Image.asset(
                'assets/image/appBar.jpg', // Replace with your AppBar background image path
                fit: BoxFit.cover,
              ),
            ),
            // Semi-transparent Overlay for Maroon Shade
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
            // Centered Title
            Center(
              child: Text(
                appBarTitles[selectedLanguage] ?? '',
                style: const TextStyle(
                  fontSize: 36,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            // Dropdown in Top-Right Corner
            Positioned(
              top: 85,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  dropdownColor: Colors.black87.withOpacity(0.6),
                  icon: const Icon(Icons.language, color: Colors.white),
                  underline: Container(),
                  style: const TextStyle(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  items: const [
                    DropdownMenuItem(
                      value: 'sanskrit',
                      child: Text('संस्कृत'),
                    ),
                    DropdownMenuItem(
                      value: 'hindi',
                      child: Text('हिन्दी'),
                    ),
                    DropdownMenuItem(
                      value: 'english',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'gujarati',
                      child: Text('ગુજરાતી'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image with Blur Effect
          Positioned.fill(
            child: Image.asset(
              'assets/image/cover2.jpg', // Replace with your body background image path
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
          // Foreground Content
          ListView.builder(
            itemCount: providerW.chapterList.length,
            itemBuilder: (context, index) {
              final chapter = providerW.chapterList[index];
              final chapterName = selectedLanguage == 'sanskrit'
                  ? chapter.nameModel!.sanskrit
                  : selectedLanguage == 'hindi'
                      ? chapter.nameModel!.hindi
                      : selectedLanguage == 'english'
                          ? chapter.nameModel!.english
                          : chapter.nameModel!.gujarati; // Gujarati support

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
                          colors: [Colors.pink, Colors.orange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          chapter.id.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      chapterName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "${providerW.chapterList[index].nameModel!.hindi}", // Default subtitle
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
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
