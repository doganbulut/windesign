import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:windesign/winentity/direction.dart';
import 'package:windesign/winentity/wincell.dart';
import 'package:windesign/winentity/window.dart';

class WinDrawHelper {
  late PWindow iWindow;
  late Canvas iCanvas;
  late double scale;
  late Size screenSize;
  late double ratio;
  late Offset center;
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
  late double paragraphWidth;
  late Offset startPoint1;
  late Offset startPoint2;

  WinDrawHelper(Size screenSize, Canvas iCanvas, double scale,
      double ratio, Offset center) {
    this.iCanvas = iCanvas;
    this.screenSize = screenSize;
    this.ratio = ratio;
    this.center = center;
    this.latchWidth = 20 * this.ratio;
    this.rulerMargin = 200 * this.ratio;
    this.rulerTextMargin = 400 * this.ratio;
    this.rulerHeightMargin = 150 * this.ratio;
    this.rulerWidthTextMargin = 50 * this.ratio;
    this.rulerPointSize = 15 * this.ratio;
    this.fontSize = 50 * this.ratio;
  }

  void repaintWin(Size screenSize, Canvas iCanvas, double scale) {
    this.iCanvas = iCanvas;
    this.screenSize = screenSize;
  }

  drawSimpleCase() {
    Offset cp = this.center; //Center Point;
    this.frameWidth = this.iWindow.frame.top.profile.width * this.ratio;
    double x = this.iWindow.width * this.ratio;
    double y = this.iWindow.height * this.ratio;
    Offset ustart = (this.iWindow.start * this.ratio) + cp;

    Offset q1 = new Offset(ustart.dx, ustart.dy);
    Offset q2 = new Offset(q1.dx, q1.dy + y);
    Offset q3 = new Offset(q2.dx + x, q2.dy);
    Offset q4 = new Offset(q1.dx + x, q1.dy);

    startPoint1 = q1;
    startPoint2 = q2;

    //tan(45) = 1 corner = w
    double corner = this.frameWidth;

    Offset w1 = new Offset(q1.dx + corner, q1.dy + corner);
    Offset w2 = new Offset(w1.dx, q2.dy - corner);
    Offset w3 = new Offset(q3.dx - corner, w2.dy);
    Offset w4 = new Offset(w3.dx, w1.dy);

    //Ruler
    drawFrameHeightRuler(this.iCanvas, q1, q2, this.iWindow.height);
    drawFrameWidthRuler(this.iCanvas, q2, q3, this.iWindow.width);

    //SOL
    Paint paintSolContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSolColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSol = new Path();
    pathSol.addPolygon([q1, q2, w2, w1], true);

    this.iCanvas.drawPath(pathSol, paintSolColor);
    this.iCanvas.drawPath(pathSol, paintSolContour);

    //ALT

    Paint paintAltContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintAltColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathAlt = new Path();
    pathAlt.addPolygon([q2, q3, w3, w2], true);

    this.iCanvas.drawPath(pathAlt, paintAltColor);
    this.iCanvas.drawPath(pathAlt, paintAltContour);

    //SAG

    Paint paintSagContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSagColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSag = new Path();
    pathSag.addPolygon([q3, q4, w4, w3], true);

    this.iCanvas.drawPath(pathSag, paintSagColor);
    this.iCanvas.drawPath(pathSag, paintSagContour);

    //UST
    Paint paintUstContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintUstColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathUst = new Path();
    pathUst.addPolygon([q4, q1, w1, w4], true);

    this.iCanvas.drawPath(pathUst, paintUstColor);
    this.iCanvas.drawPath(pathUst, paintUstContour);
  }

