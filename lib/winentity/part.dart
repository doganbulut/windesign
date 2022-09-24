import 'dart:convert';
import 'dart:math' as math;
import 'package:windesign/accessoryentity/accessory.dart';
import 'package:windesign/profentity/profile.dart';

class Part {
  String profileCode;
  double leftAngle;
  double rightAngle;
  double len;
  double inlen;
  double cutlen;
  double leftEar;
  double rightEar;
  Profile profile;
  List<Accessory> accessories;
  Part({
    this.profileCode,
    this.leftAngle,
    this.rightAngle,
    this.len,
    this.inlen,
    this.cutlen,
    this.leftEar,
    this.rightEar,
    this.profile,
    this.accessories,
  });

  Part.create(
      double leftAngle, double rightAngle, double len, Profile profile) {
    this.profileCode = profile.code;
    this.leftAngle = leftAngle;
    this.rightAngle = rightAngle;
    this.len = len;
    this.profile = profile;
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
    double mod = math.pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Part copyWith({
    String profileCode,
    double leftAngle,
    double rightAngle,
    double len,
    double inlen,
    double cutlen,
    double leftEar,
    double rightEar,
    Profile profile,
    List<Accessory> accessories,
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
      'profile': profile?.toMap(),
      'accessories': accessories?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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
