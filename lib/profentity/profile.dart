import 'dart:convert';

class Profile {
  final String code;
  final String name;
  final String type; //frame,sash,mullion,door
  final double height;
  final double topwidth;
  final double width;

  Profile({
    required this.code,
    required this.name,
    required this.type,
    required this.height,
    required this.topwidth,
    required this.width,
  });

  Map<String, dynamic> toMap() {
    return {
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
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(code: $code, name: $name, type: $type, height: $height, topwidth: $topwidth, width: $width)';
  }
}
