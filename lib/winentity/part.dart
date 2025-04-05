import 'dart:convert';
import 'dart:math' as math;
import 'package:windesign/accessoryentity/accessory.dart';
import 'package:windesign/profentity/profile.dart';

class Part {
  final String profileCode;
  final double leftAngle;
  final double rightAngle;
  double? len;
  double inlen;
  double cutlen;
  double leftEar;
  double rightEar;
  final Profile profile;
  final List<Accessory> accessories;

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
    List<Accessory>? accessories,
  }) : this.accessories = accessories ?? [];

  Part.create(
      {required double leftAngle,
      required double rightAngle,
      required double? len,
      required Profile profile})
      : profileCode = profile.code,
        leftAngle = leftAngle,
        rightAngle = rightAngle,
        len = len,
        profile = profile,
        leftEar = 0,
        rightEar = 0,
        this.cutlen = 0,
        this.inlen = 0,
        accessories = [] {
    calculateInLen();
  }

  void calculateInLen() {
    leftEar = (leftAngle != 90) ? getear(leftAngle) : 0;
    rightEar = (rightAngle != 90) ? getear(rightAngle) : 0;
    inlen = (len! - (leftEar + rightEar));
  }

  void calculateCutLen(double weldMargin) {
    cutlen = (len! + weldMargin);
  }

  double getear(double degree) {
    return round(math.tan((math.pi * degree) / 180).abs() * profile.width, 2);
  }

  double round(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }

  Part copyWith({
    String? profileCode,
    double? leftAngle,
    double? rightAngle,
    double? len,
    double? inlen,
    double? cutlen,
    double? leftEar,
    double? rightEar,
    Profile? profile,
    List<Accessory>? accessories,
  }) {
    return Part(
      profileCode: profileCode ?? this.profileCode,
      leftAngle: leftAngle ?? this.leftAngle,
      rightAngle: rightAngle ?? this.rightAngle,
      len: len ?? this.len,
      inlen: inlen ?? this.inlen,
      cutlen: cutlen ?? this.cutlen,
      leftEar: leftEar ?? this.leftEar,
      rightEar: rightEar ?? this.rightEar,
      profile: profile ?? this.profile,
      accessories: accessories ?? this.accessories,
    );
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
      profileCode: map['profileCode'] as String,
      leftAngle: map['leftAngle'] as double,
      rightAngle: map['rightAngle'] as double,
      len: map['len'] as double,
      inlen: map['inlen'] as double,
      cutlen: map['cutlen'] as double,
      leftEar: map['leftEar'] as double,
      rightEar: map['rightEar'] as double,
      profile: Profile.fromMap(map['profile']),
      accessories: map['accessories'] != null
          ? List<Accessory>.from(
              (map['accessories'] as List).map((x) => Accessory.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Part(profileCode: $profileCode, leftAngle: $leftAngle, rightAngle: $rightAngle, len: $len, inlen: $inlen, cutlen: $cutlen, leftEar: $leftEar, rightEar: $rightEar, profile: $profile, accessories: $accessories)';
  }
}
