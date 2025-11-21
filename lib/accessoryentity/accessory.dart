// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Accessory {
  String code;
  String name;
  String type;
  Accessory({
    required this.code,
    required this.name,
    required this.type,
  });

  Accessory copyWith({
    String? code,
    String? name,
    String? type,
  }) {
    return Accessory(
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'type': type,
    };
  }

  factory Accessory.fromMap(Map<String, dynamic> map) {
    return Accessory(
      code: map['code'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessory.fromJson(String source) =>
      Accessory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Accessory(code: $code, name: $name, type: $type)';

  @override
  bool operator ==(covariant Accessory other) {
    if (identical(this, other)) return true;

    return other.code == code && other.name == name && other.type == type;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ type.hashCode;
}
