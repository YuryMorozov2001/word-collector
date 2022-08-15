# word_collector

This package adds an easy to use and beautiful word collector widget 
<img src="https://github.com/YuryMorozov2001/word-collector/raw/main/.gitHub/images/word_collector_preview.gif" alt="preview">  

## Getting started

### Add dependency 

```yaml
dependencies:
  word_collector: ^
```

## Usage 

### Step 1:
Prepare a `Map<int, List<String>>` with the words:

```dart
final words = <int, List<String>>{
      0: ['We', 'go', 'jogging', 'every', 'Sunday'],
      1: ['They', 'did', 'not', 'go', 'to', 'school', 'last', 'year'],
      2: ['George', 'has', 'not', 'finished', 'his', 'work', 'yet'],
      3: ['We', 'did', 'not', 'meet', 'anyone', 'yesterday'],
    }; 
```

### Step 2:

Create a `WordCollectorController()`:

```dart
final wordCController = WordCollectorController();
```

### Step 3:

Create a `PageView`:

```dart
PageView.builder(
    ...,
    itemBuilder: (context, i) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                WordCollector(
                controller: wordCController,
                pageIndex: i,
                words: words[i]!,
                bottomPanelWidth: width,
                topPanelWidth: width,
                wordCollectorStyle: WordCollectorStyle(),
                ),
            ],...
```
Result:

<img src="https://github.com/YuryMorozov2001/word-collector/raw/main/.gitHub/images/word_collector_orig_preview.gif" alt="orig_preview">    

## Stylization

After creating `WordCollector()` we can assign styles via `WordCollectorStyle()`: 

```dart
WordCollector(
    ...,
    wordCollectorStyle: WordCollectorStyle(
        itemBorderRadius: 22,
        paddingText: 12,
        topPanelBorderRadius: 22,
        colorFrontItem: const Color(0xFFE8D5EA),
        colorBackgroundTopPanel: const Color(0xFFCA74DA),
        colorBackItem: const Color(0xFFC8E6C9),
        textStyle: const TextStyle(
            color: Color(0xFF1C2AC4),
            fontSize: 18,
        ), 
    ),
),
```
Result:

<img src="https://github.com/YuryMorozov2001/word-collector/raw/main/.gitHub/images/word_collector_style_preview.gif" alt="style_preview"> 

## Get the result of words

To get the result, you can use the `.getResult()` method, which returns `<int, Map<int, String>>`\
Examples:

```dart
textResult = wordCController.getResult().toString();
// textResult = '{0: {0: 'We', ...}, 1: ...}'
```

We can also set the index of the page:

```dart
textResult = wordCController.getResult(pageIndex: i).toString();
// textResult = '{0: 'We', 1: 'go', ...}'
```

## Future updates
- ability to listen to words
- custom styles for certain words
  
## Contact
[github: yurymorozov](https://github.com/YuryMorozov2001)
