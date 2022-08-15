part of word_collector;

class _TopPanel extends StatelessWidget {
  const _TopPanel({
    Key? key,
    required this.width,
    required this.height,
    required this.parentKey,
    required this.controller,
    required this.wordCollectorStyle,
  }) : super(key: key);
  final double width;
  final double height;
  final WordCollectorController controller;
  final WordCollectorStyle wordCollectorStyle;
  final GlobalKey parentKey;
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
        controller._setTopPanelPos(childRelativeToParent);
      }
    });

    return Container(
      decoration: BoxDecoration(
        color: wordCollectorStyle.showBackgroundTopPanel
            ? wordCollectorStyle.colorBackgroundTopPanel
            : Colors.transparent,
        borderRadius:
            BorderRadius.circular(wordCollectorStyle.topPanelBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          key: globalKey,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
