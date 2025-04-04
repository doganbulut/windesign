import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:windesign/profentity/profile.dart';
import 'part.dart';
import 'wincell.dart';

class PWindow {
  static const double defaultPartAngle1 = 45.0;
  static const double defaultPartAngle2 = 135.0;

  int? order;
  int? count;
  double? width;
  double? height;
  String? info1;
  String? info2;
  String? info3;
  String? info4;
  String? info5;
  String? info6;
  String? info7;
  Wincell? frame;
  String? addtype;
  Offset? start;

  PWindow({
    this.order,
    this.count,
    this.width,
    this.height,
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    this.info6,
    this.info7,
    this.addtype,
    this.start,
    this.frame,
  });

  PWindow.create(
      int order, int count, Profile frameProfile, double width, double height) {
    this.order = order;
    this.count = count;
    this.width = width;
    this.height = height;
    addtype = "";
    start = Offset.zero;

    // Create frame parts
    frame = Wincell(
        id: "0",
        left: _createFramePart(frameProfile, this.height ?? 0),
        right: _createFramePart(frameProfile, this.height ?? 0),
        top: _createFramePart(frameProfile, this.width ?? 0),
        bottom: _createFramePart(frameProfile, this.width ?? 0),
        xPoint: 0,
        yPoint: 0,
        innerWidth: 0,
        innerHeight: 0);

    _calculateFrameDimensions();
  }

  Part _createFramePart(Profile profile, double length) {
    return Part.create(defaultPartAngle1, defaultPartAngle2, length, profile);
  }

  void _calculateFrameDimensions() {
    frame?.innerHeight = frame!.left.inlen;
    frame?.innerWidth = frame!.top.inlen;
    frame?.xPoint = frame!.top.leftEar;
    frame?.yPoint = frame!.left.leftEar;
  }

  bool calculateWinParts() {
    frame?.left.len = height!;
    frame?.left.calculateInLen();
    frame?.right.len = height!;
    frame?.right.calculateInLen();
    frame?.top.len = width!;
    frame?.top.calculateInLen();
    frame?.bottom.len = width!;
    frame?.bottom.calculateInLen();

    _calculateFrameDimensions();

    return true;
  }

  Map<String, dynamic> toMap() {
    return {
      'order': order,
      'count': count,
      'width': width,
      'height': height,
      'info1': info1,
      'info2': info2,
      'info3': info3,
      'info4': info4,
      'info5': info5,
      'info6': info6,
      'info7': info7,
      'frame': frame?.toMap(),
      'addtype': addtype,
      'start': '${start?.dx}:${start?.dy}',
    };
  }

  factory PWindow.fromMap(Map<String, dynamic> map) {
    final String? startString = map['start']?.toString();
    Offset? startOffset;
    if (startString != null) {
      final List<String> offsets = startString.split(':');
      if (offsets.length == 2) {
        startOffset =
            Offset(double.parse(offsets[0]), double.parse(offsets[1]));
      }
    }

    return PWindow(
      order: map['order'],
      count: map['count'],
      width: map['width'],
      height: map['height'],
      info1: map['info1'],
      info2: map['info2'],
      info3: map['info3'],
      info4: map['info4'],
      info5: map['info5'],
      info6: map['info6'],
      info7: map['info7'],
      frame: Wincell.fromMap(map['frame']),
      addtype: map['addtype'],
      start: startOffset,
    );
  }

  String toJson() => json.encode(toMap());

  factory PWindow.fromJson(String source) =>
      PWindow.fromMap(json.decode(source));
}
