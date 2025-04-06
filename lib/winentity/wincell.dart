import 'dart:convert';
import 'package:windesign/profentity/profile.dart';
import 'cellunit.dart';
import 'direction.dart';
import 'mullion .dart';
import 'part.dart';
import 'sashcell.dart';

class Wincell {
  String id;
  Part? left;
  Part? right;
  Part? top;
  Part? bottom;
  CellUnit? unit;
  Sashcell? sash;
  double? xPoint;
  double? yPoint;
  double? inWidth;
  double? inHeight;
  List<Mullion> mullions;
  List<Wincell> cells;
  List<Sashcell> _tmpSash;
  List<CellUnit> _tmpUnits;

  Wincell({
    required this.id,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.unit,
    this.sash,
    this.xPoint,
    this.yPoint,
    this.inWidth,
    this.inHeight,
    List<Mullion>? mullions,
    List<Wincell>? cells,
  })  : mullions = mullions ?? [],
        cells = cells ?? [],
        _tmpSash = [],
        _tmpUnits = [];

  factory Wincell.create(String id) {
    return Wincell(id: id);
  }

  Wincell copyWith({
    String? id,
    Part? left,
    Part? right,
    Part? top,
    Part? bottom,
    CellUnit? unit,
    Sashcell? sash,
    double? xPoint,
    double? yPoint,
    double? inWidth,
    double? inHeight,
    List<Mullion>? mullions,
    List<Wincell>? cells,
  }) {
    return Wincell(
      id: id ?? this.id,
      left: left ?? this.left,
      right: right ?? this.right,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      unit: unit ?? this.unit,
      sash: sash ?? this.sash,
      xPoint: xPoint ?? this.xPoint,
      yPoint: yPoint ?? this.yPoint,
      inWidth: inWidth ?? this.inWidth,
      inHeight: inHeight ?? this.inHeight,
      mullions: mullions ?? this.mullions,
      cells: cells ?? this.cells,
    );
  }

  @override
  String toString() {
    return "Cell_id: $id, L: $left, R: $right, T: $top, B: $bottom, xPoint: $xPoint, yPoint: $yPoint, inWidth: $inWidth, inHeight: $inHeight";
  }

  void addVerticalCenterMullion(Profile profile, int mullionCount) {
    if (top?.profile.type == ProfileType.frame) {
      double position = 0;
      List<double> positions = [];
      double mulpos = top!.len / (mullionCount + 1);
      for (var i = 0; i < mullionCount; i++) {
        position += mulpos;
        positions.add(position);
      }
      addVerticalMullion(profile, positions);
    }
  }

  void addVerticalMullion(Profile profile, List<double> mullionsPositions) {
    int mullioncount = 0;
    if (top?.profile.type == ProfileType.frame) {
      for (var mullionPosition in mullionsPositions) {
        mullions.add(
          Mullion(
            order: ++mullioncount,
            direction: Direction.vertical,
            len: inHeight!,
            position: mullionPosition,
            cellposition: mullionPosition - top!.leftEar,
            part: Part.create(
              leftAngle: 90,
              rightAngle: 90,
              len: inHeight!,
              profile: profile,
            ),
          ),
        );
      }
    }
  }

  void computeVerticalMullion() {
    for (var mullion in mullions) {
      //mullion.len = inHeight!;
      //mullion.part.len = inHeight!;
      //mullion.part.calculateInLen();
    }
  }

  void addHorizontalCenterMullion(Profile profile, int mullionCount) {
    if (top?.profile.type == ProfileType.frame) {
      double position = 0;
      List<double> positions = [];
      double mulpos = left!.len / (mullionCount + 1);
      for (var i = 0; i < mullionCount; i++) {
        position += mulpos;
        positions.add(position);
      }
      addHorizontalMullion(profile, positions);
    }
  }

