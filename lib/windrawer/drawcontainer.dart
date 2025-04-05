import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:windesign/winentity/windowobject.dart';
import 'package:windesign/winentity/windows_test.dart';

class DrawContainer {
  static final DrawContainer _singleton = DrawContainer._internal();

  factory DrawContainer() {
    return _singleton;
  }

  DrawContainer._internal();

  WindowsTest? testwin; // Made nullable
  WindowObject? activeWindow; // Made nullable
  List<WindowObject> windows = [];
  double windowsWidth = 0;
  double windowsHeight = 0;
  Size imageSize = const Size(0, 0); // Use const for default values
  Size outputSize = const Size(0, 0); // Use const for default values
  FittedSizes? fitsize; // Made nullable
  double ratio = 0; // Added default value
  Offset center = Offset.zero; // Use Offset.zero for default value
  double spaceWidth = 200;
  double spaceHeight = 200;

  void calculateWinSizes(Size screenSize) {
    windowsWidth = 0;
    windowsHeight = 0;
    double startX = 0;
    double startY = 0;

    for (final win in windows) {
      if (win.addtype == "horizontal") {
        startY = windowsHeight;
        windowsWidth = max(windowsWidth, win.width);
        windowsHeight += win.height;
      } else if (win.addtype == "vertical") {
        startX = windowsWidth;
        windowsWidth += win.width;
        windowsHeight = max(windowsHeight, win.height);
      } else {
        windowsWidth = win.width;
        windowsHeight = win.height;
      }
      win.start = Offset(startX, startY);
    }

    imageSize = Size(windowsWidth, windowsHeight);
    outputSize =
        Size(screenSize.width - spaceWidth, screenSize.height - spaceHeight);
    fitsize = applyBoxFit(BoxFit.scaleDown, imageSize, outputSize);
    ratio = fitsize!.destination.width /
        fitsize!.source.width; // Handle null fitsize
    center = Offset((screenSize.width - (fitsize?.destination.width ?? 0)) / 2,
        (screenSize.height - (fitsize?.destination.height ?? 0)) / 2);
  }

  void testwindata() {}

  Map<String, dynamic> toMap() {
    return {
      'windows': windows.map((x) => x.toMap()).toList(),
      'windowsWidth': windowsWidth,
      'windowsHeight': windowsHeight,
    };
  }

  void fromMap(Map<String, dynamic> map) {
    windows = List<WindowObject>.from(
        map['windows']?.map((x) => WindowObject.fromMap(x)) ??
            []); // Handle null windows
    windowsWidth =
        map['windowsWidth'] as double? ?? 0; // Handle null windowsWidth
    windowsHeight =
        map['windowsHeight'] as double? ?? 0; // Handle null windowsHeight
  }

  String toJson() => json.encode(toMap());

  void fromJson(String source) => fromMap(
      json.decode(source) as Map<String, dynamic>); // Handle json.decode result
}
