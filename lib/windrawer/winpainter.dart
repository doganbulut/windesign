import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import 'package:windesign/winentity/window.dart';
import 'windraw.dart';
import 'windrawhelper.dart';

class WinPainter extends CustomPainter {
  BuildContext context;
  Size iCanvasSize;
  PWindow pWindow;
  List<PWindow> pWindows;

  WinPainter(BuildContext context) {
    this.context = context;
  }

  @override
  void paint(Canvas canvas, Size size) {
    iCanvasSize = size;
    //print('Size: ' + size.toString());
    var icanvas = TouchyCanvas(this.context, canvas);
    this.pWindows = WinDraw().windows;
    this.pWindow = WinDraw().activeWindow;
    WinDraw().calculateWinSizes(iCanvasSize);

    for (var win in this.pWindows) {
      WinDrawHelper winHelper =
          drawWindow(icanvas, win, WinDraw().ratio, WinDraw().center);
      winHelper.drawSimpleCase();
      winHelper.drawFrameMullion(win.frame);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  WinDrawHelper drawWindow(
      TouchyCanvas pcanvas, PWindow pWindow, double ratio, Offset center) {
    try {
      WinDrawHelper winHelper =
          new WinDrawHelper(this.iCanvasSize, pcanvas, 1, ratio, center);
      winHelper.iWindow = pWindow;
      return winHelper;
    } catch (e) {
      print('Error: ' + e.toString());
      return null;
    }
  }
}
