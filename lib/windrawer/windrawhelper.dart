import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:windesign/winentity/direction.dart';
import 'package:windesign/winentity/wincell.dart';
import 'package:windesign/winentity/window.dart';

class WinDrawHelper {
  late PWindow iWindow;
  Canvas iCanvas;
  double scale;
  Size screenSize;
  double ratio;
  Offset center;
  late double frameWidth;
  late double mullionWidth;
  late double sashWidth;
  late double latchWidth;
  late double rulerMargin;
  late double rulerTextMargin;
  late double rulerHeightMargin;
  late double rulerWidthTextMargin;
  late double rulerPointSize;
  late double fontSize;
  late Offset startPoint1;
  late Offset startPoint2;

  // Constants
  static const double _defaultLatchWidthRatio = 20;
  static const double _defaultRulerMarginRatio = 200;
  static const double _defaultRulerTextMarginRatio = 400;
  static const double _defaultRulerHeightMarginRatio = 150;
  static const double _defaultRulerWidthTextMarginRatio = 50;
  static const double _defaultRulerPointSizeRatio = 15;
  static const double _defaultFontSizeRatio = 50;
  static const double _defaultParagraphSizeRatio = 400;
  static const double _defaultMullionParagraphSizeRatio = 150;
  static const double _defaultKolRadius = 15;
  static const Color _defaultContourColor = Colors.black;
  static const Color _defaultFillColor = Colors.white;
  static const Color _defaultUnitColor = Colors.blue;
  static const Color _defaultRulerColor = Colors.grey;

  // Paint objects
  final Paint _paintContour = Paint()
    ..color = _defaultContourColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0;

  final Paint _paintFill = Paint()
    ..color = _defaultFillColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 0;

  final Paint _paintUnit = Paint()
    ..color = _defaultUnitColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 0;

  final Paint _paintRulerLine = Paint()
    ..color = _defaultContourColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  final Paint _paintRulerForeground = Paint()
    ..color = _defaultRulerColor
    ..style = PaintingStyle.fill;

  final Paint _paintGlassLine = Paint()
    ..color = _defaultContourColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  final Paint _paintKol = Paint()
    ..color = _defaultContourColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0;

  WinDrawHelper(
      this.screenSize, this.iCanvas, this.scale, this.ratio, this.center) {
    iWindow = PWindow(); // Initialize iWindow with a default frame
    latchWidth = _defaultLatchWidthRatio * ratio;
    rulerMargin = _defaultRulerMarginRatio * ratio;
    rulerTextMargin = _defaultRulerTextMarginRatio * ratio;
    rulerHeightMargin = _defaultRulerHeightMarginRatio * ratio;
    rulerWidthTextMargin = _defaultRulerWidthTextMarginRatio * ratio;
    rulerPointSize = _defaultRulerPointSizeRatio * ratio;
    fontSize = _defaultFontSizeRatio * ratio;
  }

  void repaintWin(Size screenSize, Canvas iCanvas, double scale) {
    this.iCanvas = iCanvas;
    this.screenSize = screenSize;
  }

  void drawSimpleCase() {
    Offset cp = center; // Center Point
    frameWidth = iWindow.frame!.top.profile.width * ratio;
    double windowWidth = iWindow.width ?? 0 * ratio;
    double windowHeight = iWindow.height ?? 0 * ratio;
    Offset windowStart = (iWindow.start ?? Offset.zero) * ratio + cp;

    Offset topLeft = Offset(windowStart.dx, windowStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + windowHeight);
    Offset bottomRight = Offset(bottomLeft.dx + windowWidth, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + windowWidth, topLeft.dy);

    startPoint1 = topLeft;
    startPoint2 = bottomLeft;

    // tan(45) = 1 corner = w
    double corner = frameWidth;

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    // Ruler
    drawFrameHeightRuler(iCanvas, topLeft, bottomLeft, iWindow.height ?? 0);
    drawFrameWidthRuler(iCanvas, bottomLeft, bottomRight, iWindow.width ?? 0);

    // Draw the four sections
    _drawSection(topLeft, bottomLeft, innerBottomLeft, innerTopLeft); // SOL
    _drawSection(
        bottomLeft, bottomRight, innerBottomRight, innerBottomLeft); // ALT
    _drawSection(bottomRight, topRight, innerTopRight, innerBottomRight); // SAG
    _drawSection(topRight, topLeft, innerTopLeft, innerTopRight); // UST
  }

