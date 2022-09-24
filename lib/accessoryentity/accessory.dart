import 'dart:convert';

class Accessory {
  String code;
  String name;
  String type;
  Accessory({
    this.code,
    this.name,
    this.type,
  });
  String parent; //sash,frame,win

  Accessory copyWith({
    String code,
    String name,
    String type,
  }) {
    return Accessory(
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'type': type,
    };
  }

  factory Accessory.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Accessory(
      code: map['code'],
      name: map['name'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessory.fromJson(String source) =>
      Accessory.fromMap(json.decode(source));

  @override
  String toString() => 'Accessory(code: $code, name: $name, type: $type)';
}