  drawSash(Wincell cell) {
    if (cell.sash == null) return;
    
    Offset cp = this.center; //Center Point;
    this.sashWidth = cell.sash!.top.profile.width * this.ratio;

    double x1 = (cell.xPoint - cell.sash!.sashMargin) * this.ratio;
    double y1 = (cell.yPoint - cell.sash!.sashMargin) * this.ratio;
    Offset ustart = (this.iWindow.start * this.ratio) + Offset(x1, y1) + cp;

    double uwidth = cell.sash!.sashWidth * this.ratio;
    double uheight = cell.sash!.sashHeight * this.ratio;

    double corner = this.sashWidth;

    Offset q1 = new Offset(ustart.dx, ustart.dy);
    Offset q2 = new Offset(q1.dx, q1.dy + uheight);
    Offset q3 = new Offset(q2.dx + uwidth, q2.dy);
    Offset q4 = new Offset(q1.dx + uwidth, q1.dy);

    Offset w1 = new Offset(q1.dx + corner, q1.dy + corner);
    Offset w2 = new Offset(w1.dx, q2.dy - corner);
    Offset w3 = new Offset(q3.dx - corner, w2.dy);
    Offset w4 = new Offset(w3.dx, w1.dy);

    drawSashUnit(w1, cell);

    //SOL
    Paint paintSolContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSolColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSol = new Path();
    pathSol.addPolygon([q1, q2, w2, w1], true);

    this.iCanvas.drawPath(pathSol, paintSolColor);
    this.iCanvas.drawPath(pathSol, paintSolContour);

    //ALT
    Paint paintAltContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintAltColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathAlt = new Path();
    pathAlt.addPolygon([q2, q3, w3, w2], true);

    this.iCanvas.drawPath(pathAlt, paintAltColor);
    this.iCanvas.drawPath(pathAlt, paintAltContour);

    //SAG
    Paint paintSagContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSagColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSag = new Path();
    pathSag.addPolygon([q3, q4, w4, w3], true);

    this.iCanvas.drawPath(pathSag, paintSagColor);
    this.iCanvas.drawPath(pathSag, paintSagContour);

    //UST
    Paint paintUstContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintUstColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathUst = new Path();
    pathUst.addPolygon([q4, q1, w1, w4], true);

    this.iCanvas.drawPath(pathUst, paintUstColor);
    this.iCanvas.drawPath(pathUst, paintUstContour);

    //Kol Çiz
    Paint paintKol = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    double kolCenterY = 0;
    double kolCenterX = 0;
    Offset kolOffset;

    if (cell.sash!.openDirection.startsWith("left")) {
      kolCenterY = q1.dy + ((q2.dy - q1.dy) / 2);
      kolCenterX = q1.dx + ((w1.dx - q1.dx) / 2);
    } else if (cell.sash!.openDirection.startsWith("right")) {
      kolCenterY = q4.dy + ((q3.dy - q4.dy) / 2);
      kolCenterX = w4.dx + ((q4.dx - w4.dx) / 2);
    } else if (cell.sash!.openDirection.startsWith("up")) {
      kolCenterY = q1.dy + ((w1.dy - q1.dy) / 2);
      kolCenterX = q1.dx + ((q4.dx - q1.dx) / 2);
    } else if (cell.sash!.openDirection.startsWith("down")) {
      kolCenterY = q2.dy + ((w3.dy - q2.dy) / 2);
      kolCenterX = q2.dx + ((q3.dx - q2.dx) / 2);
    }

    kolOffset = Offset(kolCenterX, kolCenterY);
    this.iCanvas.drawCircle(kolOffset, 15 * this.ratio, paintKol);
    drawSashLacth(w1, cell);
  }

