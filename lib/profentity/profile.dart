import 'dart:convert';

class Profile {
  String code;
  String name;
  String type; //frame,sash,mullion,door
  double height;
  double width;
  double topwidth;
  Profile({
    required this.code,
    required this.name,
    required this.type,
    this.height = 0,
    this.width = 0,
    this.topwidth = 0,
  });

  // Static factory method to create a Profile
  static Profile create({
    required String code,
    required String name,
    required String type,
  }) {
    return Profile(code: code, name: name, type: type);
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'type': type,
      'height': height,
      'width': width,
      'topwidth': topwidth,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      height: (map['height'] ?? 0).toDouble(),
      width: (map['width'] ?? 0).toDouble(),
      topwidth: (map['topwidth'] ?? 0).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(code: $code, name: $name, type: $type, height: $height, width: $width, topwidth: $topwidth)';
  }
}
