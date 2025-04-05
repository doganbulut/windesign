import 'dart:convert';

import 'package:windesign/profentity/profile.dart';
import 'package:windesign/winentity/part.dart';

import 'cellunit.dart';

class Sashcell {
  final String name;
  final Profile profile;
  final Part left;
  final Part right;
  final Part top;
  final Part bottom;
  final double sashHeight;
  final double sashWidth;
  final double sashMargin;
  final String openDirection;
  final CellUnit unit;

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

  Sashcell.create({
    required String name,
    required String openDirection,
    required Profile profile,
    required double sashMargin,
    required String unitType,
    required String typeName,
    required double cellHeight,
    required double cellWidth,
    required double unitPrice,
  })  : name = name,
        openDirection = openDirection,
        profile = profile,
        sashMargin = sashMargin,
        sashHeight = cellHeight + (2 * sashMargin),
        sashWidth = cellWidth + (2 * sashMargin),
        left = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: cellHeight + (2 * sashMargin),
            profile: profile),
        right = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: cellHeight + (2 * sashMargin),
            profile: profile),
        top = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: cellWidth + (2 * sashMargin),
            profile: profile),
        bottom = Part.create(
            leftAngle: 45,
            rightAngle: 135,
            len: cellWidth + (2 * sashMargin),
            profile: profile),
        unit = CellUnit(
            id: name + "_unit",
            type: unitType,
            typeName: typeName,
            unitprice: unitPrice,
            unitHeight: cellHeight,
            unitWidth: cellWidth);

  @override
  String toString() {
    return "Kanat: " +
        name +
        " sashHeight: " +
        sashHeight.toString() +
        " sashWidth:" +
        sashWidth.toString() +
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
      'profile': profile.toMap(),
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
      name: map['name'] as String,
      profile: Profile.fromMap(map['profile']),
      left: Part.fromMap(map['left']),
      right: Part.fromMap(map['right']),
      top: Part.fromMap(map['top']),
      bottom: Part.fromMap(map['bottom']),
      sashHeight: map['sashHeight'] as double,
      sashWidth: map['sashWidth'] as double,
      sashMargin: map['sashMargin'] as double,
      openDirection: map['openDirection'] as String,
      unit: CellUnit.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sashcell.fromJson(String source) =>
      Sashcell.fromMap(json.decode(source));
}
