// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:windesign/constants.dart';
import 'package:windesign/profentity/profile.dart';
import 'package:windesign/winentity/mullion.dart';

import 'cellunit.dart';
import 'direction.dart';
import 'part.dart';
import 'sashcell.dart';

class Wincell {
  String id = "";
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

  List<Mullion>? mullions = [];
  List<Wincell>? cells = [];
  List<Sashcell>? tmpSash = [];
  List<CellUnit>? tmpUnits = [];

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
    this.mullions,
    this.cells,
    this.tmpSash,
    this.tmpUnits,
  });

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
    try {
      if (this.top!.profile.type == "frame") {
        double position = 0;
        List<double> positions = [];
        double mulpos = this.top!.len! / (mullionCount + 1);
        for (var i = 0; i < mullionCount; i++) {
          position += mulpos;
          positions.add(position);
        }
        addVerticalMullion(profile, positions);
      }
    } catch (e) {
      print('Error in addVerticalCenterMullion: $e');
    }
  }

  addVerticalMullion(Profile profile, List<double> mullionsPositions) {
    try {
      //Vertical mullion top / bottom part operation
      int mullioncount = 0;
      if (this.top!.profile.type == "frame") {
        for (var mullionPosition in mullionsPositions) {
          Mullion mullion = Mullion(
              order: ++mullioncount,
              direction: Direction.vertical,
              len: this.inHeight,
              position: mullionPosition,
              cellposition: mullionPosition - this.top!.leftEar,
              part: Part.create(
                  leftAngle: 90,
                  rightAngle: 90,
                  len: this.inHeight,
                  profile: profile));
          this.mullions.add(mullion);
        }
      }
    } catch (e) {
      print('Error in addVerticalMullion: $e');
    }
  }

  computeVerticalMullion() {
    try {
      for (var mullion in this.mullions) {
        mullion.len = this.inHeight;
        mullion.part.len = this.inHeight;
        mullion.part.calculateInLen();
      }
    } catch (e) {
      print('Error in computeVerticalMullion: $e');
    }
  }

  addHorizontalCenterMullion(Profile profile, int mullionCount) {
    try {
      if (this.top!.profile.type == "frame") {
        double position = 0;
        List<double> positions = [];
        double mulpos = this.left!.len! / (mullionCount + 1);
        for (var i = 0; i < mullionCount; i++) {
          position += mulpos;
          positions.add(position);
        }
        addHorizontalMullion(profile, positions);
      }
    } catch (e) {
      print('Error in addHorizontalCenterMullion: $e');
    }
  }

  addHorizontalMullion(Profile profile, List<double> mullionssizes) {
    try {
      //Horizontal mullion left / right part operation
      int mullioncount = 0;
      if (this.left!.profile.type == "frame") {
        for (var mullionssize in mullionssizes) {
          Mullion mullion = Mullion(
              order: ++mullioncount,
              direction: Direction.horizontal,
              len: this.inWidth,
              position: mullionssize,
              cellposition: mullionssize - this.left!.leftEar,
              part: Part.create(
                  leftAngle: 90,
                  rightAngle: 90,
                  len: this.inWidth,
                  profile: profile));
          this.mullions.add(mullion);
        }
      }

      if (this.left!.profile.type == "mullion") {
        for (var mullionssize in mullionssizes) {
          Mullion mullion = Mullion(
              order: ++mullioncount,
              direction: Direction.horizontal,
              len: this.inWidth,
              position: mullionssize,
              cellposition: mullionssize - this.top!.leftEar,
              part: Part.create(
                  leftAngle: 90,
                  rightAngle: 90,
                  len: this.inWidth,
                  profile: profile));
          this.mullions.add(mullion);
        }
      }
    } catch (e) {
      print('Error in addHorizontalMullion: $e');
    }
  }

  computeHorizontalMullion() {
    try {
      for (var mullion in this.mullions) {
        mullion.len = this.inWidth;
        mullion.part.len = this.inWidth;
        mullion.part.calculateInLen();
      }
    } catch (e) {
      print('Error in computeHorizontalMullion: $e');
    }
  }

  bool computeCells() {
    try {
      if (cells.length > 0) {
        tmpSash!.clear();
        tmpUnits!.clear();
      }

      for (var cell in cells) {
        tmpSash!.add(cell.sash!);
        tmpUnits!.add(cell.unit!);
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
          Wincell newcell = Wincell(
              id: id + (i + 1).toString(),
              mullions: mullions,
              cells: cells,
              tmpSash: tmpSash,
              tmpUnits: tmpUnits);

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
            newcell.sash = tmpSash![i];
            newcell.unit = tmpUnits![i];
          } catch (e) {
            print(
                'Error in computeCells (First Cell - Sash/Unit assignment): $e');
          }

          cells.add(newcell);
          continue;
        }

        //Last Cell
        if (i == mullions.length) {
          Wincell newcell = Wincell(
              id: id + (i + 1).toString(),
              mullions: mullions,
              cells: cells,
              tmpSash: tmpSash,
              tmpUnits: tmpUnits);
          if (mullions[i - 1].direction == Direction.vertical) {
            //vertical
            newcell.left = this.mullions[i - 1].part;
            newcell.top = this.top;
            newcell.inHeight = this.inHeight;
            newcell.inWidth = (this.inWidth! -
                (this.mullions[i - 1].cellposition +
                    this.mullions[i - 1].part.profile.width / 2));
            newcell.xPoint = (this.mullions[i - 1].position +
                this.mullions[i - 1].part.profile.width / 2);
            newcell.yPoint = this.yPoint;
          } else if (mullions[i - 1].direction == Direction.horizontal) {
            //horizontal
            newcell.left = this.left;
            newcell.top = this.mullions[i - 1].part;
            newcell.inHeight = (this.inHeight! -
                (this.mullions[i - 1].cellposition +
                    this.mullions[i - 1].part.profile.width / 2));
            newcell.inWidth = this.inWidth;
            newcell.xPoint = this.xPoint;
            newcell.yPoint = (this.mullions[i - 1].position +
                this.mullions[i - 1].part.profile.width / 2);
          }
          newcell.bottom = this.bottom;
          newcell.right = this.right;
          try {
            newcell.sash = tmpSash![i];
            newcell.unit = tmpUnits![i];
          } catch (e) {
            print(
                'Error in computeCells (Last Cell - Sash/Unit assignment): $e');
          }

          cells.add(newcell);
          return true;
        }

        //Center Parts
        Wincell newcell = Wincell(
            id: id + (i + 1).toString(),
            mullions: mullions,
            cells: cells,
            tmpSash: tmpSash,
            tmpUnits: tmpUnits);

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
          newcell.sash = tmpSash![i];
          newcell.unit = tmpUnits![i];
        } catch (e) {
          print(
              'Error in computeCells (Center Cell - Sash/Unit assignment): $e');
        }

        cells.add(newcell);
      }

      return true;
    } catch (e) {
      print('Error in computeCells: $e');
      cells.clear();
      return false;
    }
  }

  void createCellUnit(String type, String typeName, double price,
      double cellHeight, double cellWidth) {
    unit = CellUnit(
      id: "unit$id",
      type: type,
      typeName: typeName,
      unitprice: (cellHeight - Constants.cellUnitMargin) *
          (cellWidth - Constants.cellUnitMargin) *
          price,
      unitHeight: cellHeight - Constants.cellUnitMargin,
      unitWidth: cellWidth - Constants.cellUnitMargin,
    );
  }

  createSashCell(Profile profile, String openDirection, double sashMargin,
      String unitType, String unitName, double unitPrice) {
    try {
      String sashname = id + "_sash";
      this.sash = Sashcell.create(
          name: sashname,
          openDirection: openDirection,
          profile: profile,
          sashMargin: sashMargin,
          unitType: unitType,
          typeName: unitName,
          cellHeight: inHeight!,
          cellWidth: inWidth!,
          unitPrice: unitPrice);
    } catch (e) {
      print('Error in createSashCell: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'left': left!.toMap(),
        'right': right!.toMap(),
        'top': top!.toMap(),
        'bottom': bottom!.toMap(),
        'unit': unit!.toMap(),
        'sash': sash!.toMap(),
        'xPoint': xPoint,
        'yPoint': yPoint,
        'inWidth': inWidth,
        'inHeight': inHeight,
        'mullions': mullions.map((x) => x.toMap()).toList(),
        'cells': cells.map((x) => x.toMap()).toList(),
      };
    } catch (e) {
      print('Error in toMap: $e');
      return {};
    }
  }

  factory Wincell.fromMap(Map<String, dynamic> map) {
    try {
      return Wincell(
        id: map['id'] as String,
        left: Part.fromMap(map['left']),
        right: Part.fromMap(map['right']),
        top: Part.fromMap(map['top']),
        bottom: Part.fromMap(map['bottom']),
        unit: CellUnit.fromMap(map['unit']),
        sash: Sashcell.fromMap(map['sash']),
        xPoint: map['xPoint'] as double,
        yPoint: map['yPoint'] as double,
        inWidth: map['inWidth'] as double,
        inHeight: map['inHeight'] as double,
        mullions: List<Mullion>.from(
            (map['mullions'] as List).map((x) => Mullion.fromMap(x))),
        cells: List<Wincell>.from(
            (map['cells'] as List).map((x) => Wincell.fromMap(x))),
        tmpSash: [],
        tmpUnits: [],
      );
    } catch (e) {
      print('Error in fromMap: $e');
      return Wincell(
          id: "0", mullions: [], cells: [], tmpSash: [], tmpUnits: []);
    }
  }

  String toJson() {
    try {
      return json.encode(toMap());
    } catch (e) {
      print('Error in toJson: $e');
      return "";
    }
  }

  factory Wincell.fromJson(String source) {
    try {
      return Wincell.fromMap(json.decode(source));
    } catch (e) {
      print('Error in fromJson: $e');
      return Wincell(
          id: "0", mullions: [], cells: [], tmpSash: [], tmpUnits: []);
    }
  }
}
