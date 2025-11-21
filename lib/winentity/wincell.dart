import 'dart:convert';

import 'package:windesign/profentity/profile.dart';

import 'cellunit.dart';
import 'direction.dart';
import 'mullion.dart';
import 'part.dart';
import 'sashcell.dart';

class Wincell {
  late String id;
  late Part left;
  late Part right;
  late Part top;
  late Part bottom;
  CellUnit? unit;
  Sashcell? sash;

  late double xPoint;
  late double yPoint;
  late double inWidth;
  late double inHeight;

  late List<Mullion> mullions;
  late List<Wincell> cells;
  late List<Sashcell> tmpSash;
  late List<CellUnit> tmpUnits;
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
    required this.inWidth,
    required this.inHeight,
    required this.mullions,
    required this.cells,
  });

  Wincell.create(String id) {
    this.id = id;
    mullions = [];
    cells = [];
    tmpSash = [];
    tmpUnits = [];
  }

  @override
  String toString() {
    return "Cell_id: " +
        id +
        " L: " +
        left.toString() +
        ' R: ' +
        right.toString() +
        " T: " +
        top.toString() +
        " B:" +
        bottom.toString() +
        " xPoint: " +
        xPoint.toString() +
        " yPoint:" +
        yPoint.toString() +
        " inWidth: " +
        inWidth.toString() +
        " inHeight: " +
        inHeight.toString();
  }

  addVerticalCenterMullion(Profile profile, int mullionCount) {
    if (this.top.profile.type == "frame") {
      double position = 0;
      List<double> positions = [];
      double mulpos = this.top.len / (mullionCount + 1);
      for (var i = 0; i < mullionCount; i++) {
        position += mulpos;
        positions.add(position);
      }
      addVerticalMullion(profile, positions);
    }
  }

  addVerticalMullion(Profile profile, List<double> mullionsPositions) {
    //Vertical mullion top / bottom part operation
    int mullioncount = 0;
    if (this.top.profile.type == "frame") {
      for (var mullionPosition in mullionsPositions) {
        Mullion mullion = new Mullion();
        mullion.order = ++mullioncount;
        mullion.direction = Direction.vertical;
        mullion.len = this.inHeight;
        mullion.position = mullionPosition;
        mullion.cellposition = mullionPosition - this.top.leftEar;
        mullion.part = new Part.create(90, 90, this.inHeight, profile);
        this.mullions.add(mullion);
      }
    }
  }

  computeVerticalMullion() {
    for (var mullion in this.mullions) {
      mullion.len = this.inHeight;
      mullion.part.len = this.inHeight;
      mullion.part.calculateInLen();
    }
  }

  addHorizontalCenterMullion(Profile profile, int mullionCount) {
    if (this.top.profile.type == "frame") {
      double position = 0;
      List<double> positions = [];
      double mulpos = this.left.len / (mullionCount + 1);
      for (var i = 0; i < mullionCount; i++) {
        position += mulpos;
        positions.add(position);
      }
      addHorizontalMullion(profile, positions);
    }
  }

  addHorizontalMullion(Profile profile, List<double> mullionssizes) {
    //Horizontal mullion left / right part operation
    int mullioncount = 0;
    if (this.left.profile.type == "frame") {
      for (var mullionssize in mullionssizes) {
        Mullion mullion = new Mullion();
        mullion.order = ++mullioncount;
        mullion.direction = Direction.horizontal;
        mullion.len = this.inWidth;
        mullion.position = mullionssize;
        mullion.cellposition = mullionssize - this.left.leftEar;
        mullion.part = new Part.create(90, 90, this.inWidth, profile);
        this.mullions.add(mullion);
      }
    }

    if (this.left.profile.type == "mullion") {
      for (var mullionssize in mullionssizes) {
        Mullion mullion = new Mullion();
        mullion.order = ++mullioncount;
        mullion.direction = Direction.horizontal;
        mullion.len = this.inWidth;
        //mullion.position = mullionssize - this.top.leftEar;
        mullion.position = mullionssize;
        mullion.cellposition = mullionssize - this.top.leftEar;
        mullion.part = new Part.create(90, 90, this.inWidth, profile);
        this.mullions.add(mullion);
      }
    }
  }

  computeHorizontalMullion() {
    for (var mullion in this.mullions) {
      mullion.len = this.inWidth;
      mullion.part.len = this.inWidth;
      mullion.part.calculateInLen();
    }
  }

  bool computeCells() {
    try {
      if (cells.length > 0) {
        tmpSash.clear();
        tmpUnits.clear();
      }

      for (var cell in cells) {
        if (cell.sash != null) tmpSash.add(cell.sash!);
        if (cell.unit != null) tmpUnits.add(cell.unit!);
      }

      cells.clear();

      //no mullions - no cell
      if (mullions.length == 0) {
        return true;
      } else {
        mullions.sort((a, b) => a.position.compareTo(b.position));
      }

      //Compute Cells
      for (var i = 0; i <= mullions.length; i++) {
        //First Cell
        if (i == 0) {
          Wincell newcell = new Wincell.create(this.id + (i + 1).toString());
          if (mullions[i].direction == Direction.vertical) {
            //vertical
            newcell.right = this.mullions[i].part;
            newcell.bottom = this.bottom;
            newcell.inHeight = this.inHeight;
            newcell.inWidth = this.mullions[i].cellposition -
                (this.mullions[i].part.profile.width / 2);
          } else if (mullions[i].direction == Direction.horizontal) {
            //horizontal
            newcell.right = this.right;
            newcell.bottom = this.mullions[i].part;
            newcell.inHeight = this.mullions[i].cellposition -
                (this.mullions[i].part.profile.width / 2);
            newcell.inWidth = this.inWidth;
          }
          newcell.top = this.top;
          newcell.left = this.left;
          newcell.xPoint = this.xPoint;
          newcell.yPoint = this.yPoint;
          try {
            newcell.sash = tmpSash[i];
            newcell.unit = tmpUnits[i];
          } catch (e) {}

          cells.add(newcell);
          continue;
        }

        //Last Cell
        if (i == mullions.length) {
          Wincell newcell = new Wincell.create(this.id + (i + 1).toString());
          if (mullions[i - 1].direction == Direction.vertical) {
            //vertical
            newcell.left = this.mullions[i - 1].part;
            newcell.top = this.top;
            newcell.inHeight = this.inHeight;
            newcell.inWidth = this.inWidth -
                (this.mullions[i - 1].cellposition +
                    this.mullions[i - 1].part.profile.width / 2);
            newcell.xPoint = (this.mullions[i - 1].position +
                this.mullions[i - 1].part.profile.width / 2);
            newcell.yPoint = this.yPoint;
          } else if (mullions[i - 1].direction == Direction.horizontal) {
            //horizontal
            newcell.left = this.left;
            newcell.top = this.mullions[i - 1].part;
            newcell.inHeight = this.inHeight -
                (this.mullions[i - 1].cellposition +
                    this.mullions[i - 1].part.profile.width / 2);
            newcell.inWidth = this.inWidth;
            newcell.xPoint = this.xPoint;
            newcell.yPoint = (this.mullions[i - 1].position +
                this.mullions[i - 1].part.profile.width / 2);
          }
          newcell.bottom = this.bottom;
          newcell.right = this.right;
          try {
            newcell.sash = tmpSash[i];
            newcell.unit = tmpUnits[i];
          } catch (e) {}

          cells.add(newcell);
          return true;
        }

        //Center Parts
        Wincell newcell = new Wincell.create(this.id + (i + 1).toString());
        if (mullions[i - 1].direction == Direction.vertical) {
          //vertical
          newcell.left = this.mullions[i - 1].part;
          newcell.top = this.top;
        } else if (mullions[i - 1].direction == Direction.horizontal) {
          //horizontal
          newcell.left = this.left;
          newcell.top = this.mullions[i - 1].part;
        }
        if (mullions[i].direction == Direction.vertical) {
          //vertical
          newcell.right = this.mullions[i].part;
          newcell.bottom = this.bottom;
          newcell.inHeight = this.inHeight;
          newcell.inWidth = (this.mullions[i].cellposition -
                  (this.mullions[i].part.profile.width / 2)) -
              (this.mullions[i - 1].cellposition +
                  (this.mullions[i - 1].part.profile.width / 2));
          newcell.xPoint = this.mullions[i - 1].position +
              (this.mullions[i - 1].part.profile.width / 2);
          newcell.yPoint = this.yPoint;
        } else if (mullions[i].direction == Direction.horizontal) {
          //horizontal
          newcell.right = this.right;
          newcell.bottom = this.mullions[i].part;
          newcell.inHeight = (this.mullions[i].cellposition -
                  (this.mullions[i].part.profile.width / 2)) -
              (this.mullions[i - 1].cellposition +
                  (this.mullions[i - 1].part.profile.width / 2));
          newcell.inWidth = this.inWidth;
          newcell.xPoint = this.xPoint;
          newcell.yPoint = this.mullions[i - 1].position +
              (this.mullions[i - 1].part.profile.width / 2);
        }
        try {
          newcell.sash = tmpSash[i];
          newcell.unit = tmpUnits[i];
        } catch (e) {}

        cells.add(newcell);
      }

      return true;
    } catch (e) {
      cells.clear();
      return false;
    }
  }

  createCellUnit(String type, String typeName, double price) {
    String unitname = id + "_unit";
    this.unit =
        new CellUnit.create(type, typeName, unitname, inHeight, inWidth, price);
  }

  createSashCell(Profile profile, String openDirection, double sashMargin,
      String unitType, String unitName, double unitPrice) {
    String sashname = id + "_sash";
    this.sash = new Sashcell.create(sashname, openDirection, profile,
        sashMargin, unitType, unitName, inHeight, inWidth, unitPrice);
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
      'inWidth': inWidth,
      'inHeight': inHeight,
      'mullions': mullions.map((x) => x.toMap()).toList(),
      'cells': cells.map((x) => x.toMap()).toList(),
    };
  }

  factory Wincell.fromMap(Map<String, dynamic> map) {
    return Wincell(
      id: map['id'],
      left: Part.fromMap(map['left']),
      right: Part.fromMap(map['right']),
      top: Part.fromMap(map['top']),
      bottom: Part.fromMap(map['bottom']),
      unit: map['unit'] != null ? CellUnit.fromMap(map['unit']) : null,
      sash: map['sash'] != null ? Sashcell.fromMap(map['sash']) : null,
      xPoint: map['xPoint'],
      yPoint: map['yPoint'],
      inWidth: map['inWidth'],
      inHeight: map['inHeight'],
      mullions:
          List<Mullion>.from(map['mullions']?.map((x) => Mullion.fromMap(x))),
      cells: List<Wincell>.from(map['cells']?.map((x) => Wincell.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Wincell.fromJson(String source) =>
      Wincell.fromMap(json.decode(source));
}
