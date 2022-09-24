import 'dart:convert';

class PriceRow {
  String code;
  String name;
  String type;
  String unitof;
  double unitprice;
  PriceRow({
    this.code,
    this.name,
    this.type,
    this.unitof,
    this.unitprice,
  });

  PriceRow copyWith({
    String code,
    String name,
    String type,
    String unitof,
    double unitprice,
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

  factory PriceRow.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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
