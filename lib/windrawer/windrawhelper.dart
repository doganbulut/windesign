import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:windesign/winentity/direction.dart';
import 'package:windesign/winentity/wincell.dart';
import 'package:windesign/winentity/window.dart';

enum OpenDirection {
  left,
  right,
  up,
  down,
  doubleLeft,
  doubleRight,
  doubleUp,
  doubleDown,
}

class WindowDrawingHelper {
  // Constants
  static const double _defaultLatchWidth = 20;
  static const double _defaultRulerMargin = 200;
  static const double _defaultRulerTextMargin = 400;
  static const double _defaultRulerHeightMargin = 150;
  static const double _defaultRulerWidthTextMargin = 50;
  static const double _defaultRulerPointSize = 15;
  static const double _defaultFontSize = 50;
  static const double _defaultParagraphSize = 400;
  static const double _defaultMullionParagraphSize = 150;

  // Properties
  PWindow? window;
  Canvas canvas;
  Size screenSize;
  double scaleRatio;
  Offset drawingCenter;
  double? frameWidth;
  double? mullionWidth;
  double? sashWidth;
  double? latchWidth;
  double? rulerMargin;
  double? rulerTextMargin;
  double? rulerHeightMargin;
  double? rulerWidthTextMargin;
  double? rulerPointSize;
  double? fontSize;
  double? paragraphWidth;
  Offset? startPoint1;
  Offset? startPoint2;

  // Constructor
  WindowDrawingHelper(
      this.screenSize, this.canvas, this.scaleRatio, this.drawingCenter) {
    _initializeParameters();
  }

  void _initializeParameters() {
    latchWidth = _defaultLatchWidth * scaleRatio;
    rulerMargin = _defaultRulerMargin * scaleRatio;
    rulerTextMargin = _defaultRulerTextMargin * scaleRatio;
    rulerHeightMargin = _defaultRulerHeightMargin * scaleRatio;
    rulerWidthTextMargin = _defaultRulerWidthTextMargin * scaleRatio;
    rulerPointSize = _defaultRulerPointSize * scaleRatio;
    fontSize = _defaultFontSize * scaleRatio;
  }

  // Methods
  void updateDrawingParameters(
      Size screenSize, Canvas canvas, double scaleRatio) {
    this.canvas = canvas;
    this.screenSize = screenSize;
    this.scaleRatio = scaleRatio;
    _initializeParameters();
  }

  void drawBasicWindow() {
    if (window == null || window!.frame.top == null) return;
    Offset centerPoint = drawingCenter;
    frameWidth = window!.frame.top!.profile.width * scaleRatio;
    double windowWidth = window!.width * scaleRatio;
    double windowHeight = window!.height * scaleRatio;
    Offset windowStart = (window!.start! * scaleRatio) + centerPoint;

    Offset topLeft = Offset(windowStart.dx, windowStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + windowHeight);
    Offset bottomRight = Offset(bottomLeft.dx + windowWidth, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + windowWidth, topLeft.dy);

    startPoint1 = topLeft;
    startPoint2 = bottomLeft;

    double corner = frameWidth!;

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    //Ruler
    drawHeightRuler(canvas, topLeft, bottomLeft, window!.height);
    drawWidthRuler(canvas, bottomLeft, bottomRight, window!.width);

    // Draw the window frame
    _drawFramePart(canvas, topLeft, bottomLeft, innerBottomLeft, innerTopLeft,
        Colors.white, "left");
    _drawFramePart(canvas, bottomLeft, bottomRight, innerBottomRight,
        innerBottomLeft, Colors.white, "bottom");
    _drawFramePart(canvas, bottomRight, topRight, innerTopRight,
        innerBottomRight, Colors.white, "right");
    _drawFramePart(canvas, topRight, topLeft, innerTopLeft, innerTopRight,
        Colors.white, "top");
  }

