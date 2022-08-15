part of word_collector;

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    Key? key,
    required this.width,
    required this.controller,
    required this.parentKey,
    required this.words,
    required this.pageIndex,
    required this.wordCollectorStyle,
  }) : super(key: key);
  final double width;
  final int pageIndex;
  final WordCollectorController controller;
  final GlobalKey parentKey;
  final List<String> words;
  final WordCollectorStyle wordCollectorStyle;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (controller._widthItems[pageIndex] != null) {
      var generatedBackItems = _generateBackWidgets(
        controller: controller,
        maxWidth: width,
        parentKey: parentKey,
        words: words,
        wordCollectorStyle: wordCollectorStyle,
        pageIndex: pageIndex,
      );
      items = generatedBackItems;
    }
    return SizedBox(
      width: width,
      child: Column(children: items),
    );
  }
}
