import 'dart:convert';

import 'package:windesign/profentity/profile.dart';

import 'cellunit.dart';
import 'part.dart';

class Sashcell {
  String name;
  Profile profile;
  Part left;
  Part right;
  Part top;
  Part bottom;
  double sashHeight;
  double sashWidth;
  double sashMargin;
  String openDirection;
  CellUnit unit;

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
        left = Part.create(45, 135, cellHeight + (2 * sashMargin), profile),
        right = Part.create(45, 135, cellHeight + (2 * sashMargin), profile),
        top = Part.create(45, 135, cellWidth + (2 * sashMargin), profile),
        bottom = Part.create(45, 135, cellWidth + (2 * sashMargin), profile),
        unit = CellUnit.create(
          unitType,
          typeName,
          "${name}_unit",
          cellHeight + (2 * sashMargin),
          cellWidth + (2 * sashMargin),
          unitPrice,
        );

  @override
  String toString() {
    return "Kanat: $name sashHeight: $sashHeight sashWidth: $sashWidth L: $left R: $right T: $top B: $bottom";
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
      name: map['name'] as String,
      profile: Profile.fromJson(map['profile'] as String),
      left: Part.fromMap(map['left'] as Map<String, dynamic>),
      right: Part.fromMap(map['right'] as Map<String, dynamic>),
      top: Part.fromMap(map['top'] as Map<String, dynamic>),
      bottom: Part.fromMap(map['bottom'] as Map<String, dynamic>),
      sashHeight: map['sashHeight'] as double,
      sashWidth: map['sashWidth'] as double,
      sashMargin: map['sashMargin'] as double,
      openDirection: map['openDirection'] as String,
      unit: CellUnit.fromMap(map['unit'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sashcell.fromJson(String source) =>
      Sashcell.fromMap(json.decode(source) as Map<String, dynamic>);
}