  void _drawSection(Offset q1, Offset q2, Offset w2, Offset w1) {
    Path path = Path();
    path.addPolygon([q1, q2, w2, w1], true);
    iCanvas.drawPath(path, _paintFill);
    iCanvas.drawPath(path, _paintContour);
  }

  void drawSash(Wincell cell) {
    Offset cp = center; // Center Point
    sashWidth = cell.sash?.top.profile.width ?? 0 * ratio;

    double x1 = (cell.xPoint - (cell.sash?.sashMargin ?? 0)) * ratio;
    double y1 = (cell.yPoint - (cell.sash?.sashMargin ?? 0)) * ratio;
    Offset sashStart =
        ((iWindow.start ?? Offset.zero) * ratio) + Offset(x1, y1) + cp;

    double sashWidthRatio = (cell.sash?.sashWidth ?? 0) * ratio;
    double sashHeightRatio = (cell.sash?.sashHeight ?? 0) * ratio;

    double corner = sashWidth;

    Offset topLeft = Offset(sashStart.dx, sashStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + sashHeightRatio);
    Offset bottomRight = Offset(bottomLeft.dx + sashWidthRatio, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + sashWidthRatio, topLeft.dy);

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    drawSashUnit(innerTopLeft, cell);

    // Draw the four sections
    _drawSection(topLeft, bottomLeft, innerBottomLeft, innerTopLeft); // SOL
    _drawSection(
        bottomLeft, bottomRight, innerBottomRight, innerBottomLeft); // ALT
    _drawSection(bottomRight, topRight, innerTopRight, innerBottomRight); // SAG
    _drawSection(topRight, topLeft, innerTopLeft, innerTopRight); // UST

    // Draw Kol
    _drawKol(topLeft, bottomLeft, bottomRight, topRight, innerTopLeft,
        innerBottomRight, innerTopRight, cell);
    drawSashLacth(innerTopLeft, cell);
  }

  void _drawKol(
      Offset topLeft,
      Offset bottomLeft,
      Offset bottomRight,
      Offset topRight,
      Offset innerTopLeft,
      Offset innerBottomRight,
      Offset innerTopRight,
      Wincell cell) {
    double kolCenterY = 0;
    double kolCenterX = 0;
    Offset kolOffset;

    if (cell.sash?.openDirection.startsWith("left") == true) {
      kolCenterY = topLeft.dy + ((bottomLeft.dy - topLeft.dy) / 2);
      kolCenterX = topLeft.dx + ((innerTopLeft.dx - topLeft.dx) / 2);
    } else if (cell.sash?.openDirection.startsWith("right") == true) {
      kolCenterY = topRight.dy + ((bottomRight.dy - topRight.dy) / 2);
      kolCenterX = innerTopRight.dx + ((topRight.dx - innerTopRight.dx) / 2);
    } else if (cell.sash?.openDirection.startsWith("up") == true) {
      kolCenterY = topLeft.dy + ((innerTopLeft.dy - topLeft.dy) / 2);
      kolCenterX = topLeft.dx + ((topRight.dx - topLeft.dx) / 2);
    } else if (cell.sash?.openDirection.startsWith("down") == true) {
      kolCenterY = bottomLeft.dy + ((innerBottomRight.dy - bottomLeft.dy) / 2);
      kolCenterX = bottomLeft.dx + ((bottomRight.dx - bottomLeft.dx) / 2);
    }

    kolOffset = Offset(kolCenterX, kolCenterY);
    iCanvas.drawCircle(kolOffset, _defaultKolRadius * ratio, _paintKol);
  }

