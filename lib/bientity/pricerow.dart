// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PriceRow {
  String code;
  String name;
  String type;
  String unitof;
  double unitprice;
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
    return <String, dynamic>{
      'code': code,
      'name': name,
      'type': type,
      'unitof': unitof,
      'unitprice': unitprice,
    };
  }

  factory PriceRow.fromMap(Map<String, dynamic> map) {
    return PriceRow(
      code: map['code'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      unitof: map['unitof'] as String,
      unitprice: map['unitprice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceRow.fromJson(String source) =>
      PriceRow.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PriceRow(code: $code, name: $name, type: $type, unitof: $unitof, unitprice: $unitprice)';
  }

  @override
  bool operator ==(covariant PriceRow other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.name == name &&
        other.type == type &&
        other.unitof == unitof &&
        other.unitprice == unitprice;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        type.hashCode ^
        unitof.hashCode ^
        unitprice.hashCode;
  }
}