  void addHorizontalMullion(Profile profile, List<double> mullionssizes) {
    int mullioncount = 0;
    if (left?.profile.type == ProfileType.frame) {
      for (var mullionssize in mullionssizes) {
        mullions.add(
          Mullion(
            order: ++mullioncount,
            direction: Direction.horizontal,
            len: inWidth!,
            position: mullionssize,
            cellposition: mullionssize - left!.leftEar,
            part: Part.create(
              leftAngle: 90,
              rightAngle: 90,
              len: inWidth!,
              profile: profile,
            ),
          ),
        );
      }
    }

    if (left?.profile.type == ProfileType.mullion) {
      for (var mullionssize in mullionssizes) {
        mullions.add(
          Mullion(
            order: ++mullioncount,
            direction: Direction.horizontal,
            len: inWidth!,
            position: mullionssize,
            cellposition: mullionssize - top!.leftEar,
            part: Part.create(
              leftAngle: 90,
              rightAngle: 90,
              len: inWidth!,
              profile: profile,
            ),
          ),
        );
      }
    }
  }

  void computeHorizontalMullion() {
    for (var mullion in mullions) {
      //mullion.len = inWidth!;
      //mullion.part.len = inWidth!;
      //mullion.part.calculateInLen();
    }
  }

  bool computeCells() {
    try {
      if (cells.isNotEmpty) {
        _tmpSash.clear();
        _tmpUnits.clear();
      }

      for (var cell in cells) {
        _tmpSash.add(cell.sash!);
        _tmpUnits.add(cell.unit!);
      }

      cells.clear();

      if (mullions.isEmpty) {
        return true;
      } else {
        mullions.sort((a, b) => a.position.compareTo(b.position));
      }

      for (var i = 0; i <= mullions.length; i++) {
        if (i == 0) {
          Wincell newcell = Wincell.create(id + (i + 1).toString());
          if (mullions[i].direction == Direction.vertical) {
            newcell.right = mullions[i].part;
            newcell.bottom = bottom;
            newcell.inHeight = inHeight;
            newcell.inWidth =
                mullions[i].cellposition - (mullions[i].part.profile.width / 2);
          } else if (mullions[i].direction == Direction.horizontal) {
            newcell.right = right;
            newcell.bottom = mullions[i].part;
            newcell.inHeight =
                mullions[i].cellposition - (mullions[i].part.profile.width / 2);
            newcell.inWidth = inWidth;
          }
          newcell.top = top;
          newcell.left = left;
          newcell.xPoint = xPoint;
          newcell.yPoint = yPoint;
          try {
            newcell.sash = _tmpSash[i];
            newcell.unit = _tmpUnits[i];
          } catch (e) {}

          cells.add(newcell);
          continue;
        }

        if (i == mullions.length) {
          Wincell newcell = Wincell.create(id + (i + 1).toString());
          if (mullions[i - 1].direction == Direction.vertical) {
            newcell.left = mullions[i - 1].part;
            newcell.top = top;
            newcell.inHeight = inHeight;
            newcell.inWidth = inWidth! -
                (mullions[i - 1].cellposition +
                    mullions[i - 1].part.profile.width / 2);
            newcell.xPoint = (mullions[i - 1].position +
                mullions[i - 1].part.profile.width / 2);
            newcell.yPoint = yPoint;
          } else if (mullions[i - 1].direction == Direction.horizontal) {
            newcell.left = left;
            newcell.top = mullions[i - 1].part;
            newcell.inHeight = inHeight! -
                (mullions[i - 1].cellposition +
                    mullions[i - 1].part.profile.width / 2);
            newcell.inWidth = inWidth;
            newcell.xPoint = xPoint;
            newcell.yPoint = (mullions[i - 1].position +
                mullions[i - 1].part.profile.width / 2);
          }
          newcell.bottom = bottom;
          newcell.right = right;
          try {
            newcell.sash = _tmpSash[i];
            newcell.unit = _tmpUnits[i];
          } catch (e) {}

          cells.add(newcell);
          return true;
        }

        Wincell newcell = Wincell.create(id + (i + 1).toString());
        if (mullions[i - 1].direction == Direction.vertical) {
          newcell.left = mullions[i - 1].part;
          newcell.top = top;
        } else if (mullions[i - 1].direction == Direction.horizontal) {
          newcell.left = left;
          newcell.top = mullions[i - 1].part;
        }
        if (mullions[i].direction == Direction.vertical) {
          newcell.right = mullions[i].part;
          newcell.bottom = bottom;
          newcell.inHeight = inHeight;
          newcell.inWidth = (mullions[i].cellposition -
                  (mullions[i].part.profile.width / 2)) -
              (mullions[i - 1].cellposition +
                  (mullions[i - 1].part.profile.width / 2));
          newcell.xPoint = mullions[i - 1].position +
              (mullions[i - 1].part.profile.width / 2);
          newcell.yPoint = yPoint;
        } else if (mullions[i].direction == Direction.horizontal) {
          newcell.right = right;
          newcell.bottom = mullions[i].part;
          newcell.inHeight = (mullions[i].cellposition -
                  (mullions[i].part.profile.width / 2)) -
              (mullions[i - 1].cellposition +
                  (mullions[i - 1].part.profile.width / 2));
          newcell.inWidth = inWidth;
          newcell.xPoint = xPoint;
          newcell.yPoint = mullions[i - 1].position +
              (mullions[i - 1].part.profile.width / 2);
        }
        try {
          newcell.sash = _tmpSash[i];
          newcell.unit = _tmpUnits[i];
        } catch (e) {}

        cells.add(newcell);
      }

      return true;
    } catch (e) {
      cells.clear();
      return false;
    }
  }

