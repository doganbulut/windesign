import 'dart:convert';

import 'package:windesign/profentity/profile.dart';

import 'cellunit.dart';
import 'direction.dart';
import 'mullion .dart';
import 'part.dart';
import 'sashcell.dart';

class Wincell {
  static const double defaultPartAngle = 90.0;
  String id;
  Part left;
  Part right;
  Part top;
  Part bottom;
  CellUnit? unit;
  Sashcell? sash;

  double xPoint;
  double yPoint;
  double innerWidth;
  double innerHeight;

  List<Mullion> mullions;
  List<Wincell> cells;
  List<Sashcell> _cachedSashes = []; // Renamed and added comment
  List<CellUnit> _cachedUnits = []; // Renamed and added comment

  Wincell({
    required this.id,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    this.unit,
    this.sash,
    required this.xPoint,
    required this.yPoint,
    required this.innerWidth,
    required this.innerHeight,
    this.mullions = const [],
    this.cells = const [],
  });

  Wincell.create(String id)
      : this(
          id: id,
          left: Part.create(
              defaultPartAngle,
              defaultPartAngle,
              0,
              Profile.create(
                  code: 'frame_left_$id', name: 'Frame Left', type: 'frame')),
          right: Part.create(
              defaultPartAngle,
              defaultPartAngle,
              0,
              Profile.create(
                  code: 'frame_right_$id', name: 'Frame Right', type: 'frame')),
          top: Part.create(
              defaultPartAngle,
              defaultPartAngle,
              0,
              Profile.create(
                  code: 'frame_top_$id', name: 'Frame Top', type: 'frame')),
          bottom: Part.create(
              defaultPartAngle,
              defaultPartAngle,
              0,
              Profile.create(
                  code: 'frame_bottom_$id',
                  name: 'Frame Bottom',
                  type: 'frame')),
          unit: null,
          sash: null,
          mullions: [],
          cells: [],
          xPoint: 0,
          yPoint: 0,
          innerWidth: 0,
          innerHeight: 0,
        );

  @override
  String toString() {
    return 'Cell_id: $id, L: $left, R: $right, T: $top, B: $bottom, xPoint: $xPoint, yPoint: $yPoint, inWidth: $innerWidth, inHeight: $innerHeight';
  }

  void addVerticalCenterMullion(Profile profile, int mullionCount) {
    if (top.profile.type == "frame") {
      final mulpos = top.len / (mullionCount + 1);
      final positions = List.generate(mullionCount, (i) => mulpos * (i + 1));
      addVerticalMullionEx(profile, positions);
    }
  }

  void addVerticalMullionEx(Profile profile, List<double> mullionsPositions) {
    if (top.profile.type != "frame") return;
    var mullioncount = 0;
    for (final mullionPosition in mullionsPositions) {
      final mullion = Mullion(
          code: 'vertical_mullion_${id}_${++mullioncount}',
          name: 'Vertical Mullion');
      mullion.order = mullioncount;
      mullion.direction = Direction.vertical;
      mullion.len = innerHeight;
      mullion.position = mullionPosition;
      mullion.cellposition = mullionPosition - top.leftEar;
      mullion.part =
          Part.create(defaultPartAngle, defaultPartAngle, innerHeight, profile);
      mullions.add(mullion);
    }
  }

  void computeVerticalMullion() {
    for (final mullion in mullions) {
      mullion.len = innerHeight;
      mullion.part?.len = innerHeight;
      mullion.part?.calculateInLen();
    }
  }

  void addHorizontalCenterMullion(Profile profile, int mullionCount) {
    if (left.profile.type == "frame") {
      final mulpos = left.len / (mullionCount + 1);
      final positions = List.generate(mullionCount, (i) => mulpos * (i + 1));
      addHorizontalMullionEx(profile, positions);
    }
  }

  void addHorizontalMullionEx(Profile profile, List<double> mullionsPositions) {
    if (left.profile.type != "frame" && left.profile.type != "mullion") return;
    var mullioncount = 0;
    for (final mullionssize in mullionsPositions) {
      final mullion = Mullion(
          code: 'horizontal_mullion_${id}_${++mullioncount}',
          name: 'Horizontal Mullion');
      mullion.order = mullioncount;
      mullion.direction = Direction.horizontal;
      mullion.len = innerWidth;
      mullion.position = mullionssize;
      mullion.cellposition = mullionssize -
          (left.profile.type == "frame" ? left.leftEar : top.leftEar);
      mullion.part =
          Part.create(defaultPartAngle, defaultPartAngle, innerWidth, profile);
      mullions.add(mullion);
    }
  }

  void computeHorizontalMullion() {
    for (final mullion in mullions) {
      mullion.len = innerWidth;
      if (mullion.part != null) {
        mullion.part!.len = innerWidth;
        mullion.part!.calculateInLen();
      }
    }
  }

  bool computeCells() {
    try {
      if (cells.isNotEmpty) {
        _cachedSashes.clear();
        _cachedUnits.clear();
      }

      for (final cell in cells) {
        if (cell.sash != null) _cachedSashes.add(cell.sash!);
        if (cell.unit != null) _cachedUnits.add(cell.unit!);
      }

      cells.clear();

      if (mullions.isEmpty) {
        return true;
      } else {
        mullions.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));
      }

