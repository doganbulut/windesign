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

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'type': type,
      'unitof': unitof,
      'unitprice': unitprice,
    };
  }

  factory PriceRow.fromMap(Map<String, dynamic> map) {
    return PriceRow(
      code: map['code'],
      name: map['name'],
      type: map['type'],
      unitof: map['unitof'],
      unitprice: map['unitprice'],
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
