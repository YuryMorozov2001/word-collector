import 'package:flutter/material.dart';

///WorldCollector() widget styling class
class WordCollectorStyle {
  WordCollectorStyle({
    this.showBackgroundTopPanel = true,
    this.distanceBetweenPanels = 25.0,
    this.itemBorderRadius = 14.0,
    this.topPanelBorderRadius = 14.0,
    this.paddingBetweenWidgets = 8.0,
    this.paddingText = 8.0,
    this.colorBackgroundTopPanel = const Color(0xFFE0E0E0),
    this.colorBackItem = const Color(0xFFE0E0E0),
    this.colorFrontItem = const Color(0xFF607D8B),
    this.wordDuration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
    this.textStyle = const TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
  });
  final double itemBorderRadius;
  final double topPanelBorderRadius;
  final bool showBackgroundTopPanel;
  final Color colorBackgroundTopPanel;
  final double distanceBetweenPanels;
  final Color colorFrontItem;
  final Color colorBackItem;
  final double paddingBetweenWidgets;
  final double paddingText;
  final Duration wordDuration;
  final Curve curve;
  final TextStyle textStyle;
}
