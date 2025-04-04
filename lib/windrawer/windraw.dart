import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:windesign/winentity/window.dart';
import 'package:windesign/winentity/windows_test.dart';

class WinDraw {
  static final WinDraw _singleton = WinDraw._internal();

  factory WinDraw() {
    return _singleton;
  }

  WinDraw._internal();

  WindowsTest? testwin;
  PWindow? activeWindow;
  List<PWindow> windows = [];
  double windowsWidth = 0;
  double windowsHeight = 0;
  Size imageSize = Size(0, 0);
  Size outputSize = Size(0, 0);
  late FittedSizes fitsize;
  late double ratio;
  late Offset center;
  double spaceWidth = 200;
  double spaceHeight = 200;

  void calculateWinSizes(Size screenSize) {
    this.windowsWidth = 0;
    this.windowsHeight = 0;
    double startX = 0;
    double startY = 0;

    for (var win in windows) {
      if (win.addtype == "horizontal") {
        startY = this.windowsHeight;
        this.windowsWidth = max(this.windowsWidth, win.width!);
        this.windowsHeight += win.height!;
      } else if (win.addtype == "vertical") {
        startX = this.windowsWidth;
        this.windowsWidth += win.width!;
        this.windowsHeight = max(this.windowsHeight, win.height!);
      } else {
        this.windowsWidth = win.width!;
        this.windowsHeight = win.height!;
      }
      win.start = Offset(startX, startY);
    }

    this.imageSize = Size(this.windowsWidth, this.windowsHeight);
    this.outputSize =
        Size(screenSize.width - spaceWidth, screenSize.height - spaceHeight);
    this.fitsize = applyBoxFit(BoxFit.scaleDown, imageSize, outputSize);
    this.ratio = fitsize.destination.width / fitsize.source.width;
    this.center = Offset((screenSize.width - (fitsize.destination.width)) / 2,
        (screenSize.height - fitsize.destination.height) / 2);
  }

  void testwindata() {}

  Map<String, dynamic> toMap() {
    return {
      'windows': windows.map((x) => x.toMap()).toList(),
      'windowsWidth': windowsWidth,
      'windowsHeight': windowsHeight,
    };
  }

  fromMap(Map<String, dynamic> map) {
    windows =
        List<PWindow>.from(map['windows']?.map((x) => PWindow.fromMap(x)));
    windowsWidth = map['windowsWidth'];
    windowsHeight = map['windowsHeight'];
  }

  String toJson() => json.encode(toMap());

  fromJson(String source) => fromMap(json.decode(source));
}
