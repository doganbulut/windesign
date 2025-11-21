import 'package:flutter/material.dart';
import 'package:windesign/winentity/window.dart';
import 'windraw.dart';
import 'windrawhelper.dart';

class WinPainter extends CustomPainter {
  late BuildContext context;
  late Size iCanvasSize;
  late PWindow pWindow;
  late List<PWindow> pWindows;

  WinPainter(BuildContext context) {
    this.context = context;
  }

  @override
  void paint(Canvas canvas, Size size) {
    iCanvasSize = size;
    //print('Size: ' + size.toString());
    this.pWindows = WinDraw().windows;
    this.pWindow = WinDraw().activeWindow;
    WinDraw().calculateWinSizes(iCanvasSize);

    for (var win in this.pWindows) {
      WinDrawHelper? winHelper =
          drawWindow(canvas, win, WinDraw().ratio, WinDraw().center);
      if (winHelper != null) {
        winHelper.drawSimpleCase();
        winHelper.drawFrameMullion(win.frame);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  WinDrawHelper? drawWindow(
      Canvas pcanvas, PWindow pWindow, double ratio, Offset center) {
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
