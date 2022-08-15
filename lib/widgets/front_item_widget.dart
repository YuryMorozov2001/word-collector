part of word_collector;

class _FrontItem extends StatelessWidget {
  const _FrontItem(
      {Key? key,
      required this.word,
      required this.controller,
      required this.pageIndex,
      required this.wordCollectorStyle,
      required this.id})
      : super(key: key);
  final int pageIndex;
  final WordCollectorController controller;
  final WordCollectorStyle wordCollectorStyle;
  final String word;
  final int id;
  @override
  Widget build(BuildContext context) {
    return GetX<WordCollectorController>(
        init: controller,
        builder: (c) {
          return AnimatedPositioned(
            curve: wordCollectorStyle.curve,
            duration: wordCollectorStyle.wordDuration,
            left: c._moveState[pageIndex]![id].value
                ? c._currentFrontItemPos[pageIndex]![id]!.dx
                : c._backPositions[pageIndex]![id]!.dx,
            top: c._moveState[pageIndex]![id].value
                ? c._currentFrontItemPos[pageIndex]![id]!.dy
                : c._backPositions[pageIndex]![id]!.dy,
            child: GestureDetector(
              onTap: () {
                c._move(id: id, pageIndex: pageIndex); 
                c._addWordInResult(
                    pageIndex: pageIndex,
                    word: word,
                    isAdd: c._moveState[pageIndex]![id].value,
                    id: id); 
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        wordCollectorStyle.itemBorderRadius),
                    color: wordCollectorStyle.colorFrontItem,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(wordCollectorStyle.paddingText),
                    child: Text(
                      word,
                      style: wordCollectorStyle.textStyle,
                    ),
                  )),
            ),
          );
        });
  }
}