      for (var i = 0; i < mullions.length + 1; i++) {
        final newcell = Wincell.create(id + (i + 1).toString());
        _configureCell(newcell, i);
        try {
          if (_cachedSashes.length > i) newcell.sash = _cachedSashes[i];
          if (_cachedUnits.length > i) newcell.unit = _cachedUnits[i];
        } catch (e) {
          // Handle exception if needed
        }
        cells.add(newcell);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _configureCell(Wincell newcell, int i) {
    if (i == 0) {
      _configureFirstCell(newcell);
    } else if (i == mullions.length) {
      _configureLastCell(newcell, i);
    } else {
      _configureCenterCell(newcell, i);
    }
  }

  void _configureFirstCell(Wincell newcell) {
    final firstMullion = mullions.first;
    if (firstMullion.direction == Direction.vertical) {
      newcell.right = firstMullion.part!;
      newcell.bottom = bottom;
      newcell.innerHeight = innerHeight;
      newcell.innerWidth =
          (firstMullion.cellposition! - (firstMullion.part!.profile.width / 2));
    } else if (firstMullion.direction == Direction.horizontal) {
      newcell.right = right;
      newcell.bottom = firstMullion.part!;
      newcell.innerHeight =
          (firstMullion.cellposition! - (firstMullion.part!.profile.width / 2));
      newcell.innerWidth = innerWidth;
    }
    newcell.top = top;
    newcell.left = left;
    newcell.xPoint = xPoint;
    newcell.yPoint = yPoint;
  }

  void _configureLastCell(Wincell newcell, int i) {
    final lastMullion = mullions[i - 1];
    if (lastMullion.direction == Direction.vertical) {
      newcell.left = lastMullion.part!;
      newcell.top = top;
      newcell.innerHeight = innerHeight;
      newcell.innerWidth = innerWidth -
          (lastMullion.cellposition! + lastMullion.part!.profile.width / 2);
      newcell.xPoint =
          (lastMullion.position! + lastMullion.part!.profile.width / 2);
      newcell.yPoint = yPoint;
    } else if (lastMullion.direction == Direction.horizontal) {
      newcell.left = left;
      newcell.top = lastMullion.part!;
      newcell.innerHeight = innerHeight -
          (lastMullion.cellposition! + lastMullion.part!.profile.width / 2);
      newcell.innerWidth = innerWidth;
      newcell.xPoint = xPoint;
      newcell.yPoint =
          (lastMullion.position! + lastMullion.part!.profile.width / 2);
    }
    newcell.bottom = bottom;
    newcell.right = right;
  }

  void _configureCenterCell(Wincell newcell, int i) {
    final previousMullion = mullions[i - 1];
    final currentMullion = mullions[i];

    if (previousMullion.direction == Direction.vertical) {
      newcell.left = previousMullion.part!;
      newcell.top = top;
    } else if (previousMullion.direction == Direction.horizontal) {
      newcell.left = left;
      newcell.top = previousMullion.part!;
    }

    if (currentMullion.direction == Direction.vertical) {
      newcell.right = currentMullion.part!;
      newcell.bottom = bottom;
      newcell.innerHeight = innerHeight;
      newcell.innerWidth = (currentMullion.cellposition! -
              (currentMullion.part!.profile.width / 2)) -
          (previousMullion.cellposition! +
              (previousMullion.part!.profile.width / 2));
      newcell.xPoint = (previousMullion.position! +
          (previousMullion.part!.profile.width / 2));
      newcell.yPoint = yPoint;
    } else if (currentMullion.direction == Direction.horizontal) {
      newcell.right = right;
      newcell.bottom = currentMullion.part!;
      newcell.innerHeight = (currentMullion.cellposition! -
              (currentMullion.part!.profile.width / 2)) -
          (previousMullion.cellposition! +
              (previousMullion.part!.profile.width / 2));
      newcell.innerWidth = innerWidth;
      newcell.xPoint = xPoint;
      newcell.yPoint = (previousMullion.position! +
          (previousMullion.part!.profile.width / 2));
    }
  }

  void createCellUnit(String type, String typeName, double price) {
    final unitname = id + "_unit";
    unit = CellUnit(
        name: unitname,
        type: type,
        typeName: typeName,
        unitprice: 0,
        unitHeight: 0,
        unitWidth: 0);
  }

  void createSashCell(Profile profile, String openDirection, double sashMargin,
      String unitType, String unitName, double unitPrice) {
    final sashname = id + "_sash";
    sash = Sashcell.create(
        name: sashname,
        openDirection: openDirection,
        profile: profile,
        sashMargin: sashMargin,
        unitType: unitType,
        typeName: unitName,
        cellHeight: innerHeight,
        cellWidth: innerWidth,
        unitPrice: unitPrice);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'left': left.toMap(),
      'right': right.toMap(),
      'top': top.toMap(),
      'bottom': bottom.toMap(),
      'unit': unit?.toMap(),
      'sash': sash?.toMap(),
      'xPoint': xPoint,
      'yPoint': yPoint,
      'inWidth': innerWidth,
      'inHeight': innerHeight,
      'mullions': mullions.map((x) => x.toMap()).toList(),
      'cells': cells.map((x) => x.toMap()).toList(),
    };
  }

  factory Wincell.fromMap(Map<String, dynamic> map) {
    return Wincell(
      id: map['id'],
      left: Part.fromMap(map['left'] ?? {}),
      right: Part.fromMap(map['right'] ?? {}),
      top: Part.fromMap(map['top'] ?? {}),
      bottom: Part.fromMap(map['bottom'] ?? {}),
      unit: CellUnit.fromMap(map['unit'] ?? {}),
      sash: Sashcell.fromMap(map['sash'] ?? {}),
      xPoint: map['xPoint'] ?? 0,
      yPoint: map['yPoint'] ?? 0,
      innerWidth: map['inWidth'] ?? 0,
      innerHeight: map['inHeight'] ?? 0,
      mullions: List<Mullion>.from(
          map['mullions']?.map((x) => Mullion.fromMap(x ?? {})) ?? []),
      cells: List<Wincell>.from(
          map['cells']?.map((x) => Wincell.fromMap(x ?? {})) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Wincell.fromJson(String source) =>
      Wincell.fromMap(json.decode(source));
}
