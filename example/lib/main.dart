import 'package:flutter/material.dart';
import 'package:word_collector/word_collector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final words = <int, List<String>>{
    0: ['We', 'go', 'jogging', 'every', 'Sunday'],
    1: ['They', 'did', 'not', 'go', 'to', 'school', 'last', 'year'],
    2: ['George', 'has', 'not', 'finished', 'his', 'work', 'yet'],
    3: ['We', 'did', 'not', 'meet', 'anyone', 'yesterday'],
  };
  final wordCController = WordCollectorController();
  final pageController = PageController();
  String textResult = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: words.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WordCollector(
                  controller: wordCController,
                  pageIndex: index,
                  words: words[index]!,
                  topPanelWidth: MediaQuery.of(context).size.width * 0.9,
                  bottomPanelWidth: MediaQuery.of(context).size.width * 0.9,
                  wordCollectorStyle: WordCollectorStyle(
                    itemBorderRadius: 22,
                    paddingText: 12,
                    topPanelBorderRadius: 22,
                    colorFrontItem: const Color(0xFFE8D5EA),
                    colorBackgroundTopPanel: const Color(0xFFCA74DA),
                    colorBackItem: const Color(0xFFC8E6C9),
                    textStyle: const TextStyle(
                      color: Color(0xFF1C2AC4),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        textResult = wordCController
                            .getResult(pageIndex: index)
                            .toString();
                      });
                    },
                    child: const Text('show result')),
                const SizedBox(height: 25),
                Text('resultWord: $textResult')
              ],
            );
          }),
    );
  }
}
