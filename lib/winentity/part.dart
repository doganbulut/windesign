// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math' as math;

import 'package:windesign/accessoryentity/accessory.dart';
import 'package:windesign/profentity/profile.dart';

class Part {
  late String profileCode;
  late double leftAngle;
  late double rightAngle;
  late double len;
  late double inlen;
  late double cutlen;
  late double leftEar;
  late double rightEar;
  late Profile profile;
  late List<Accessory> accessories;
  Part({
    required this.profileCode,
    required this.leftAngle,
    required this.rightAngle,
    required this.len,
    required this.inlen,
    required this.cutlen,
    required this.leftEar,
    required this.rightEar,
    required this.profile,
    required this.accessories,
  });

  Part.create(
      double leftAngle, double rightAngle, double len, Profile profile) {
    this.profileCode = profile.code;
    this.leftAngle = leftAngle;
    this.rightAngle = rightAngle;
    this.len = len;
    this.profile = profile;
    this.accessories = [];
    this.cutlen = 0;
    calculateInLen();
  }

  calculateInLen() {
    this.leftEar = 0;
    this.rightEar = 0;

    if (leftAngle != 90)
      leftEar = getear(leftAngle);
    else
      leftEar = 0;

    if (rightAngle != 90)
      rightEar = getear(rightAngle);
    else
      rightEar = 0;

    inlen = len - (leftEar + rightEar);
  }

  calculateCutLen(double weldMargin) {
    cutlen = len + weldMargin;
  }

  double getear(double degree) {
    return round(
        math.tan((math.pi * degree) / 180).abs() * this.profile.width, 2);
  }

  double round(double value, int places) {
    num mod = math.pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Map<String, dynamic> toMap() {
    return {
      'profileCode': profileCode,
      'leftAngle': leftAngle,
      'rightAngle': rightAngle,
      'len': len,
      'inlen': inlen,
      'cutlen': cutlen,
      'leftEar': leftEar,
      'rightEar': rightEar,
      'profile': profile.toMap(),
      'accessories': accessories.map((x) => x.toMap()).toList(),
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      profileCode: map['profileCode'],
      leftAngle: map['leftAngle'],
      rightAngle: map['rightAngle'],
      len: map['len'],
      inlen: map['inlen'],
      cutlen: map['cutlen'],
      leftEar: map['leftEar'],
      rightEar: map['rightEar'],
      profile: Profile.fromMap(map['profile']),
      accessories: List<Accessory>.from(
          map['accessories']?.map((x) => Accessory.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Part(profileCode: $profileCode, leftAngle: $leftAngle, rightAngle: $rightAngle, len: $len, inlen: $inlen, cutlen: $cutlen, leftEar: $leftEar, rightEar: $rightEar, profile: $profile, accessories: $accessories)';
  }
}
