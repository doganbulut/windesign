import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:windesign/profentity/profile.dart';
import 'part.dart';
import 'wincell.dart';

class PWindow {
  int order;
  int count;
  double width;
  double height;
  String? info1;
  String? info2;
  String? info3;
  String? info4;
  String? info5;
  String? info6;
  String? info7;
  Wincell frame;
  String? addtype;
  Offset? start;

  PWindow({
    required this.order,
    required this.count,
    required this.width,
    required this.height,
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    this.info6,
    this.info7,
    required this.frame,
    this.addtype,
    this.start,
  });

  factory PWindow.create(
      int order, int count, Profile frameProfile, double width, double height) {
    Wincell frame = Wincell.create('1');
    //left
    frame.left = Part.create(
        leftAngle: 45, rightAngle: 135, len: height, profile: frameProfile);
    //right
    frame.right = Part.create(
        leftAngle: 45, rightAngle: 135, len: height, profile: frameProfile);
    //top
    frame.top = Part.create(
        leftAngle: 45, rightAngle: 135, len: width, profile: frameProfile);
    //bottom
    frame.bottom = Part.create(
        leftAngle: 45, rightAngle: 135, len: width, profile: frameProfile);

    frame.inHeight = frame.left!.inlen;
    frame.inWidth = frame.top!.inlen;
    frame.xPoint = frame.top!.leftEar;
    frame.yPoint = frame.left!.leftEar;

    return PWindow(
      order: order,
      count: count,
      width: width,
      height: height,
      frame: frame,
    );
  }

  bool calculateWinParts() {
    try {
      frame.left!.len = this.height;
      frame.right!.len = this.height;
      frame.top!.len = this.width;
      frame.bottom!.len = this.width;

      frame.inHeight = frame.left!.inlen;
      frame.inWidth = frame.top!.inlen;
      frame.xPoint = frame.top!.leftEar;
      frame.yPoint = frame.left!.leftEar;

      return true;
    } catch (e) {
      return false;
    }
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
      'frame': frame.toMap(),
      'addtype': addtype,
      'start': start != null ? '${start!.dx}:${start!.dy}' : null,
    };
  }

  factory PWindow.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    if (map['frame'] == null) {
      throw ArgumentError("Frame cannot be null");
    }

    Offset? start;
    if (map['start'] != null) {
      var offsets = map['start'].toString().split(':');
      start = Offset(double.parse(offsets[0]), double.parse(offsets[1]));
    }

    return PWindow(
      order: map['order'] ?? 0,
      count: map['count'] ?? 0,
      width: map['width'] ?? 0.0,
      height: map['height'] ?? 0.0,
      info1: map['info1'],
      info2: map['info2'],
      info3: map['info3'],
      info4: map['info4'],
      info5: map['info5'],
      info6: map['info6'],
      info7: map['info7'],
      frame: Wincell.fromMap(map['frame']),
      addtype: map['addtype'],
      start: start,
    );
  }

  String toJson() => json.encode(toMap());

  factory PWindow.fromJson(String source) =>
      PWindow.fromMap(json.decode(source));
}
