import 'package:flutter/material.dart';
import 'package:windesign/windrawer/drawcontainer.dart';
import 'package:windesign/winentity/windowobject.dart';
import 'drawhelper.dart';

class WinPainter extends CustomPainter {
  late BuildContext context;
  late Size canvasSize;
  late WindowObject activeWindow;
  late List<WindowObject> windowList;

  WinPainter(BuildContext context) {
    this.context = context;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvasSize = size;
    //print('Size: ' + size.toString());
    this.windowList = DrawContainer().windows;
    this.activeWindow = DrawContainer().activeWindow!;
    DrawContainer().calculateWinSizes(canvasSize);

    for (var win in this.windowList) {
      DrawHelper winHelper = drawWindow(
          canvas, win, DrawContainer().ratio, DrawContainer().center);
      winHelper.drawSimpleCase();
      winHelper.drawFrameMullion(win.frame!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  DrawHelper drawWindow(
      Canvas canvas, WindowObject activeWindow, double ratio, Offset center) {
    try {
      DrawHelper winHelper =
          new DrawHelper(this.canvasSize, canvas, 1, ratio, center);
      winHelper.windowObject = activeWindow;
      return winHelper;
    } catch (e) {
      print('Error: ' + e.toString());
      return new DrawHelper(this.canvasSize, canvas, 1, ratio, center);
    }
  }
}
