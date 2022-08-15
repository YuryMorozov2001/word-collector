part of word_collector;

class _FakeItem extends StatelessWidget {
  const _FakeItem(
      {Key? key,
      required this.word,
      required this.controller,
      required this.wordCollectorStyle,
      required this.index,
      required this.widthTopPanel,
      required this.pageIndex})
      : super(key: key);
  final String word;
  final WordCollectorController controller;
  final WordCollectorStyle wordCollectorStyle;
  final int pageIndex;
  final double widthTopPanel;
  final int index;
  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((dur) async {
      if (controller._heightItem <= 0) {
        await controller._setHeightItem(globalKey.currentContext!.size!.height);
      }
      await controller._setWidthItem(
          width: globalKey.currentContext!.size!.width,
          pageIndex: pageIndex,
          id: index);
      await controller._setWidthTopPanel(width: widthTopPanel);
      await controller._setHeightTopPanel(
          pageIndex: pageIndex, padding: wordCollectorStyle.paddingText);
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              key: globalKey,
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(wordCollectorStyle.paddingText),
                child: Text(
                  word,
                  style: wordCollectorStyle.textStyle
                      .apply(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
