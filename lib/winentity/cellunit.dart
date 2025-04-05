import 'dart:convert';

class CellUnit {
  final String id;
  final String type;
  final String typeName;
  final double unitprice;
  final double unitHeight;
  final double unitWidth;

  CellUnit({
    required this.id,
    required this.type,
    required this.typeName,
    required this.unitprice,
    required this.unitHeight,
    required this.unitWidth,
  });

  @override
  String toString() {
    return 'CellUnit { '
        'type: $type, '
        'typeName: $typeName, '
        'name: $id, '
        'unitHeight: $unitHeight, '
        'unitWidth: $unitWidth, '
        'unitprice: $unitprice '
        '}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': id,
      'type': type,
      'typeName': typeName,
      'unitprice': unitprice,
      'unitHeight': unitHeight,
      'unitWidth': unitWidth,
    };
  }

  factory CellUnit.fromMap(Map<String, dynamic> map) {
    return CellUnit(
      id: map['name'] as String,
      type: map['type'] as String,
      typeName: map['typeName'] as String,
      unitprice: map['unitprice'] as double,
      unitHeight: map['unitHeight'] as double,
      unitWidth: map['unitWidth'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CellUnit.fromJson(String source) =>
      CellUnit.fromMap(json.decode(source));
}