  void drawSashWithFrame(Wincell cell) {
    Offset centerPoint = drawingCenter;
    sashWidth = cell.sash!.top.profile.width * scaleRatio;

    double x1 = (cell.xPoint! - cell.sash!.sashMargin) * scaleRatio;
    double y1 = (cell.yPoint! - cell.sash!.sashMargin) * scaleRatio;
    Offset unitStart =
        (window!.start! * scaleRatio) + Offset(x1, y1) + centerPoint;

    double unitWidth = cell.sash!.sashWidth * scaleRatio;
    double unitHeight = cell.sash!.sashHeight * scaleRatio;

    double corner = sashWidth!;

    Offset topLeft = Offset(unitStart.dx, unitStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + unitHeight);
    Offset bottomRight = Offset(bottomLeft.dx + unitWidth, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + unitWidth, topLeft.dy);

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    drawSashGlassUnit(innerTopLeft, cell);

    // Draw the sash frame
    _drawFramePart(canvas, topLeft, bottomLeft, innerBottomLeft, innerTopLeft,
        Colors.white, "left");
    _drawFramePart(canvas, bottomLeft, bottomRight, innerBottomRight,
        innerBottomLeft, Colors.white, "bottom");
    _drawFramePart(canvas, bottomRight, topRight, innerTopRight,
        innerBottomRight, Colors.white, "right");
    _drawFramePart(canvas, topRight, topLeft, innerTopLeft, innerTopRight,
        Colors.white, "top");

    // Draw the latch
    //_drawSashLatch(innerTopLeft, cell);
  }

  void drawSashGlassUnit(Offset startPoint, Wincell cell) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double x1 = startPoint.dx;
    double y1 = startPoint.dy;
    Offset unitStart = (window!.start! * scaleRatio) + Offset(x1, y1);

    double unitWidth = cell.sash!.unit.unitWidth * scaleRatio;
    double unitHeight = cell.sash!.unit.unitHeight * scaleRatio;
    Size unitSize = Size(unitWidth, unitHeight);

    canvas.drawRect(unitStart & unitSize, paint);

    //Glass Line
    //_drawGlassLine(unitStart, unitSize, cell.sash.openDirection);
  }

