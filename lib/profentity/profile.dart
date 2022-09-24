import 'dart:convert';

class Profile {
  String code;
  String name;
  String type; //frame,sash,mullion,door
  double height;
  double topwidth;
  double width;
  Profile({
    this.code,
    this.name,
    this.type,
    this.height,
    this.topwidth,
    this.width,
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
    if (map == null) return null;

    return Profile(
      code: map['code'],
      name: map['name'],
      type: map['type'],
      height: map['height'].toDouble(),
      topwidth: map['topwidth'].toDouble(),
      width: map['width'].toDouble(),
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
