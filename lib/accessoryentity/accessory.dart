import 'dart:convert';

class Accessory {
  final String code;
  final String name;
  final String type;

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
    return {
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
      Accessory.fromMap(json.decode(source));

  @override
  String toString() => 'Accessory(code: $code, name: $name, type: $type)';
}
