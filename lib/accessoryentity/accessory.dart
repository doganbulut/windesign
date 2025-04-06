import 'dart:convert';

enum AccessoryParentType { sash, frame, win, unknown }

class Accessory {
  final String code;
  final String name;
  final String type;
  final AccessoryParentType parent;

  Accessory({
    required this.code,
    required this.name,
    required this.type,
    this.parent = AccessoryParentType.unknown,
  });

  Accessory copyWith({
    String? code,
    String? name,
    String? type,
    AccessoryParentType? parent,
  }) {
    return Accessory(
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'type': type,
      'parent': parent.toString().split('.').last,
    };
  }

  factory Accessory.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      throw ArgumentError("Map cannot be empty");
    }

    return Accessory(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      parent: _parseParentType(map['parent']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessory.fromJson(String source) =>
      Accessory.fromMap(json.decode(source));

  @override
  String toString() =>
      'Accessory(code: $code, name: $name, type: $type, parent: $parent)';

  static AccessoryParentType _parseParentType(String? parentString) {
    if (parentString == null) return AccessoryParentType.unknown;
    switch (parentString.toLowerCase()) {
      case 'sash':
        return AccessoryParentType.sash;
      case 'frame':
        return AccessoryParentType.frame;
      case 'win':
        return AccessoryParentType.win;
      default:
        return AccessoryParentType.unknown;
    }
  }
}