  drawSashUnit(Offset startPoint, Wincell cell) {
    if (cell.sash?.unit == null) return;
    
    Paint paint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double x1 = startPoint.dx;
    double y1 = startPoint.dy;
    Offset ustart = (this.iWindow.start * this.ratio) + Offset(x1, y1);

    double uwidth = cell.sash!.unit!.unitWidth * this.ratio;
    double uheight = cell.sash!.unit!.unitHeight * this.ratio;
    Size usize = Size(uwidth, uheight);

    this.iCanvas.drawRect(ustart & usize, paint);

    //Glass Line
    Offset? p1;
    Offset? p2;
    Offset? p3;

    if (cell.sash!.openDirection.startsWith("left")) {
      p1 = new Offset(ustart.dx + usize.width, ustart.dy);
      p2 = new Offset(ustart.dx, ustart.dy + (usize.height / 2));
      p3 = new Offset(ustart.dx + usize.width, ustart.dy + usize.height);
    } else if (cell.sash!.openDirection.startsWith("right")) {
      p1 = new Offset(ustart.dx, ustart.dy);
      p2 = new Offset(ustart.dx + usize.width, ustart.dy + (usize.height / 2));
      p3 = new Offset(ustart.dx, ustart.dy + usize.height);
    } else if (cell.sash!.openDirection.startsWith("up")) {
      p1 = new Offset(ustart.dx, ustart.dy + usize.height);
      p2 = new Offset(ustart.dx + (usize.width / 2), ustart.dy);
      p3 = new Offset(ustart.dx + usize.width, ustart.dy + usize.height);
    } else if (cell.sash!.openDirection.startsWith("down")) {
      p1 = new Offset(ustart.dx, ustart.dy);
      p2 = new Offset(ustart.dx + (usize.width / 2), ustart.dy + usize.height);
      p3 = new Offset(ustart.dx + usize.width, ustart.dy);
    }

    if (p1 != null && p2 != null && p3 != null) {
      Paint paintGlassLine = new Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      Path pathGlass = new Path();
      pathGlass.addPolygon([p1, p2, p3], false);
      this.iCanvas.drawPath(pathGlass, paintGlassLine);

      if (cell.sash!.openDirection.contains("double")) {
        p1 = new Offset(ustart.dx, ustart.dy + usize.height);
        p2 = new Offset(ustart.dx + (usize.width / 2), ustart.dy);
        p3 = new Offset(ustart.dx + usize.width, ustart.dy + usize.height);
        Path pathGlass2 = new Path();
        pathGlass2.addPolygon([p1, p2, p3], false);
        this.iCanvas.drawPath(pathGlass2, paintGlassLine);
      }
    }
  }

  drawSashLacth(Offset startPoint, Wincell cell) {
    if (cell.sash?.unit == null) return;
    
    double x1 = startPoint.dx;
    double y1 = startPoint.dy;
    Offset ustart = (this.iWindow.start * this.ratio) + Offset(x1, y1);

    double uwidth =
        (cell.sash!.unit!.unitWidth + (2 * cell.sash!.sashMargin)) * this.ratio;
    double uheight =
        (cell.sash!.unit!.unitHeight + (2 * cell.sash!.sashMargin)) * this.ratio;

    double corner = this.latchWidth;

    Offset q1 = new Offset(ustart.dx, ustart.dy);
    Offset q2 = new Offset(q1.dx, q1.dy + uheight);
    Offset q3 = new Offset(q2.dx + uwidth, q2.dy);
    Offset q4 = new Offset(q1.dx + uwidth, q1.dy);

    Offset w1 = new Offset(q1.dx + corner, q1.dy + corner);
    Offset w2 = new Offset(w1.dx, q2.dy - corner);
    Offset w3 = new Offset(q3.dx - corner, w2.dy);
    Offset w4 = new Offset(w3.dx, w1.dy);

    //SOL
    Paint paintSolContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSolColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSol = new Path();
    pathSol.addPolygon([q1, q2, w2, w1], true);

    this.iCanvas.drawPath(pathSol, paintSolColor);
    this.iCanvas.drawPath(pathSol, paintSolContour);

    //ALT
    Paint paintAltContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintAltColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathAlt = new Path();
    pathAlt.addPolygon([q2, q3, w3, w2], true);

    this.iCanvas.drawPath(pathAlt, paintAltColor);
    this.iCanvas.drawPath(pathAlt, paintAltContour);

    //SAG
    Paint paintSagContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSagColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSag = new Path();
    pathSag.addPolygon([q3, q4, w4, w3], true);

    this.iCanvas.drawPath(pathSag, paintSagColor);
    this.iCanvas.drawPath(pathSag, paintSagContour);

    //UST
    Paint paintUstContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintUstColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathUst = new Path();
    pathUst.addPolygon([q4, q1, w1, w4], true);

    this.iCanvas.drawPath(pathUst, paintUstColor);
    this.iCanvas.drawPath(pathUst, paintUstContour);
  }

