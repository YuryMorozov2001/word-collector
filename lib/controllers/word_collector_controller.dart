part of word_collector;

///Class designed to get the `resultWord` and to perform internal necessary operations
class WordCollectorController extends GetxController {
  ///List with words to receive
  var resultWord = <int, Map<int, String>>{};

  ///Height of widget with the word
  double _heightItem = 0.0;

  ///Width of widgets with words in different pages
  final _widthItems = <int, Map<int, double>>{};

  ///Widget `BackItem()` positions in different pages
  final _backPositions = <int, Map<int, Offset>>{}.obs;

  ///`TopPanel()` height list in different pages
  final _heightTopPanel = <int, double>{};

  ///`TopPanel()` width
  double _widthTopPanel = 0.0;

  ///List of movement states in different pages
  final _moveState = <int, List<RxBool>>{};

  ///Position of the `TopPanel()` for generating coordinates for movement `FrontItem()`
  var _posTopPanel = const Offset(0, 0);

  ///List of current `FrontItem()` positions in different pages
  final _currentFrontItemPos = <int, Map<int, Offset>>{}.obs;

  ///Sum of width widgets for calculating the coordinates for movement in different pages
  final _widthSum = <int, double>{};

  ///Counter lines when calculating coordinates for movement in different pages
  final _lineCounter = <int, int>{};

  ///Returns `Map` with collected words from all pages.
  ///
  ///When the page index is assigned, the `Map` of the assigned page will be returned.
  getResult({int? pageIndex}) {
    if (pageIndex == null) {
      return resultWord;
    }
    if (resultWord[pageIndex] == null) {
      resultWord[pageIndex] = {};
    }

    return resultWord[pageIndex];
  }

  ///Adding  a word from `TopPanel()` to the `resultWord` list
  ///or delete the word from the list if the word is no longer in `TopPanel()`
  _addWordInResult(
      {required int pageIndex,
      required String word,
      required bool isAdd,
      required int id}) {
    if (resultWord[pageIndex] == null) {
      resultWord[pageIndex] = <int, String>{};
    }
    if (isAdd) {
      resultWord[pageIndex]![id] = word;
    } else {
      resultWord[pageIndex]!.remove(id);
    }
  }

  ///Setting `height` of word widget
  ///
  ///`Height` is set only once cuz height of words is same
  _setHeightItem(double height) {
    _heightItem = height;
  }

  ///Setting `width` of word widget
  _setWidthItem(
      {required int pageIndex, required double width, required int id}) {
    if (_widthItems[pageIndex] == null) {
      _widthItems[pageIndex] = <int, double>{};
    }
    _widthItems[pageIndex]![id] = width;
  }

  ///Setting position of `BackItem()` to generate `FrontItem`
  _addBackPosition(
      {required int pageIndex, required int id, required Offset offset}) {
    if (_backPositions[pageIndex] == null) {
      _backPositions[pageIndex] = <int, Offset>{};
    }
    _backPositions[pageIndex]![id] = offset;
  }

  ///Setting `width` of `BackItem()` to generate `FrontItem()`
  _setWidthTopPanel({required double width}) {
    _widthTopPanel = width;
  }

  ///Setting `width` for next generation of `height` of `TopPanel()`
  ///
  ///Sometimes it generates incorrectly with a small `TopPanel()` width
  ///and a large `FrontItem()` width, i will be glad of any help:)
  _setHeightTopPanel({required int pageIndex, required double padding}) {
    if (_heightTopPanel[pageIndex] == null) {
      _heightTopPanel[pageIndex] = 0.0;
    }
    double sumWords = 0.0;
    int lines = 1;
    _widthItems[pageIndex]!.values.toList()
      ..sort((a, b) => b.compareTo(a))
      ..forEach((element) {
        if (((sumWords + element + 8) / _widthTopPanel).ceil() != 2) {
          sumWords += element + 8;
        } else {
          lines++;
          sumWords = element + 8;
        }
      });
    _heightTopPanel[pageIndex] =
        _heightItem * lines + (lines > 1 ? (lines - 1) * 8 : 0);
  }

  ///When generating `FakeItem()`, the bool state of position is indicated
  ///
  ///If value is false, `FrontItem()` widget is in `BottomPanel()`,
  ///and if the value is true, the widget will be located in the `TopPanel()`
  _generateMoveState(int pageIndex) {
    if (_moveState[pageIndex] == null) {
      _moveState[pageIndex] = _moveState[pageIndex] = [];
    }
    _moveState[pageIndex]!.add(false.obs);
  }

  ///Changes move state of position thus makes the `FrontItem()` move
  _move({required int pageIndex, required int id}) {
    _calculateCoordinates(
        id: id,
        pageIndex: pageIndex,
        isMove: !_moveState[pageIndex]![id].value);
    _moveState[pageIndex]![id].toggle();
  }

  ///Setting position of TopPanel for next generation
  ///of coordinates for movement of `FrontItem()`
  _setTopPanelPos(offset) {
    _posTopPanel = offset;
  }

  ///Calculating coordinates, when the value isMove == true, the Front Item widget moves to `TopPanel`,
  ///and when the value isMove == false, `FontItem()` returns back to its because of the `move()` function
  ///and rebuilds other FrontItem widgets located in `TopPanel()`
  _calculateCoordinates(
      {required int id, required int pageIndex, required bool isMove}) {
    final dx = _posTopPanel.dx;
    final dy = _posTopPanel.dy;
    if (_currentFrontItemPos[pageIndex] == null) {
      _currentFrontItemPos[pageIndex] = <int, Offset>{}.obs;
    }
    if (_widthSum[pageIndex] == null) {
      _widthSum[pageIndex] = 0.0;
    }
    if (_lineCounter[pageIndex] == null) {
      _lineCounter[pageIndex] = 0;
    }
    if (isMove) {
      var isNewLine =
          ((_widthSum[pageIndex]! + (_widthItems[pageIndex]![id]! + 8)) /
                  _widthTopPanel)
              .ceil();
      if (isNewLine == 2) {
        _widthSum[pageIndex] = 0;
        _lineCounter[pageIndex] = _lineCounter[pageIndex]! + 1;
      }
      _currentFrontItemPos[pageIndex]![id] = Offset(dx + _widthSum[pageIndex]!,
          (dy) + ((_heightItem + 8) * _lineCounter[pageIndex]!));
      _widthSum[pageIndex] =
          _widthSum[pageIndex]! + (_widthItems[pageIndex]![id]! + 8);
    } else {
      _currentFrontItemPos[pageIndex]!.removeWhere((key, value) => key == id);
      _widthSum[pageIndex] = 0.0;
      _lineCounter[pageIndex] = 0;
      for (var element in _currentFrontItemPos[pageIndex]!.entries) {
        var isNewLine = ((_widthSum[pageIndex]! +
                    (_widthItems[pageIndex]![element.key]! + 8)) /
                _widthTopPanel)
            .ceil();
        if (isNewLine == 2) {
          _widthSum[pageIndex] = 0;
          _lineCounter[pageIndex] = _lineCounter[pageIndex]! + 1;
        }
        _currentFrontItemPos[pageIndex]![element.key] = Offset(
            dx + _widthSum[pageIndex]!,
            (dy) + ((_heightItem + 8) * _lineCounter[pageIndex]!));
        _widthSum[pageIndex] =
            _widthSum[pageIndex]! + (_widthItems[pageIndex]![element.key]! + 8);
      }
    }
  }
}
