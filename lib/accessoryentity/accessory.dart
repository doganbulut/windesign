import 'dart:convert';

class Accessory {
  String code;
  String name;
  String type;
  String parent; //sash,frame,win

  Accessory({
    required this.code,
    required this.name,
    required this.type,
    required this.parent,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'type': type,
    };
  }

  factory Accessory.fromMap(Map<String, dynamic> map) {
    return Accessory(
      code: map['code'],
      name: map['name'],
      type: map['type'],
      parent: map['parent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessory.fromJson(String source) =>
      Accessory.fromMap(json.decode(source));

  @override
  String toString() => 'Accessory(code: $code, name: $name, type: $type)';
}