  void drawSashUnit(Offset startPoint, Wincell cell) {
    double x1 = startPoint.dx;
    double y1 = startPoint.dy;
    Offset unitStart =
        ((iWindow.start ?? Offset.zero) * ratio) + Offset(x1, y1);

    double unitWidth = (cell.sash?.unit.unitWidth ?? 0) * ratio;
    double unitHeight = (cell.sash?.unit.unitHeight ?? 0) * ratio;
    Size unitSize = Size(unitWidth, unitHeight);

    iCanvas.drawRect(unitStart & unitSize, _paintUnit);

    // Glass Line
    Offset p1 = Offset.zero;
    Offset p2 = Offset.zero;
    Offset p3 = Offset.zero;

    if (cell.sash?.openDirection.startsWith("left") == true) {
      p1 = Offset(unitStart.dx + unitSize.width, unitStart.dy);
      p2 = Offset(unitStart.dx, unitStart.dy + (unitSize.height / 2));
      p3 =
          Offset(unitStart.dx + unitSize.width, unitStart.dy + unitSize.height);
    } else if (cell.sash?.openDirection.startsWith("right") == true) {
      p1 = Offset(unitStart.dx, unitStart.dy);
      p2 = Offset(
          unitStart.dx + unitSize.width, unitStart.dy + (unitSize.height / 2));
      p3 = Offset(unitStart.dx, unitStart.dy + unitSize.height);
    } else if (cell.sash?.openDirection.startsWith("up") == true) {
      p1 = Offset(unitStart.dx, unitStart.dy + unitSize.height);
      p2 = Offset(unitStart.dx + (unitSize.width / 2), unitStart.dy);
      p3 =
          Offset(unitStart.dx + unitSize.width, unitStart.dy + unitSize.height);
    } else if (cell.sash?.openDirection.startsWith("down") == true) {
      p1 = Offset(unitStart.dx, unitStart.dy);
      p2 = Offset(
          unitStart.dx + (unitSize.width / 2), unitStart.dy + unitSize.height);
      p3 = Offset(unitStart.dx + unitSize.width, unitStart.dy);
    }

    Path pathGlass = Path();
    pathGlass.addPolygon([p1, p2, p3], false);
    iCanvas.drawPath(pathGlass, _paintGlassLine);

    if (cell.sash?.openDirection.contains("double") == true) {
      p1 = Offset(unitStart.dx, unitStart.dy + unitSize.height);
      p2 = Offset(unitStart.dx + (unitSize.width / 2), unitStart.dy);
      p3 =
          Offset(unitStart.dx + unitSize.width, unitStart.dy + unitSize.height);
      Path pathGlass2 = Path();
      pathGlass2.addPolygon([p1, p2, p3], false);
      iCanvas.drawPath(pathGlass2, _paintGlassLine);
    }
  }

  void drawSashLacth(Offset startPoint, Wincell cell) {
    double x1 = startPoint.dx;
    double y1 = startPoint.dy;
    Offset latchStart =
        ((iWindow.start ?? Offset.zero) * ratio) + Offset(x1, y1);

    double latchWidthRatio = ((cell.sash?.unit.unitWidth ?? 0) +
            (2 * (cell.sash?.sashMargin ?? 0))) *
        ratio;
    double latchHeightRatio = ((cell.sash?.unit.unitHeight ?? 0) +
            (2 * (cell.sash?.sashMargin ?? 0))) *
        ratio;

    double corner = latchWidth;

    Offset topLeft = Offset(latchStart.dx, latchStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + latchHeightRatio);
    Offset bottomRight = Offset(bottomLeft.dx + latchWidthRatio, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + latchWidthRatio, topLeft.dy);

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    // Draw the four sections
    _drawSection(topLeft, bottomLeft, innerBottomLeft, innerTopLeft); // SOL
    _drawSection(
        bottomLeft, bottomRight, innerBottomRight, innerBottomLeft); // ALT
    _drawSection(bottomRight, topRight, innerTopRight, innerBottomRight); // SAG
    _drawSection(topRight, topLeft, innerTopLeft, innerTopRight); // UST
  }

