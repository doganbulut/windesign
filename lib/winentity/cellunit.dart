import 'dart:convert';

enum CellUnitType { panel, cam, unknown }

class CellUnit {
  final String name;
  final CellUnitType type;
  final String typeName;
  final double unitprice;
  final double unitHeight;
  final double unitWidth;

  CellUnit({
    required this.name,
    required this.type,
    required this.typeName,
    required this.unitprice,
    required this.unitHeight,
    required this.unitWidth,
  });

  factory CellUnit.create({
    required CellUnitType type,
    required String typeName,
    required String name,
    required double cellHeight,
    required double cellWidth,
    required double price,
  }) {
    double unitHeight = cellHeight - 10;
    double unitWidth = cellWidth - 10;
    double unitprice = (unitHeight * unitWidth) * price;
    return CellUnit(
      name: name,
      type: type,
      typeName: typeName,
      unitprice: unitprice,
      unitHeight: unitHeight,
      unitWidth: unitWidth,
    );
  }

  CellUnit copyWith({
    String? name,
    CellUnitType? type,
    String? typeName,
    double? unitprice,
    double? unitHeight,
    double? unitWidth,
  }) {
    return CellUnit(
      name: name ?? this.name,
      type: type ?? this.type,
      typeName: typeName ?? this.typeName,
      unitprice: unitprice ?? this.unitprice,
      unitHeight: unitHeight ?? this.unitHeight,
      unitWidth: unitWidth ?? this.unitWidth,
    );
  }

  @override
  String toString() {
    return "Panel/Cam: " +
        this.type.toString().split('.').last +
        " typeName: " +
        this.typeName +
        " name: " +
        this.name +
        " unitHeight: " +
        this.unitHeight.toString() +
        " unitWidth: " +
        this.unitWidth.toString() +
        " unitprice: " +
        this.unitprice.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'typeName': typeName,
      'unitprice': unitprice,
      'unitHeight': unitHeight,
      'unitWidth': unitWidth,
    };
  }

  factory CellUnit.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    return CellUnit(
      name: map['name'] ?? '',
      type: _parseCellUnitType(map['type']),
      typeName: map['typeName'] ?? '',
      unitprice: map['unitprice'] ?? 0.0,
      unitHeight: map['unitHeight'] ?? 0.0,
      unitWidth: map['unitWidth'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CellUnit.fromJson(String source) =>
      CellUnit.fromMap(json.decode(source));

  static CellUnitType _parseCellUnitType(String? cellUnitString) {
    if (cellUnitString == null) return CellUnitType.unknown;
    switch (cellUnitString.toLowerCase()) {
      case 'panel':
        return CellUnitType.panel;
      case 'cam':
        return CellUnitType.cam;
      default:
        return CellUnitType.unknown;
    }
  }
}
