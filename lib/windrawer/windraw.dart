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

  WindowsTest testwin;
  PWindow activeWindow;
  List<PWindow> windows = [];
  double windowsWidth = 0;
  double windowsHeight = 0;
  Size imageSize = Size(0, 0);
  Size outputSize = Size(0, 0);
  FittedSizes fitsize;
  double ratio;
  Offset center;
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
        this.windowsWidth = [this.windowsWidth, win.width].reduce(max);
        this.windowsHeight = this.windowsHeight + win.height;
      } else if (win.addtype == "vertical") {
        startX = this.windowsWidth;
        this.windowsWidth = this.windowsWidth + win.width;
        this.windowsHeight = [this.windowsHeight, win.height].reduce(max);
      } else {
        this.windowsWidth = win.width;
        this.windowsHeight = win.height;
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

  void testwindata() {
    if (this.testwin == null) {
      this.testwin = new WindowsTest();
      this.testwin.testMakeWin();
      //this.windows.add(this.testwin.firstWin);
      //this.testwin.testMakeWin2();
      //this.windows.add(this.testwin.secondWin);
      //this.testwin.testMakeWin3();
      //this.windows.add(this.testwin.thirdWin);
      //this.activeWindow = this.testwin.firstWin;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'windows': windows?.map((x) => x?.toMap())?.toList(),
      'windowsWidth': windowsWidth,
      'windowsHeight': windowsHeight,
    };
  }

  fromMap(Map<String, dynamic> map) {
    if (map == null) return;

    windows =
        List<PWindow>.from(map['windows']?.map((x) => PWindow.fromMap(x)));
    windowsWidth = map['windowsWidth'];
    windowsHeight = map['windowsHeight'];
  }

  String toJson() => json.encode(toMap());

  fromJson(String source) => fromMap(json.decode(source));
}
