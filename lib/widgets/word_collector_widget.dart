part of word_collector;

class WordCollector extends GetMaterialApp {
  const WordCollector({
    Key? key,
    required this.controller,
    required this.wordCollectorStyle,
    required this.pageIndex,
    required this.words,
    required this.topPanelWidth,
    required this.bottomPanelWidth,
  }) : super(key: key);
  final WordCollectorController controller;
  final WordCollectorStyle wordCollectorStyle;
  final int pageIndex;
  final double topPanelWidth;
  final double bottomPanelWidth;
  final List<String> words;
  @override
  Widget build(BuildContext context) {
    // отключили логгер от get
    Get.config(
      enableLog: false,
    );

    return _WordCollectorWidget(
      controller: controller,
      pageIndex: pageIndex,
      words: words,
      wordCollectorStyle: wordCollectorStyle,
      bottomPanelWidth: bottomPanelWidth,
      topPanelWidth: topPanelWidth,
    );
  }
}

class _WordCollectorWidget extends StatefulWidget {
  const _WordCollectorWidget(
      {Key? key,
      required this.controller,
      required this.pageIndex,
      required this.wordCollectorStyle,
      required this.topPanelWidth,
      required this.bottomPanelWidth,
      required this.words})
      : super(key: key);
  final WordCollectorController controller;
  final int pageIndex;
  final List<String> words;
  final double topPanelWidth;
  final double bottomPanelWidth;
  final WordCollectorStyle wordCollectorStyle;
  @override
  State<_WordCollectorWidget> createState() => _WordCollectorWidgetState();
}

class _WordCollectorWidgetState extends State<_WordCollectorWidget> {
  List<Widget> fakeItems = [];
  @override
  void initState() {
    setState(() {
      fakeItems = _generateFakeWidgets(
          widthTopPanel: widget.topPanelWidth,
          controller: widget.controller,
          words: widget.words,
          pageIndex: widget.pageIndex,
          wordCollectorStyle: widget.wordCollectorStyle);
    });
    WidgetsBinding.instance.addPostFrameCallback((dur) async {
      setState(() {
        fakeItems = [];
      });
    });
    super.initState();
  }

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        key: globalKey,
        child: GetX<WordCollectorController>(
          init: widget.controller,
          builder: (controller) => Stack(
            children: [
              ...fakeItems,
              Column(
                children: [
                  _TopPanel(
                    width: widget.topPanelWidth,
                    height: controller._heightTopPanel[widget.pageIndex] ?? 0.0,
                    parentKey: globalKey,
                    controller: controller,
                    wordCollectorStyle: widget.wordCollectorStyle,
                  ),
                  SizedBox(
                    height: widget.wordCollectorStyle.distanceBetweenPanels,
                  ),
                  _BottomPanel(
                      width: widget.bottomPanelWidth,
                      controller: controller,
                      words: widget.words,
                      parentKey: globalKey,
                      pageIndex: widget.pageIndex,
                      wordCollectorStyle: widget.wordCollectorStyle),
                ],
              ),
              if (controller._backPositions[widget.pageIndex]?.length ==
                  widget.words.length)
                ..._generateFrontWidgets(
                    controller: controller,
                    words: widget.words,
                    pageIndex: widget.pageIndex,
                    wordCollectorStyle: widget.wordCollectorStyle),
            ],
          ),
        ),
      ),
    );
  }
}
