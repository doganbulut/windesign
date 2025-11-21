import 'dart:convert';

import 'package:windesign/profentity/profile.dart';

import 'cellunit.dart';
import 'part.dart';

class Sashcell {
  late String name;
  late Profile profile;
  late Part left;
  late Part right;
  late Part top;
  late Part bottom;
  late double sashHeight;
  late double sashWidth;
  late double sashMargin;
  late String openDirection;
  late CellUnit unit;
  Sashcell({
    required this.name,
    required this.profile,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.sashHeight,
    required this.sashWidth,
    required this.sashMargin,
    required this.openDirection,
    required this.unit,
  });

  Sashcell.create(
      String name,
      String openDirection,
      Profile profile,
      double sashMargin,
      String unitType,
      String typeName,
      double cellHeight,
      double cellWidth,
      double unitPrice) {
    this.name = name;
    this.openDirection = openDirection;
    this.profile = profile;
    this.sashMargin = sashMargin;
    this.sashHeight = cellHeight + (2 * this.sashMargin);
    this.sashWidth = cellWidth + (2 * this.sashMargin);
    this.left = new Part.create(45, 135, this.sashHeight, profile);
    this.right = new Part.create(45, 135, this.sashHeight, profile);
    this.top = new Part.create(45, 135, this.sashWidth, profile);
    this.bottom = new Part.create(45, 135, this.sashWidth, profile);

    unit = new CellUnit.create(unitType, typeName, this.name + "_unit",
        this.left.inlen, this.top.inlen, unitPrice);
  }

  @override
  String toString() {
    return "Kanat: " +
        this.name +
        " sashHeight: " +
        this.sashHeight.toString() +
        " sashWidth:" +
        this.sashWidth.toString() +
        " L: " +
        left.toString() +
        ' R: ' +
        right.toString() +
        " T: " +
        top.toString() +
        " B:" +
        bottom.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile': profile.toJson(),
      'left': left.toMap(),
      'right': right.toMap(),
      'top': top.toMap(),
      'bottom': bottom.toMap(),
      'sashHeight': sashHeight,
      'sashWidth': sashWidth,
      'sashMargin': sashMargin,
      'openDirection': openDirection,
      'unit': unit.toMap(),
    };
  }

  factory Sashcell.fromMap(Map<String, dynamic> map) {
    return Sashcell(
      name: map['name'],
      profile: Profile.fromJson(map['profile']),
      left: Part.fromMap(map['left']),
      right: Part.fromMap(map['right']),
      top: Part.fromMap(map['top']),
      bottom: Part.fromMap(map['bottom']),
      sashHeight: map['sashHeight'],
      sashWidth: map['sashWidth'],
      sashMargin: map['sashMargin'],
      openDirection: map['openDirection'],
      unit: CellUnit.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sashcell.fromJson(String source) =>
      Sashcell.fromMap(json.decode(source));
}