  void createCellUnit(String type, String typeName, double price) {
    String unitname = id + "_unit";
    unit = CellUnit.create(
        type: _parseCellUnitType(type),
        typeName: typeName,
        name: unitname,
        cellHeight: inHeight!,
        cellWidth: inWidth!,
        price: price);
  }

  void createSashCell(Profile profile, String openDirection, double sashMargin,
      String unitType, String unitName, double unitPrice) {
    String sashname = id + "_sash";
    sash = Sashcell.create(
        sashname: sashname,
        openDirection: openDirection,
        profile: profile,
        sashMargin: sashMargin,
        unitType: unitType,
        unitName: unitName,
        cellHeight: inHeight!,
        cellWidth: inWidth!,
        unitPrice: unitPrice);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'left': left?.toMap(),
      'right': right?.toMap(),
      'top': top?.toMap(),
      'bottom': bottom?.toMap(),
      'unit': unit?.toMap(),
      'sash': sash?.toMap(),
      'xPoint': xPoint,
      'yPoint': yPoint,
      'inWidth': inWidth,
      'inHeight': inHeight,
      'mullions': mullions.map((x) => x.toMap()).toList(),
      'cells': cells.map((x) => x.toMap()).toList(),
    };
  }

  factory Wincell.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Wincell.create('');
    }

    return Wincell(
      id: map['id'] ?? '',
      left: map['left'] != null ? Part.fromMap(map['left']) : null,
      right: map['right'] != null ? Part.fromMap(map['right']) : null,
      top: map['top'] != null ? Part.fromMap(map['top']) : null,
      bottom: map['bottom'] != null ? Part.fromMap(map['bottom']) : null,
      unit: map['unit'] != null ? CellUnit.fromMap(map['unit']) : null,
      sash: map['sash'] != null ? Sashcell.fromMap(map['sash']) : null,
      xPoint: map['xPoint'],
      yPoint: map['yPoint'],
      inWidth: map['inWidth'],
      inHeight: map['inHeight'],
      mullions: map['mullions'] != null
          ? List<Mullion>.from(map['mullions'].map((x) => Mullion.fromMap(x)))
          : [],
      cells: map['cells'] != null
          ? List<Wincell>.from(map['cells'].map((x) => Wincell.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Wincell.fromJson(String source) =>
      Wincell.fromMap(json.decode(source));
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
