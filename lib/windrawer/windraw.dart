import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:windesign/winentity/window.dart';
import 'package:windesign/winentity/windows_test.dart';

enum WindowAddType {
  horizontal,
  vertical,
  single,
}

class WindowLayoutManager {
  static final WindowLayoutManager _singleton = WindowLayoutManager._internal();

  factory WindowLayoutManager() {
    return _singleton;
  }

  WindowLayoutManager._internal();

  WindowsTest? windowTestData;
  PWindow? activeWindow;
  List<PWindow> windowList = [];
  double totalWindowsWidth = 0;
  double totalWindowsHeight = 0;
  Size imageSize = Size(0, 0);
  Size outputSize = Size(0, 0);
  FittedSizes? fittedSizes;
  double scaleRatio = 0;
  Offset drawingCenter = Offset(0, 0);
  double paddingWidth = 200;
  double paddingHeight = 200;

  void calculateWinSizes(Size screenSize) {
    totalWindowsWidth = 0;
    totalWindowsHeight = 0;
    double startX = 0;
    double startY = 0;

    for (var win in windowList) {
      if (win.addtype == "horizontal") {
        startY = totalWindowsHeight;
        totalWindowsWidth = max(totalWindowsWidth, win.width);
        totalWindowsHeight += win.height;
      } else if (win.addtype == "vertical") {
        startX = totalWindowsWidth;
        totalWindowsWidth += win.width;
        totalWindowsHeight = max(totalWindowsHeight, win.height);
      } else {
        totalWindowsWidth = win.width;
        totalWindowsHeight = win.height;
      }
      win.start = Offset(startX, startY);
    }

    imageSize = Size(totalWindowsWidth, totalWindowsHeight);
    outputSize = Size(
        screenSize.width - paddingWidth, screenSize.height - paddingHeight);
    fittedSizes = applyBoxFit(BoxFit.scaleDown, imageSize, outputSize);
    scaleRatio = fittedSizes!.destination.width / fittedSizes!.source.width;
    drawingCenter = Offset(
        (screenSize.width - (fittedSizes!.destination.width)) / 2,
        (screenSize.height - fittedSizes!.destination.height) / 2);
  }

  void initializeTestWindows() {
    windowTestData = WindowsTest();
    windowTestData!.testMakeWin();
    //windowList.add(windowTestData!.firstWin);
    //windowTestData!.testMakeWin2();
    //windowList.add(windowTestData!.secondWin);
    //windowTestData!.testMakeWin3();
    //windowList.add(windowTestData!.thirdWin);
    //activeWindow = windowTestData!.firstWin;
  }

  Map<String, dynamic> toMap() {
    return {
      'windows': windowList.map((x) => x.toMap()).toList(),
      'windowsWidth': totalWindowsWidth,
      'windowsHeight': totalWindowsHeight,
    };
  }

  void fromMap(Map<String, dynamic>? map) {
    if (map == null) return;

    try {
      windowList = List<PWindow>.from(
          map['windows']?.map((x) => PWindow.fromMap(x)) ?? []);
      totalWindowsWidth = map['windowsWidth'] ?? 0;
      totalWindowsHeight = map['windowsHeight'] ?? 0;
    } catch (e) {
      print('Error in fromMap: $e');
    }
  }

  String toJson() => json.encode(toMap());

  void fromJson(String source) => fromMap(json.decode(source));
}
