import 'dart:convert';

class CellUnit {
  String name;
  String type;
  String typeName;
  double unitprice;
  double unitHeight;
  double unitWidth;
  CellUnit({
    this.name,
    this.type,
    this.typeName,
    this.unitprice,
    this.unitHeight,
    this.unitWidth,
  });

  CellUnit.create(String type, String typeName, String name, double cellHeight,
      double cellWidth, double price) {
    this.type = type;
    this.typeName = typeName;
    this.name = name;
    this.unitHeight = cellHeight - 10;
    this.unitWidth = cellWidth - 10;
    this.unitprice = (unitHeight * unitWidth) * price;
  }

  @override
  String toString() {
    return "Panel/Cam: " +
        this.type +
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
      'type': type,
      'typeName': typeName,
      'unitprice': unitprice,
      'unitHeight': unitHeight,
      'unitWidth': unitWidth,
    };
  }

  factory CellUnit.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CellUnit(
      name: map['name'],
      type: map['type'],
      typeName: map['typeName'],
      unitprice: map['unitprice'],
      unitHeight: map['unitHeight'],
      unitWidth: map['unitWidth'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CellUnit.fromJson(String source) =>
      CellUnit.fromMap(json.decode(source));
}
