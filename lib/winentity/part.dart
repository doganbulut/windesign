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
    required this.profileCode,
    required this.leftAngle,
    required this.rightAngle,
    required this.len,
    required this.profile,
    List<Accessory>? accessories,
  })  : accessories = accessories ?? [],
        leftEar = _getEar(leftAngle, profile.width),
        rightEar = _getEar(rightAngle, profile.width),
        inlen = len -
            (_getEar(leftAngle, profile.width) +
                _getEar(rightAngle, profile.width)),
        cutlen = len;

  Part.create(
      {required double leftAngle,
      required double rightAngle,
      required double len,
      required Profile profile})
      : this(
          profileCode: profile.code,
          leftAngle: leftAngle,
          rightAngle: rightAngle,
          len: len,
          profile: profile,
        );

  void calculateCutLen(double weldMargin) {
    // ignore: no_leading_underscores_for_local_identifiers
    double _cutlen = len + weldMargin;
    Part(
      profileCode: profileCode,
      leftAngle: leftAngle,
      rightAngle: rightAngle,
      len: len,
      profile: profile,
      accessories: accessories,
    ).copyWith(cutlen: _cutlen);
  }

  static double _getEar(double degree, double profileWidth) {
    if (degree == 90) return 0;
    return _round(math.tan((math.pi * degree) / 180).abs() * profileWidth, 2);
  }

  static double _round(double value, int places) {
    double mod = math.pow(10.0, places).toDouble(); // Explicitly cast to double
    return ((value * mod).round().toDouble() / mod);
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

  factory Part.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? accessoryMaps = map['accessories'];
    List<Accessory> accessories = [];
    if (accessoryMaps != null && accessoryMaps.isNotEmpty) {
      accessories = accessoryMaps.map((x) => Accessory.fromMap(x)).toList();
    }

    return Part(
      profileCode: map['profileCode'] ?? '',
      leftAngle: map['leftAngle'] ?? 0.0,
      rightAngle: map['rightAngle'] ?? 0.0,
      len: map['len'] ?? 0.0,
      profile: Profile.fromMap(map['profile']),
      accessories: accessories,
    );
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Part(profileCode: $profileCode, leftAngle: $leftAngle, rightAngle: $rightAngle, len: $len, inlen: $inlen, cutlen: $cutlen, leftEar: $leftEar, rightEar: $rightEar, profile: $profile, accessories: $accessories)';
  }
}