  void drawFrameMullion(Wincell cell) {
    Offset cp = center; // Center Point
    double x1 = cell.xPoint * ratio;
    double y1 = cell.yPoint * ratio;
    Offset mullionStart =
        ((iWindow.start ?? Offset.zero) * ratio) + Offset(x1, y1) + cp;

    if (cell.mullions.isNotEmpty) {
      for (var mullion in cell.mullions) {
        mullionWidth = mullion.part!.profile.width * ratio;
        double mullionPosition = mullion.cellposition! * ratio;
        double outPosition = mullion.position! * ratio;
        double realPositionText = mullion.position!;

        Offset m1 = Offset.zero;
        Offset m2 = Offset.zero;
        Offset m3 = Offset.zero;
        Offset m4 = Offset.zero;
        Offset r1 = Offset.zero;

        if (mullion.direction == Direction.vertical) {
          m1 = Offset((mullionPosition + mullionStart.dx) - (mullionWidth / 2),
              mullionStart.dy);
          m2 = Offset(m1.dx + mullionWidth, m1.dy);
          m3 = Offset(m2.dx, m2.dy + ((iWindow.height ?? 0) * ratio));
          m4 = Offset(m3.dx - mullionWidth, m3.dy);

          r1 = Offset((outPosition + startPoint2.dx), startPoint2.dy);

          drawVerticalMullionRuler(iCanvas, r1, realPositionText);
        } else if (mullion.direction == Direction.horizontal) {
          m1 = Offset(mullionStart.dx,
              (mullionPosition + mullionStart.dy) - (mullionWidth / 2));
          m2 = Offset(m1.dx, m1.dy + mullionWidth);
          m3 = Offset(m2.dx + ((iWindow.width ?? 0) * ratio), m2.dy);
          m4 = Offset(m3.dx, m3.dy - mullionWidth);

          r1 = Offset(startPoint1.dx, (outPosition + startPoint1.dy));

          drawHorizontalMullionRuler(iCanvas, r1, realPositionText);
        }

        Path path = Path();
        path.addPolygon([m1, m2, m3, m4], true);

        iCanvas.drawPath(path, _paintFill);
        iCanvas.drawPath(path, _paintContour);
      }

      for (var icell in cell.cells) {
        drawCellUnit(icell);
        drawSash(icell);
        drawFrameMullion(icell);
      }
    } else {
      drawCellUnit(cell);
      drawSash(cell);
    }
  }

  void drawCellUnit(Wincell cell) {
    Offset cp = center; // Center Point

    double x1 = cell.xPoint * ratio;
    double y1 = cell.yPoint * ratio;
    Offset unitStart =
        ((iWindow.start ?? Offset.zero) * ratio) + Offset(x1, y1) + cp;

    double unitWidth = cell.innerWidth * ratio;
    double unitHeight = cell.innerHeight * ratio;
    Size unitSize = Size(unitWidth, unitHeight);

    iCanvas.drawRect(unitStart & unitSize, _paintUnit);
    drawUnitLacth(cell);
  }

  void drawUnitLacth(Wincell cell) {
    Offset cp = center; // Center Point

    double x1 = cell.xPoint * ratio;
    double y1 = cell.yPoint * ratio;
    Offset latchStart =
        ((iWindow.start ?? Offset.zero) * ratio) + Offset(x1, y1) + cp;

    double latchWidthRatio = cell.innerWidth * ratio;
    double latchHeightRatio = cell.innerHeight * ratio;

    double corner = latchWidth;

    Offset topLeft = Offset(latchStart.dx, latchStart.dy);
    Offset bottomLeft = Offset(topLeft.dx, topLeft.dy + latchHeightRatio);
    Offset bottomRight = Offset(bottomLeft.dx + latchWidthRatio, bottomLeft.dy);
    Offset topRight = Offset(topLeft.dx + latchWidthRatio, topLeft.dy);

    Offset innerTopLeft = Offset(topLeft.dx + corner, topLeft.dy + corner);
    Offset innerBottomLeft = Offset(innerTopLeft.dx, bottomLeft.dy - corner);
    Offset innerBottomRight =
        Offset(bottomRight.dx - corner, innerBottomLeft.dy);
    Offset innerTopRight = Offset(innerBottomRight.dx, innerTopLeft.dy);

    // Draw the four sections
    _drawSection(topLeft, bottomLeft, innerBottomLeft, innerTopLeft); // SOL
    _drawSection(
        bottomLeft, bottomRight, innerBottomRight, innerBottomLeft); // ALT
    _drawSection(bottomRight, topRight, innerTopRight, innerBottomRight); // SAG
    _drawSection(topRight, topLeft, innerTopLeft, innerTopRight); // UST
  }