  drawFrameMullion(Wincell cell) {
    Offset cp = this.center; //Center Point;
    double x1 = cell.xPoint * this.ratio;
    double y1 = cell.yPoint * this.ratio;
    Offset ustart = (this.iWindow.start * this.ratio) + Offset(x1, y1) + cp;

    if (cell.mullions.length > 0) {
      for (var mullion in cell.mullions) {
        this.mullionWidth = mullion.part.profile.width * this.ratio;
        double mullionPosition = mullion.cellposition * this.ratio;
        double outPosition = mullion.position * this.ratio;
        double realPositionText = mullion.position;
        double mullionInlen = mullion.part.inlen * this.ratio;

        Offset? m1;
        Offset? m2;
        Offset? m3;
        Offset? m4;

        if (mullion.direction == Direction.vertical) {
          m1 = new Offset(
              (mullionPosition + ustart.dx) - (this.mullionWidth / 2),
              ustart.dy);
          m2 = new Offset(m1.dx + this.mullionWidth, m1.dy);
          m3 = new Offset(m2.dx, m2.dy + mullionInlen);
          m4 = new Offset(m3.dx - this.mullionWidth, m3.dy);

          Offset r1 = new Offset((outPosition + startPoint2.dx), startPoint2.dy);

          drawVerticalMullionRuler(this.iCanvas, r1, realPositionText);
        } else if (mullion.direction == Direction.horizontal) {
          m1 = new Offset(ustart.dx,
              (mullionPosition + ustart.dy) - (this.mullionWidth / 2));
          m2 = new Offset(m1.dx, m1.dy + this.mullionWidth);
          m3 = new Offset(m2.dx + mullionInlen, m2.dy);
          m4 = new Offset(m3.dx, m3.dy - this.mullionWidth);

          Offset r1 = new Offset(startPoint1.dx, (outPosition + startPoint1.dy));

          drawHorizontalMullionRuler(this.iCanvas, r1, realPositionText);
        }

        // Only draw if all offsets are initialized
        if (m1 != null && m2 != null && m3 != null && m4 != null) {
          Paint paintContour = new Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0;

          Paint paintColor = new Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill
            ..strokeWidth = 0;

          Path pathUst = new Path();
          pathUst.addPolygon([m1, m2, m3, m4], true);

          this.iCanvas.drawPath(pathUst, paintColor);
          this.iCanvas.drawPath(pathUst, paintContour);
        }
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

  drawCellUnit(Wincell cell) {
    Offset cp = this.center; //Center Point;
    Paint paint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double x1 = cell.xPoint * this.ratio;
    double y1 = cell.yPoint * this.ratio;
    Offset ustart = (this.iWindow.start * this.ratio) + Offset(x1, y1) + cp;

    double uwidth = cell.inWidth * this.ratio;
    double uheight = cell.inHeight * this.ratio;
    Size usize = Size(uwidth, uheight);

    this.iCanvas.drawRect(ustart & usize, paint);
    drawUnitLacth(cell);
  }

  drawUnitLacth(Wincell cell) {
    Offset cp = this.center; //Center Point;

    double x1 = cell.xPoint * this.ratio;
    double y1 = cell.yPoint * this.ratio;
    Offset ustart = (this.iWindow.start * this.ratio) + Offset(x1, y1) + cp;

    double uwidth = cell.inWidth * this.ratio;
    double uheight = cell.inHeight * this.ratio;

    double corner = this.latchWidth;

    Offset q1 = new Offset(ustart.dx, ustart.dy);
    Offset q2 = new Offset(q1.dx, q1.dy + uheight);
    Offset q3 = new Offset(q2.dx + uwidth, q2.dy);
    Offset q4 = new Offset(q1.dx + uwidth, q1.dy);

    Offset w1 = new Offset(q1.dx + corner, q1.dy + corner);
    Offset w2 = new Offset(w1.dx, q2.dy - corner);
    Offset w3 = new Offset(q3.dx - corner, w2.dy);
    Offset w4 = new Offset(w3.dx, w1.dy);

    //SOL
    Paint paintSolContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSolColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSol = new Path();
    pathSol.addPolygon([q1, q2, w2, w1], true);

    this.iCanvas.drawPath(pathSol, paintSolColor);
    this.iCanvas.drawPath(pathSol, paintSolContour);

    //ALT
    Paint paintAltContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintAltColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathAlt = new Path();
    pathAlt.addPolygon([q2, q3, w3, w2], true);

    this.iCanvas.drawPath(pathAlt, paintAltColor);
    this.iCanvas.drawPath(pathAlt, paintAltContour);

    //SAG
    Paint paintSagContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintSagColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathSag = new Path();
    pathSag.addPolygon([q3, q4, w4, w3], true);

    this.iCanvas.drawPath(pathSag, paintSagColor);
    this.iCanvas.drawPath(pathSag, paintSagContour);

    //UST
    Paint paintUstContour = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    Paint paintUstColor = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path pathUst = new Path();
    pathUst.addPolygon([q4, q1, w1, w4], true);

    this.iCanvas.drawPath(pathUst, paintUstColor);
    this.iCanvas.drawPath(pathUst, paintUstContour);
  }

  drawFrameHeightRuler(
      Canvas canvas, Offset startPoint, endPoint, double len) {
    Paint paintline = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset sp = new Offset(startPoint.dx - rulerMargin, startPoint.dy);
    Offset ep = new Offset(endPoint.dx - rulerMargin, endPoint.dy);

    canvas.drawLine(sp, ep, paintline);
    canvas.drawCircle(sp, this.rulerPointSize, paintline);
    canvas.drawCircle(ep, this.rulerPointSize, paintline);

    Paint paintForeground = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.right));
    builder.pushStyle(ui.TextStyle(
        background: paintForeground,
        color: Colors.black,
        fontSize: this.fontSize * 1.5));
    builder.addText(len.toString());
    final paragraph = builder.build();
    double paragraphsize = 400 * this.ratio;
    paragraph.layout(new ui.ParagraphConstraints(width: paragraphsize));

    Offset textPosition =
        new Offset(sp.dx - rulerTextMargin, (sp.dy + (ep.dy - sp.dy) / 2));
    this.iCanvas.drawParagraph(paragraph, textPosition);
  }

  drawFrameWidthRuler(
      Canvas canvas, Offset startPoint, endPoint, double len) {
    Paint paintline = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset sp = new Offset(startPoint.dx, startPoint.dy + rulerMargin);
    Offset ep = new Offset(endPoint.dx, endPoint.dy + rulerMargin);

    canvas.drawLine(sp, ep, paintline);
    canvas.drawCircle(sp, this.rulerPointSize, paintline);
    canvas.drawCircle(ep, this.rulerPointSize, paintline);

    Paint paintForeground = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left));
    builder.pushStyle(ui.TextStyle(
        background: paintForeground,
        color: Colors.black,
        fontSize: this.fontSize * 1.5));
    builder.addText(len.toString());
    final paragraph = builder.build();
    double paragraphsize = 400 * this.ratio;
    paragraph.layout(new ui.ParagraphConstraints(width: paragraphsize));

