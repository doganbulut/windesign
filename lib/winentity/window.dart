import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:windesign/profentity/profile.dart';
import 'part.dart';
import 'wincell.dart';

class PWindow {
  late int order;
  late int count;
  late double width;
  late double height;
  String? info1;
  String? info2;
  String? info3;
  String? info4;
  String? info5;
  String? info6;
  String? info7;
  late Wincell frame;
  late String addtype;
  late Offset start;
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
    required this.addtype,
    required this.start,
  });

  PWindow.create(
      int order, int count, Profile frameProfile, double width, double height) {
    this.order = order;
    this.count = count;
    this.width = width;
    this.height = height;
    this.addtype = "";
    this.start = Offset.zero;

    frame = new Wincell.create('1');
    //left
    frame.left = new Part.create(45, 135, this.height, frameProfile);
    //right
    frame.right = new Part.create(45, 135, this.height, frameProfile);
    //top
    frame.top = new Part.create(45, 135, this.width, frameProfile);
    //bottom
    frame.bottom = new Part.create(45, 135, this.width, frameProfile);

    frame.inHeight = frame.left.inlen;
    frame.inWidth = frame.top.inlen;
    frame.xPoint = frame.top.leftEar;
    frame.yPoint = frame.left.leftEar;
  }

  bool calculateWinParts() {
    try {
      frame.left.len = this.height;
      frame.left.calculateInLen();
      frame.right.len = this.height;
      frame.right.calculateInLen();
      frame.top.len = this.width;
      frame.top.calculateInLen();
      frame.bottom.len = this.width;
      frame.bottom.calculateInLen();

      frame.inHeight = frame.left.inlen;
      frame.inWidth = frame.top.inlen;
      frame.xPoint = frame.top.leftEar;
      frame.yPoint = frame.left.leftEar;

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
      'start': start.dx.toString() + ':' + start.dy.toString(),
    };
  }

  factory PWindow.fromMap(Map<String, dynamic> map) {
    var offsets = map['start'].toString().split(':');

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
      start: new Offset(double.parse(offsets[0]), double.parse(offsets[1])),
    );
  }

  String toJson() => json.encode(toMap());

  factory PWindow.fromJson(String source) =>
      PWindow.fromMap(json.decode(source));
}