  void drawFrameHeightRuler(
      Canvas canvas, Offset startPoint, Offset endPoint, double len) {
    Offset sp = Offset(startPoint.dx - rulerMargin, startPoint.dy);
    Offset ep = Offset(endPoint.dx - rulerMargin, endPoint.dy);

    canvas.drawLine(sp, ep, _paintRulerLine);
    canvas.drawCircle(sp, rulerPointSize, _paintRulerLine);
    canvas.drawCircle(ep, rulerPointSize, _paintRulerLine);

    _drawRulerText(
        len, sp, ep, Offset(rulerTextMargin, 0), _defaultParagraphSizeRatio);
  }

  void drawFrameWidthRuler(
      Canvas canvas, Offset startPoint, Offset endPoint, double len) {
    Offset sp = Offset(startPoint.dx, startPoint.dy + rulerMargin);
    Offset ep = Offset(endPoint.dx, endPoint.dy + rulerMargin);

    canvas.drawLine(sp, ep, _paintRulerLine);
    canvas.drawCircle(sp, rulerPointSize, _paintRulerLine);
    canvas.drawCircle(ep, rulerPointSize, _paintRulerLine);

    Offset textPosition =
        Offset((sp.dx + (ep.dx - sp.dx) / 2), sp.dy + rulerWidthTextMargin);
    _drawRulerText(len, sp, ep, textPosition, _defaultParagraphSizeRatio);
  }

  void drawVerticalMullionRuler(
      Canvas canvas, Offset startPoint, double len) {
    Offset sp = Offset(startPoint.dx, startPoint.dy + rulerMargin);

    canvas.drawCircle(sp, rulerPointSize, _paintRulerLine);

    Offset textPosition = Offset(sp.dx, sp.dy + rulerWidthTextMargin);
    _drawRulerText(
        len, sp, sp, textPosition, _defaultMullionParagraphSizeRatio);
  }

  void drawHorizontalMullionRuler(
      Canvas canvas, Offset startPoint, double len) {
    Offset sp = Offset(startPoint.dx - rulerMargin, startPoint.dy);

    canvas.drawCircle(sp, rulerPointSize, _paintRulerLine);

    Offset textPosition = Offset(sp.dx - rulerHeightMargin, sp.dy);
    _drawRulerText(
        len, sp, sp, textPosition, _defaultMullionParagraphSizeRatio);
  }

  void _drawRulerText(double len, Offset sp, Offset ep, Offset textPosition,
      double paragraphSizeRatio) {
    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left));
    builder.pushStyle(ui.TextStyle(
        background: _paintRulerForeground,
        color: _defaultContourColor,
        fontSize: fontSize * 1.5));
    builder.addText(len.toString());
    final paragraph = builder.build();
    double paragraphsize = paragraphSizeRatio * ratio;
    paragraph.layout(ui.ParagraphConstraints(width: paragraphsize));

    if (textPosition == sp) {
      iCanvas.drawParagraph(paragraph,
          Offset(sp.dx - rulerTextMargin, (sp.dy + (ep.dy - sp.dy) / 2)));
    } else {
      iCanvas.drawParagraph(paragraph, textPosition);
    }
  }
}
