//in windowobject.dart
import 'dart:convert';
import 'dart:ui';
import 'package:windesign/profentity/profile.dart';
import 'part.dart';
import 'wincell.dart';

class WindowObject {
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
  Wincell? frame;
  String? addtype;
  Offset start;
  Profile frameProfile;

  WindowObject({
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
    required this.frameProfile,
    this.addtype = "", // Provide default value
    required this.start,
    Wincell? frame, // Add frame as a named parameter
  }) : frame = Wincell(
            id: "1", mullions: [], cells: [], tmpSash: [], tmpUnits: []) {
    // Initialize frame parts only if frame is newly created
    if (frame == null) {
      try {
        //left
        this.frame!.left = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: this.height,
            profile: frameProfile);
        //right
        this.frame!.right = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: this.height,
            profile: frameProfile);
        //top
        this.frame!.top = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: this.width,
            profile: frameProfile);
        //bottom
        this.frame!.bottom = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: this.width,
            profile: frameProfile);

        this.frame!.inHeight = this.frame!.left!.inlen;
        this.frame!.inWidth = this.frame!.top!.inlen;
        this.frame!.xPoint = this.frame!.top!.leftEar;
        this.frame!.yPoint = this.frame!.left!.leftEar;
      } catch (e) {
        print('Error in WindowObject.create: $e');
      }
    }
  }

  bool calculateWinParts() {
    try {
      frame!.left!.calculateInLen();
      frame!.right!.calculateInLen();
      frame!.top!.calculateInLen();
      frame!.bottom!.calculateInLen();

      frame!.inHeight = frame!.left!.inlen;
      frame!.inWidth = frame!.top!.inlen;
      frame!.xPoint = frame!.top!.leftEar;
      frame!.yPoint = frame!.left!.leftEar;

      return true;
    } catch (e) {
      print('Error in calculateWinParts: $e');
      return false;
    }
  }

  Map<String, dynamic> toMap() {
    try {
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
        'frame': frame!.toMap(),
        'addtype': addtype,
        'start': "${start.dx}:${start.dy}",
        'frameProfile': frameProfile.toMap(),
      };
    } catch (e) {
      print('Error in toMap: $e');
      return {};
    }
  }

  factory WindowObject.fromMap(Map<String, dynamic> map) {
    final offsets = map['start'].toString().split(':');

    return WindowObject(
      order: map['order'] as int,
      count: map['count'] as int,
      width: map['width'] as double,
      height: map['height'] as double,
      info1: map['info1'] as String?,
      info2: map['info2'] as String?,
      info3: map['info3'] as String?,
      info4: map['info4'] as String?,
      info5: map['info5'] as String?,
      info6: map['info6'] as String?,
      info7: map['info7'] as String?,
      frame: map['frame'] != null
          ? Wincell.fromMap(map['frame'])
          : null, // Handle null frame
      addtype: map['addtype'] as String?,
      start: Offset(double.parse(offsets[0]), double.parse(offsets[1])),
      frameProfile: Profile.fromMap(map['frameProfile']),
    );
  }

  String toJson() {
    try {
      return json.encode(toMap());
    } catch (e) {
      print('Error in toJson: $e');
      return "";
    }
  }

  factory WindowObject.fromJson(String source) {
    return WindowObject.fromMap(json.decode(source));
  }
}
