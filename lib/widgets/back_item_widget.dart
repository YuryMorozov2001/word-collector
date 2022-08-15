part of word_collector;

class _BackItem extends StatelessWidget {
  const _BackItem(
      {Key? key,
      required this.word,
      required this.controller,
      required this.parentKey,
      required this.pageIndex,
      required this.wordCollectorStyle,
      required this.id})
      : super(key: key);
  final WordCollectorController controller;
  final WordCollectorStyle wordCollectorStyle;
  final GlobalKey parentKey;
  final String word;
  final int id;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((dur) async {
      if (globalKey.currentContext != null) {
        RenderBox box =
            globalKey.currentContext!.findRenderObject() as RenderBox;
        Offset childOffset = box.localToGlobal(Offset.zero);
        RenderBox parent =
            parentKey.currentContext!.findRenderObject() as RenderBox;
        Offset childRelativeToParent = parent.globalToLocal(childOffset);
        await controller._addBackPosition(
            id: id,
            offset: Offset(childRelativeToParent.dx, childRelativeToParent.dy),
            pageIndex: pageIndex);
        await controller._generateMoveState(pageIndex);
      }
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(wordCollectorStyle.paddingBetweenWidgets),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(wordCollectorStyle.itemBorderRadius),
                  color: wordCollectorStyle.colorBackItem,
                ),
                key: globalKey,
                child: Padding(
                  padding: EdgeInsets.all(wordCollectorStyle.paddingText),
                  child: Text(
                    word,
                    style: wordCollectorStyle.textStyle
                        .apply(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