/*
  void _drawGlassLine(Offset unitStart, Size unitSize, OpenDirection openDirection) {
    Offset p1;
    Offset p2;
    Offset p3;

    if (openDirection.startsWith("left")) {
      p1 = Offset(unitStart.dx + unitSize.width, unitStart.dy);
      p2 = Offset(unitStart.dx, unitStart.dy + (unitSize.height / 2));
      p3 =
          Offset(unitStart.dx + unitSize.width, unitStart.dy + unitSize.height);
    } else if (openDirection.startsWith("right")) {
      p1 = Offset(unitStart.dx, unitStart.dy);
      p2 = Offset(
          unitStart.dx + unitSize.width, unitStart.dy + (unitSize.height / 2));
      p3 = Offset(unitStart.dx, unitStart.dy + unitSize.height);
    } else if (openDirection.startsWith("up")) {
      p1 = Offset(unitStart.dx, unitStart.dy + unitSize.height);
      p2 = Offset(unitStart.dx + (unitSize.width / 2), unitStart.dy);
      p3 =
          Offset(unitStart.dx + unitSize.width, unitStart.dy + unitSize.height);
    } else if (openDirection.startsWith("down")) {
      p1 = Offset(unitStart.dx, unitStart.dy);
      p2 = Offset(
          unitStart.dx + (unitSize.width / 2), unitStart.dy + unitSize.height);
      p3 = Offset(unitStart.dx + unitSize.width, unitStart.dy);
    } else {
      return;
    }

    Paint paintGlassLine = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path pathGlass = Path();
    pathGlass.addPolygon([p1, p2, p3], false);
    canvas.drawPath(pathGlass, paintGlassLine);

    if (openDirection.contains("double")) {
      p1 = Offset(unitStart.dx, unitStart.dy + unitSize.height);
      p2 = Offset(unitStart.dx + (unitSize.width / 2), unitStart.dy);
      p3 =
          Offset(unitStart.dx + unitSize.width, unitStart.dy + unitSize.height);
      Path pathGlass2 = Path();
      pathGlass2.addPolygon([p1, p2, p3], false);
      canvas.drawPath(pathGlass2, paintGlassLine);
    }
  }

  void _drawSashLatch(Offset startPoint, Wincell cell) {
    if (cell.sash.unit == null) return;
    double x1 = startPoint.dx;
    double y1 = startPoint.dy;
    Offset unitStart = (window!.start! * scaleRatio) + Offset(x1, y1);

    double unitWidth =
        (cell.sash.unit.unitWidth + (2 * cell.sash.sashMargin)) * scaleRatio;
    double unitHeight =
        (cell.sash.unit.unitHeight + (2 * cell.sash.sashMargin)) * scaleRatio;

    double corner = latchWidth!;

    Offset topLeft = Offset(unitStart.dx, unitStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + unitHeight);
    Offset bottomRight = Offset(bottomLeft.dx + unitWidth, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + unitWidth, topLeft.dy);

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    // Draw the latch frame
    _drawFramePart(canvas, topLeft, bottomLeft, innerBottomLeft, innerTopLeft,
        Colors.white, "left");
    _drawFramePart(canvas, bottomLeft, bottomRight, innerBottomRight,
        innerBottomLeft, Colors.white, "bottom");
    _drawFramePart(canvas, bottomRight, topRight, innerTopRight,
        innerBottomRight, Colors.white, "right");
    _drawFramePart(canvas, topRight, topLeft, innerTopLeft, innerTopRight,
        Colors.white, "top");

    // Draw the latch
    Paint paintLatch = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    double latchCenterY = 0;
    double latchCenterX = 0;
    Offset latchOffset;

    if (cell.sash.openDirection.startsWith("left")) {
      latchCenterY = topLeft.dy + ((bottomLeft.dy - topLeft.dy) / 2);
      latchCenterX = topLeft.dx + ((innerTopLeft.dx - topLeft.dx) / 2);
    } else if (cell.sash.openDirection.startsWith("right")) {
      latchCenterY = topRight.dy + ((bottomRight.dy - topRight.dy) / 2);
      latchCenterX = innerTopRight.dx + ((topRight.dx - innerTopRight.dx) / 2);
    } else if (cell.sash.openDirection.startsWith("up")) {
      latchCenterY = topLeft.dy + ((innerTopLeft.dy - topLeft.dy) / 2);
      latchCenterX = topLeft.dx + ((topRight.dx - topLeft.dx) / 2);
    } else if (cell.sash.openDirection.startsWith("down")) {
      latchCenterY =
          bottomLeft.dy + ((innerBottomRight.dy - bottomLeft.dy) / 2);
      latchCenterX = bottomLeft.dx + ((bottomRight.dx - bottomLeft.dx) / 2);
    }

    latchOffset = Offset(latchCenterX, latchCenterY);
    canvas.drawCircle(latchOffset, 15 * scaleRatio, paintLatch);
  }
  */

  void drawMullion(Wincell cell) {
    Offset centerPoint = drawingCenter;
    double x1 = cell.xPoint! * scaleRatio;
    double y1 = cell.yPoint! * scaleRatio;
    Offset unitStart =
        (window!.start! * scaleRatio) + Offset(x1, y1) + centerPoint;

    if (cell.mullions.isNotEmpty) {
      for (var mullion in cell.mullions) {
        if (mullion.part == null) continue;
        mullionWidth = mullion.part.profile.width * scaleRatio;
        double mullionPosition = mullion.cellposition * scaleRatio;
        double outPosition = mullion.position * scaleRatio;
        double realPositionText = mullion.position;
        double mullionInlen = mullion.part.inlen * scaleRatio;

        Offset mullionCorner1;
        Offset mullionCorner2;
        Offset mullionCorner3;
        Offset mullionCorner4;
        Offset rulerStart;

        if (mullion.direction == Direction.vertical) {
          mullionCorner1 = Offset(
              (mullionPosition + unitStart.dx) - (mullionWidth! / 2),
              unitStart.dy);
          mullionCorner2 =
              Offset(mullionCorner1.dx + mullionWidth!, mullionCorner1.dy);
          mullionCorner3 =
              Offset(mullionCorner2.dx, mullionCorner2.dy + mullionInlen);
          mullionCorner4 =
              Offset(mullionCorner3.dx - mullionWidth!, mullionCorner3.dy);

          rulerStart = Offset((outPosition + startPoint2!.dx), startPoint2!.dy);

          drawVerticalRuler(canvas, rulerStart, realPositionText);
        } else if (mullion.direction == Direction.horizontal) {
          mullionCorner1 = Offset(unitStart.dx,
              (mullionPosition + unitStart.dy) - (mullionWidth! / 2));
          mullionCorner2 =
              Offset(mullionCorner1.dx, mullionCorner1.dy + mullionWidth!);
          mullionCorner3 =
              Offset(mullionCorner2.dx + mullionInlen, mullionCorner2.dy);
          mullionCorner4 =
              Offset(mullionCorner3.dx, mullionCorner3.dy - mullionWidth!);

          rulerStart = Offset(startPoint1!.dx, (outPosition + startPoint1!.dy));

          drawHorizontalRuler(canvas, rulerStart, realPositionText);
        } else {
          continue;
        }

        Paint paintContour = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0;

        Paint paintColor = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill
          ..strokeWidth = 0;

        Path pathUst = Path();
        pathUst.addPolygon(
            [mullionCorner1, mullionCorner2, mullionCorner3, mullionCorner4],
            true);

        canvas.drawPath(pathUst, paintColor);
        canvas.drawPath(pathUst, paintContour);
      }

      for (var icell in cell.cells) {
        if (icell.unit != null) drawCell(icell);
        if (icell.sash != null) drawSashWithFrame(icell);
        drawMullion(icell);
      }
    } else {
      if (cell.unit != null) drawCell(cell);
      if (cell.sash != null) drawSashWithFrame(cell);
    }
  }

  void drawCell(Wincell cell) {
    Offset centerPoint = drawingCenter;
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double x1 = cell.xPoint! * scaleRatio;
    double y1 = cell.yPoint! * scaleRatio;
    Offset unitStart =
        (window!.start! * scaleRatio) + Offset(x1, y1) + centerPoint;

    double unitWidth = cell.inWidth! * scaleRatio;
    double unitHeight = cell.inHeight! * scaleRatio;
    Size unitSize = Size(unitWidth, unitHeight);

    canvas.drawRect(unitStart & unitSize, paint);
    _drawCellLatch(cell);
  }

  void _drawCellLatch(Wincell cell) {
    Offset centerPoint = drawingCenter;

    double x1 = cell.xPoint! * scaleRatio;
    double y1 = cell.yPoint! * scaleRatio;
    Offset unitStart =
        (window!.start! * scaleRatio) + Offset(x1, y1) + centerPoint;

    double unitWidth = cell.inWidth! * scaleRatio;
    double unitHeight = cell.inHeight! * scaleRatio;

    double corner = latchWidth!;

    Offset topLeft = Offset(unitStart.dx, unitStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + unitHeight);
    Offset bottomRight = Offset(bottomLeft.dx + unitWidth, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + unitWidth, topLeft.dy);

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    // Draw the latch frame
    _drawFramePart(canvas, topLeft, bottomLeft, innerBottomLeft, innerTopLeft,
        Colors.white, "left");
    _drawFramePart(canvas, bottomLeft, bottomRight, innerBottomRight,
        innerBottomLeft, Colors.white, "bottom");
    _drawFramePart(canvas, bottomRight, topRight, innerTopRight,
        innerBottomRight, Colors.white, "right");
    _drawFramePart(canvas, topRight, topLeft, innerTopLeft, innerTopRight,
        Colors.white, "top");
  }

  void _drawFramePart(Canvas canvas, Offset corner1, Offset corner2,
      Offset innerCorner1, Offset innerCorner2, Color color, String part) {
    Paint paintContour = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintColor = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path = Path();
    path.addPolygon([corner1, corner2, innerCorner2, innerCorner1], true);

    canvas.drawPath(path, paintColor);
    canvas.drawPath(path, paintContour);
  }

  void drawHeightRuler(
      Canvas canvas, Offset startPoint, Offset endPoint, double len) {
    Paint paintline = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset rulerStartPoint =
        Offset(startPoint.dx - rulerMargin!, startPoint.dy);
    Offset rulerEndPoint = Offset(endPoint.dx - rulerMargin!, endPoint.dy);

    canvas.drawLine(rulerStartPoint, rulerEndPoint, paintline);
    canvas.drawCircle(rulerStartPoint, rulerPointSize!, paintline);
    canvas.drawCircle(rulerEndPoint, rulerPointSize!, paintline);

    _drawRulerText(canvas, rulerStartPoint, rulerEndPoint, len, true);
  }

  void drawWidthRuler(
      Canvas canvas, Offset startPoint, Offset endPoint, double len) {
    Paint paintline = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset rulerStartPoint =
        Offset(startPoint.dx, startPoint.dy + rulerMargin!);
    Offset rulerEndPoint = Offset(endPoint.dx, endPoint.dy + rulerMargin!);

    canvas.drawLine(rulerStartPoint, rulerEndPoint, paintline);
    canvas.drawCircle(rulerStartPoint, rulerPointSize!, paintline);
    canvas.drawCircle(rulerEndPoint, rulerPointSize!, paintline);

    _drawRulerText(canvas, rulerStartPoint, rulerEndPoint, len, false);
  }

  void drawVerticalRuler(Canvas canvas, Offset startPoint, double len) {
    Paint paintline = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset rulerStartPoint =
        Offset(startPoint.dx, startPoint.dy + rulerMargin!);

    canvas.drawCircle(rulerStartPoint, rulerPointSize!, paintline);

    _drawMullionRulerText(canvas, rulerStartPoint, len, false);
  }

  void drawHorizontalRuler(Canvas canvas, Offset startPoint, double len) {
    Paint paintline = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset rulerStartPoint =
        Offset(startPoint.dx - rulerMargin!, startPoint.dy);

    canvas.drawCircle(rulerStartPoint, rulerPointSize!, paintline);

    _drawMullionRulerText(canvas, rulerStartPoint, len, true);
  }

  void _drawRulerText(Canvas canvas, Offset rulerStartPoint,
      Offset rulerEndPoint, double len, bool isVertical) {
    Paint paintForeground = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: isVertical ? TextAlign.right : TextAlign.left));
    builder.pushStyle(ui.TextStyle(
        background: paintForeground,
        color: Colors.black,
        fontSize: fontSize! * 1.5));
    builder.addText(len.toString());
    final paragraph = builder.build();
    paragraph.layout(
        ui.ParagraphConstraints(width: _defaultParagraphSize * scaleRatio));

    Offset textPosition = isVertical
        ? Offset(rulerStartPoint.dx - rulerTextMargin!,
            (rulerStartPoint.dy + (rulerEndPoint.dy - rulerStartPoint.dy) / 2))
        : Offset(
            (rulerStartPoint.dx + (rulerEndPoint.dx - rulerStartPoint.dx) / 2),
            rulerStartPoint.dy + rulerWidthTextMargin!);
    canvas.drawParagraph(paragraph, textPosition);
  }

  void _drawMullionRulerText(
      Canvas canvas, Offset rulerStartPoint, double len, bool isHorizontal) {
    Paint paintForeground = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left));
    builder.pushStyle(ui.TextStyle(
        background: paintForeground, color: Colors.black, fontSize: fontSize!));
    builder.addText(len.toString());
    final paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(
        width: _defaultMullionParagraphSize * scaleRatio));

    Offset textPosition = isHorizontal
        ? Offset(rulerStartPoint.dx - rulerHeightMargin!, rulerStartPoint.dy)
        : Offset(
            rulerStartPoint.dx, rulerStartPoint.dy + rulerWidthTextMargin!);
    canvas.drawParagraph(paragraph, textPosition);
  }
}
