import 'dart:convert';

class PriceRow {
  final String code;
  final String name;
  final String type;
  final String unitof;
  final double unitprice;

  PriceRow({
    required this.code,
    required this.name,
    required this.type,
    required this.unitof,
    required this.unitprice,
  });

  PriceRow copyWith({
    String? code,
    String? name,
    String? type,
    String? unitof,
    double? unitprice,
  }) {
    return PriceRow(
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      unitof: unitof ?? this.unitof,
      unitprice: unitprice ?? this.unitprice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'type': type,
      'unitof': unitof,
      'unitprice': unitprice,
    };
  }

  factory PriceRow.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    return PriceRow(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      unitof: map['unitof'] ?? '',
      unitprice: map['unitprice'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceRow.fromJson(String source) =>
      PriceRow.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PriceRow(code: $code, name: $name, type: $type, unitof: $unitof, unitprice: $unitprice)';
  }
}
