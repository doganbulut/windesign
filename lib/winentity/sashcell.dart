import 'dart:convert';
import 'package:windesign/profentity/profile.dart';
import 'cellunit.dart';
import 'part.dart';

enum OpenDirection { left, right, top, bottom, unknown }

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
  OpenDirection openDirection;
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

  factory Sashcell.create({
    required String sashname,
    required String openDirection,
    required Profile profile,
    required double sashMargin,
    required String unitType,
    required String unitName,
    required double cellHeight,
    required double cellWidth,
    required double unitPrice,
  }) {
    double sashHeight = cellHeight + (2 * sashMargin);
    double sashWidth = cellWidth + (2 * sashMargin);
    Part left = Part.create(
        leftAngle: 45, rightAngle: 135, len: sashHeight, profile: profile);
    Part right = Part.create(
        leftAngle: 45, rightAngle: 135, len: sashHeight, profile: profile);
    Part top = Part.create(
        leftAngle: 45, rightAngle: 135, len: sashWidth, profile: profile);
    Part bottom = Part.create(
        leftAngle: 45, rightAngle: 135, len: sashWidth, profile: profile);

    CellUnit unit = CellUnit.create(
        type: _parseCellUnitType(unitType),
        typeName: unitName,
        name: sashname + "_unit",
        cellHeight: left.inlen,
        cellWidth: top.inlen,
        price: unitPrice);

    return Sashcell(
      name: sashname,
      openDirection: _parseOpenDirection(openDirection),
      profile: profile,
      sashMargin: sashMargin,
      sashHeight: sashHeight,
      sashWidth: sashWidth,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      unit: unit,
    );
  }

  Sashcell copyWith({
    String? name,
    Profile? profile,
    Part? left,
    Part? right,
    Part? top,
    Part? bottom,
    double? sashHeight,
    double? sashWidth,
    double? sashMargin,
    OpenDirection? openDirection,
    CellUnit? unit,
  }) {
    return Sashcell(
      name: name ?? this.name,
      profile: profile ?? this.profile,
      left: left ?? this.left,
      right: right ?? this.right,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      sashHeight: sashHeight ?? this.sashHeight,
      sashWidth: sashWidth ?? this.sashWidth,
      sashMargin: sashMargin ?? this.sashMargin,
      openDirection: openDirection ?? this.openDirection,
      unit: unit ?? this.unit,
    );
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
      'profile': profile.toMap(),
      'left': left.toMap(),
      'right': right.toMap(),
      'top': top.toMap(),
      'bottom': bottom.toMap(),
      'sashHeight': sashHeight,
      'sashWidth': sashWidth,
      'sashMargin': sashMargin,
      'openDirection': openDirection.toString().split('.').last,
      'unit': unit.toMap(),
    };
  }

  factory Sashcell.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    return Sashcell(
      name: map['name'] ?? '',
      profile: Profile.fromMap(map['profile']),
      left: Part.fromMap(map['left']),
      right: Part.fromMap(map['right']),
      top: Part.fromMap(map['top']),
      bottom: Part.fromMap(map['bottom']),
      sashHeight: map['sashHeight'] ?? 0.0,
      sashWidth: map['sashWidth'] ?? 0.0,
      sashMargin: map['sashMargin'] ?? 0.0,
      openDirection: _parseOpenDirection(map['openDirection']),
      unit: CellUnit.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sashcell.fromJson(String source) =>
      Sashcell.fromMap(json.decode(source));

  static OpenDirection _parseOpenDirection(String? openDirectionString) {
    if (openDirectionString == null) return OpenDirection.unknown;
    switch (openDirectionString.toLowerCase()) {
      case 'left':
        return OpenDirection.left;
      case 'right':
        return OpenDirection.right;
      case 'top':
        return OpenDirection.top;
      case 'bottom':
        return OpenDirection.bottom;
      default:
        return OpenDirection.unknown;
    }
  }

  static CellUnitType _parseCellUnitType(String cellUnitString) {
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
