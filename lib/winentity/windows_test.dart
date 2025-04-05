import 'package:windesign/profentity/profile.dart';

import 'cellunit.dart';
import 'part.dart';
import 'profile_test.dart';
import 'wincell.dart';
import 'windowobject.dart';

class WindowsTest {
  List<Part> cuttingParts = [];
  List<CellUnit> cellUnits = [];
  late WindowObject firstWin;
  late WindowObject secondWin;
  late WindowObject thirdWin;
  late ProfileTest profilemock;
  late Profile frameProfile;
  late Profile mullionProfile;
  late Profile sashProfile;

  void testMakeWin() {
    profilemock = ProfileTest();
    profilemock.createData();

    final profiles = profilemock.manufacturer.series
        .firstWhere((element) => element.name == "Carizma")
        .profiles;

    frameProfile = profiles.firstWhere((element) => element.type == "frame");

    firstWin = WindowObject(order: 1, count: 1, width: 2721, height: 1276, frame: frame, frameProfile: frameProfile, start: start)
    
    WindowObject.create(
        order: 1,
        count: 1,
        frameProfile: frameProfile,
        width: 2721,
        height: 1276);

    mullionProfile =
        profiles.firstWhere((element) => element.type == "mullion");

    sashProfile = profiles.firstWhere((element) => element.type == "sash");

    //firstWin.frame.addVerticalCenterMullion(mullionProfile, 1);
    final List<double> muls = [700, 2021];
    firstWin.frame.addVerticalMullion(mullionProfile, muls);
    //firstWin.frame.addHorizontalMullion(mullionProfile, muls);
    firstWin.frame.computeCells();

    firstWin.frame.cells[0]
        .createSashCell(sashProfile, "rightdouble", 8, "cam01", "çift cam", 90);

    firstWin.frame.cells[1].createCellUnit("cam01", "çift cam", 90);

    firstWin.frame.cells[2]
        .createSashCell(sashProfile, "left", 8, "cam01", "çift cam", 90);

    cellUnits.clear();
    cuttingParts.clear();
    cuttingParts.add(firstWin.frame.left);
    cuttingParts.add(firstWin.frame.right);
    cuttingParts.add(firstWin.frame.top);
    cuttingParts.add(firstWin.frame.bottom);

    print("Ana Pencere Orta Kayıtları");
    for (final m1 in firstWin.frame.mullions) {
      cuttingParts.add(m1.part);
      print(m1.toString());
    }

    print("Hücreler");
    for (final c1 in firstWin.frame.cells) {
      print(c1);
      printCell(c1);
      print(c1.unit);
      print(c1.sash);
      print(c1.sash.unit);
    }

    print("Kesim Listesi");
    for (final part in cuttingParts) {
      part.calculateCutLen(6);
      print(
          "Kesim Uzunluk: ${part.cutlen} Uzunluk: ${part.len} Profil:${part.profile.name}");
    }

    print("Cam Listesi");
    for (final cellUnit in cellUnits) {
      print(cellUnit);
    }

    return;
  }

  void testMakeWin2() {
    profilemock = ProfileTest();
    profilemock.createData();

    final profiles = profilemock.manufacturer.series
        .firstWhere((element) => element.name == "Carizma")
        .profiles;

    frameProfile = profiles.firstWhere((element) => element.type == "frame");

    secondWin = WindowObject.create(
        order: 1,
        count: 1,
        frameProfile: frameProfile,
        width: 760,
        height: 1260);
    secondWin.addtype = "";

    mullionProfile =
        profiles.firstWhere((element) => element.type == "mullion");

    sashProfile = profiles.firstWhere((element) => element.type == "sash");
    secondWin.frame.computeCells();

    secondWin.frame
        .createSashCell(sashProfile, "leftdouble", 8, "cam01", "çift cam", 90);

    cellUnits.clear();
    cuttingParts.clear();
    cuttingParts.add(secondWin.frame.left);
    cuttingParts.add(secondWin.frame.right);
    cuttingParts.add(secondWin.frame.top);
    cuttingParts.add(secondWin.frame.bottom);

    print("Ana Pencere Orta Kayıtları");
    for (final m1 in secondWin.frame.mullions) {
      cuttingParts.add(m1.part);
      print(m1.toString());
    }

    print("Hücreler");
    for (final c1 in secondWin.frame.cells) {
      print(c1);
      printCell(c1);
      print(c1.unit);
      print(c1.sash);
      print(c1.sash.unit);
    }

    print("Kesim Listesi");
    for (final part in cuttingParts) {
      part.calculateCutLen(6);
      print(
          "Kesim Uzunluk: ${part.cutlen} Uzunluk: ${part.len} Profil:${part.profile.name}");
    }

    print("Cam Listesi");
    for (final cellUnit in cellUnits) {
      print(cellUnit);
    }

    return;
  }

  void testMakeWin3() {
    profilemock = ProfileTest();
    profilemock.createData();

    final profiles = profilemock.manufacturer.series
        .firstWhere((element) => element.name == "Carizma")
        .profiles;

    frameProfile = profiles.firstWhere((element) => element.type == "frame");

    thirdWin = WindowObject.create(
        order: 1,
        count: 1,
        frameProfile: frameProfile,
        width: 700,
        height: 2000);
    thirdWin.addtype = "vertical";

    mullionProfile =
        profiles.firstWhere((element) => element.type == "mullion");

    sashProfile = profiles.firstWhere((element) => element.type == "sash");

    thirdWin.frame.computeCells();

    thirdWin.frame.createCellUnit("cam01", "Çift Cam", 90);
    //thirdWin.frame.createSashCell(sashProfile, "down", 8, "cam01", "çift cam", 90);

    cellUnits.clear();
    cuttingParts.clear();
    cuttingParts.add(thirdWin.frame.left);
    cuttingParts.add(thirdWin.frame.right);
    cuttingParts.add(thirdWin.frame.top);
    cuttingParts.add(thirdWin.frame.bottom);

    print("Ana Pencere Orta Kayıtları");
    for (final m1 in thirdWin.frame.mullions) {
      cuttingParts.add(m1.part);
      print(m1.toString());
    }

    print("Hücreler");
    for (final c1 in thirdWin.frame.cells) {
      print(c1);
      printCell(c1);
      print(c1.unit);
      print(c1.sash);
      print(c1.sash.unit);
    }

    print("Kesim Listesi");
    for (final part in cuttingParts) {
      part.calculateCutLen(6);
      print(
          "Kesim Uzunluk: ${part.cutlen} Uzunluk: ${part.len} Profil:${part.profile.name}");
    }

    print("Cam Listesi");
    for (final cellUnit in cellUnits) {
      print(cellUnit);
    }

    return;
  }

  void printCell(Wincell cell) {
    if (cell.cells.isNotEmpty) {
      for (final mullion in cell.mullions) {
        cuttingParts.add(mullion.part);
        print(mullion.toString());
      }
      for (final icell in cell.cells) {
        print(icell);
        printCell(icell);
        cellUnits.add(icell.unit);
        print(icell.unit);
        cuttingParts.add(icell.sash.left);
        cuttingParts.add(icell.sash.right);
        cuttingParts.add(icell.sash.top);
        cuttingParts.add(icell.sash.bottom);
        print(icell.sash);
        cellUnits.add(icell.sash.unit);
        print(icell.sash.unit);
      }
    }
  }
}