    Offset textPosition =
        new Offset((sp.dx + (ep.dx - sp.dx) / 2), sp.dy + rulerWidthTextMargin);
    this.iCanvas.drawParagraph(paragraph, textPosition);
  }

  drawVerticalMullionRuler(Canvas canvas, Offset startPoint, double len) {
    Paint paintline = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset sp = new Offset(startPoint.dx, startPoint.dy + rulerMargin);

    canvas.drawCircle(sp, this.rulerPointSize, paintline);

    Paint paintForeground = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left));
    builder.pushStyle(ui.TextStyle(
        background: paintForeground,
        color: Colors.black,
        fontSize: this.fontSize));
    builder.addText(len.toString());
    final paragraph = builder.build();
    double paragraphsize = 150 * this.ratio;
    paragraph.layout(new ui.ParagraphConstraints(width: paragraphsize));

    Offset textPosition = new Offset(sp.dx, sp.dy + rulerWidthTextMargin);
    this.iCanvas.drawParagraph(paragraph, textPosition);
  }

  drawHorizontalMullionRuler(
      Canvas canvas, Offset startPoint, double len) {
    Paint paintline = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Offset sp = new Offset(startPoint.dx - rulerMargin, startPoint.dy);

    canvas.drawCircle(sp, this.rulerPointSize, paintline);

    Paint paintForeground = new Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left));
    builder.pushStyle(ui.TextStyle(
        background: paintForeground,
        color: Colors.black,
        fontSize: this.fontSize));
    builder.addText(len.toString());
    final paragraph = builder.build();
    double paragraphsize = 150 * this.ratio;
    paragraph.layout(new ui.ParagraphConstraints(width: paragraphsize));

    Offset textPosition = new Offset(sp.dx - rulerHeightMargin, sp.dy);
    this.iCanvas.drawParagraph(paragraph, textPosition);
  }
}
