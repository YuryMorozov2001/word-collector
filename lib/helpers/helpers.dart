part of word_collector;

List<Widget> _generateBackWidgets(
    {words,
    parentKey,
    maxWidth,
    required WordCollectorController controller,
    required WordCollectorStyle wordCollectorStyle,
    required pageIndex}) {
  List<Widget> backWidgets = [];
  List<Widget> tempWidets = <Widget>[];

  var lengthRow = 0.0;
  for (var i = 0; i < words.length; i++) {
    Widget currentWidget = _BackItem(
        pageIndex: pageIndex,
        controller: controller,
        word: words[i],
        wordCollectorStyle: wordCollectorStyle,
        parentKey: parentKey,
        id: i);
    lengthRow = lengthRow +
        controller._widthItems[pageIndex]![i]! +
        wordCollectorStyle.paddingBetweenWidgets * 2;
    if (i <= words.length - 2) {
      if (lengthRow < maxWidth) {
        tempWidets.add(currentWidget);
      } else {
        backWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: tempWidets.toList(),
        ));
        tempWidets.clear();
        tempWidets.add(currentWidget);
        lengthRow = controller._widthItems[pageIndex]![i]! +
            wordCollectorStyle.paddingBetweenWidgets * 2;
      }
    } else {
      if (lengthRow < maxWidth) {
        tempWidets.add(currentWidget);
        backWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: tempWidets.toList(),
        ));
        tempWidets.clear();
        lengthRow = 0.0;
      } else {
        backWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: tempWidets.toList(),
        ));
        tempWidets.clear();
        tempWidets.add(currentWidget);
        backWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: tempWidets.toList(),
        ));
        tempWidets.clear();
      }
    }
  }
  return backWidgets;
}

List<Widget> _generateFakeWidgets({
  words,
  controller,
  pageIndex,
  widthTopPanel,
  required WordCollectorStyle wordCollectorStyle,
}) {
  List<Widget> tempWidgets = [];
  for (var i = 0; i < words.length; i++) {
    tempWidgets.add(_FakeItem(
      widthTopPanel: widthTopPanel,
      word: words[i],
      controller: controller,
      wordCollectorStyle: wordCollectorStyle,
      pageIndex: pageIndex,
      index: i,
    ));
  }
  return tempWidgets;
}

List<Widget> _generateFrontWidgets(
    {required WordCollectorController controller,
    required WordCollectorStyle wordCollectorStyle,
    required List words,
    required int pageIndex}) {
  List<Widget> frontWidgets = <Widget>[];
  if (controller._backPositions[pageIndex]!.length == words.length) {
    for (int i = 0; i < words.length; i++) {
      frontWidgets.add(_FrontItem(
        word: words[i],
        controller: controller,
        wordCollectorStyle: wordCollectorStyle,
        id: i,
        pageIndex: pageIndex,
      ));
    }
  }
  return frontWidgets;
}
