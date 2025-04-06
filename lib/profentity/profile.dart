import 'dart:convert';

enum ProfileType { frame, sash, mullion, door, unknown }

class Profile {
  final String code;
  final String name;
  final ProfileType type;
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

  Profile copyWith({
    String? code,
    String? name,
    ProfileType? type,
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
    return {
      'code': code,
      'name': name,
      'type': type.toString().split('.').last,
      'height': height,
      'topwidth': topwidth,
      'width': width,
    };
  }

  factory Profile.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    return Profile(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      type: _parseProfileType(map['type']),
      height: map['height']?.toDouble() ?? 0.0,
      topwidth: map['topwidth']?.toDouble() ?? 0.0,
      width: map['width']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(code: $code, name: $name, type: $type, height: $height, topwidth: $topwidth, width: $width)';
  }

  static ProfileType _parseProfileType(String? profileString) {
    if (profileString == null) return ProfileType.unknown;
    switch (profileString.toLowerCase()) {
      case 'frame':
        return ProfileType.frame;
      case 'sash':
        return ProfileType.sash;
      case 'mullion':
        return ProfileType.mullion;
      case 'door':
        return ProfileType.door;
      default:
        return ProfileType.unknown;
    }
  }
}
