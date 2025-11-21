// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  String code;
  String name;
  String type; //frame,sash,mullion,door
  double height;
  double topwidth;
  double width;
  Profile({
    required this.code,
    required this.name,
    required this.type,
    required this.height,
    required this.topwidth,
    required this.width,
  });

  Profile copyWith({
    String? code,
    String? name,
    String? type,
    double? height,
    double? topwidth,
    double? width,
  }) {
    return Profile(
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      height: height ?? this.height,
      topwidth: topwidth ?? this.topwidth,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'type': type,
      'height': height,
      'topwidth': topwidth,
      'width': width,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      code: map['code'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      height: map['height'] as double,
      topwidth: map['topwidth'] as double,
      width: map['width'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(code: $code, name: $name, type: $type, height: $height, topwidth: $topwidth, width: $width)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.name == name &&
        other.type == type &&
        other.height == height &&
        other.topwidth == topwidth &&
        other.width == width;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        type.hashCode ^
        height.hashCode ^
        topwidth.hashCode ^
        width.hashCode;
  }
}
