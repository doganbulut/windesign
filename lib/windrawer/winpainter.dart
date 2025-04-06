import 'package:flutter/material.dart';
import 'package:windesign/winentity/window.dart';
import 'windraw.dart';
import 'windrawhelper.dart';

class WinPainter extends CustomPainter {
  BuildContext context;
  Size? iCanvasSize;
  PWindow? pWindow;
  List<PWindow> pWindows;

  WinPainter(this.context) : pWindows = [];

  @override
  void paint(Canvas canvas, Size size) {
    iCanvasSize = size;
    pWindows = WindowLayoutManager().windowList;
    pWindow = WindowLayoutManager().activeWindow;
    WindowLayoutManager().calculateWinSizes(iCanvasSize!);

    for (var win in pWindows) {
      WindowDrawingHelper winHelper = drawWindow(
          canvas,
          win,
          WindowLayoutManager().scaleRatio,
          WindowLayoutManager().drawingCenter);
      if (winHelper.window != null) {
        winHelper.drawBasicWindow();
        //for (var cell in winHelper.window!.cells) {
        //  winHelper.drawMullion(cell);
        //}
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  WindowDrawingHelper drawWindow(
      Canvas canvas, PWindow pWindow, double ratio, Offset center) {
    try {
      WindowDrawingHelper winHelper =
          WindowDrawingHelper(iCanvasSize!, canvas, ratio, center);
      winHelper.window = pWindow;
      return winHelper;
    } catch (e) {
      print('Error: ' + e.toString());
      throw e;
    }
  }
}
