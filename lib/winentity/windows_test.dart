import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/profile.dart';

import 'cellunit.dart';
import 'part.dart';
import 'profile_test.dart';
import 'wincell.dart';
import 'window.dart';

class WindowsTest {
  List<Part> cuttingParts = [];
  List<CellUnit> cellUnits = [];
  PWindow? firstWin;
  PWindow? secondWin;
  PWindow? thirdWin;
  Profile? frameProfile;
  Profile? mullionProfile;
  Profile? sashProfile;

  void testMakeWin() {
    Manufacturer manufacturer = ProfileTest().manufacturer;

    var profiles = manufacturer.series
        .firstWhere((element) => element.name == "Carizma")
        .profiles;

    frameProfile =
        profiles.firstWhere((element) => element.type.name == "frame");

    firstWin = PWindow.create(1, 1, frameProfile!, 2721, 1276);

    mullionProfile =
        profiles.firstWhere((element) => element.type.name == "mullion");

    sashProfile = profiles.firstWhere((element) => element.type.name == "sash");

    //firstWin.frame.addVerticalCenterMullion(mullionProfile, 1);
    List<double> muls = [];
    muls.add(700);
    muls.add(2021);
    firstWin!.frame.addVerticalMullion(mullionProfile!, muls);
    //firstWin.frame.addHorizontalMullion(mullionProfile, muls);
    firstWin!.frame.computeCells();

    firstWin!.frame.cells[0].createSashCell(
        sashProfile!, "rightdouble", 8, "cam01", "çift cam", 90);

    firstWin!.frame.cells[1].createCellUnit("cam01", "çift cam", 90);

    firstWin!.frame.cells[2]
        .createSashCell(sashProfile!, "left", 8, "cam01", "çift cam", 90);

    //List<double> muls2 = new List<double>();
    //muls2.add(400);

    //firstWin.frame.cells[0].addHorizontalMullion(mullionProfile, muls2);
    //firstWin.frame.cells[0].computeCells();

    //List<double> muls3 = new List<double>();
    //muls3.add(400);

    //firstWin.frame.cells[1].addHorizontalMullion(mullionProfile, muls3);
    //firstWin.frame.cells[1].computeCells();

    //List<double> muls4 = new List<double>();
    //muls4.add(400);

    //firstWin.frame.cells[2].addHorizontalMullion(mullionProfile, muls4);
    //firstWin.frame.cells[2].computeCells();

    //firstWin.frame.cells[0].cells[0].createCellUnit("cam01", "Çift Cam", 90);
    //firstWin.frame.cells[0].cells[1].createCellUnit("cam01", "Çift Cam", 90);

    //firstWin.frame.cells[1].cells[0].createCellUnit("cam01", "Çift Cam", 90);
    //firstWin.frame.cells[1].cells[1]
    //    .createSashCell(sashProfile, 8, "cam02", "Çift Cam", 90);

    //firstWin.frame.cells[2].cells[0].createCellUnit("cam01", "Çift Cam", 90);
    //firstWin.frame.cells[2].cells[1].createCellUnit("cam01", "Çift Cam", 90);

    cellUnits.clear();
    cuttingParts.clear();
    cuttingParts.add(firstWin!.frame.left!);
    cuttingParts.add(firstWin!.frame.right!);
    cuttingParts.add(firstWin!.frame.top!);
    cuttingParts.add(firstWin!.frame.bottom!);

    print("Ana Pencere Orta Kayıtları");
    for (var m1 in firstWin!.frame.mullions) {
      cuttingParts.add(m1.part);
      print(m1.toString());
    }

    print("Hücreler");
    for (var c1 in firstWin!.frame.cells) {
      print(c1);
      printCell(c1);
      if (c1.unit != null) print(c1.unit);
      if (c1.sash != null) {
        print(c1.sash!);
        print(c1.sash!.unit);
      }
    }

    print("Kesim Listesi");
    for (var part in cuttingParts) {
      part.calculateCutLen(6);
      print("Kesim Uzunluk: " +
          part.cutlen.toString() +
          " Uzunluk: " +
          part.len.toString() +
          " Profil:" +
          part.profile.name);
    }

    print("Cam Listesi");
    for (var cellUnit in cellUnits) {
      print(cellUnit);
    }

    return;
  }

/*
  void testMakeWin2() {
    ProfileTest profilemock = new ProfileTest();
    profilemock.createData();

    var profiles = profilemock.manufacturer.series
        .firstWhere((element) => element.name == "Carizma")
        .profiles;

    var frameProfile =
        profiles.firstWhere((element) => element.type == "frame");

    secondWin = PWindow.create(1, 1, frameProfile, 760, 1260);
    secondWin.addtype = "";

    var mullionProfile =
        profiles.firstWhere((element) => element.type == "mullion");

    var sashProfile = profiles.firstWhere((element) => element.type == "sash");
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
    for (var m1 in secondWin.frame.mullions) {
      cuttingParts.add(m1.part);
      print(m1.toString());
    }

    print("Hücreler");
    for (var c1 in secondWin.frame.cells) {
      print(c1);
      printCell(c1);
      if (c1.unit != null) print(c1.unit);
      if (c1.sash != null) {
        print(c1.sash);
        print(c1.sash.unit);
      }
    }

    print("Kesim Listesi");
    for (var part in cuttingParts) {
      part.calculateCutLen(6);
      print("Kesim Uzunluk: " +
          part.cutlen.toString() +
          " Uzunluk: " +
          part.len.toString() +
          " Profil:" +
          part.profile.name);
    }

    print("Cam Listesi");
    for (var cellUnit in cellUnits) {
      print(cellUnit);
    }

    return;
  }

  void testMakeWin3() {
    ProfileTest profilemock = new ProfileTest();
    profilemock.createData();

    var profiles = profilemock.manufacturer.series
        .firstWhere((element) => element.name == "Carizma")
        .profiles;

    var frameProfile =
        profiles.firstWhere((element) => element.type == "frame");

    thirdWin = PWindow.create(1, 1, frameProfile, 700, 2000);
    thirdWin.addtype = "vertical";

    var mullionProfile =
        profiles.firstWhere((element) => element.type == "mullion");

    var sashProfile = profiles.firstWhere((element) => element.type == "sash");

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
    for (var m1 in thirdWin.frame.mullions) {
      cuttingParts.add(m1.part);
      print(m1.toString());
    }

    print("Hücreler");
    for (var c1 in thirdWin.frame.cells) {
      print(c1);
      printCell(c1);
      if (c1.unit != null) print(c1.unit);
      if (c1.sash != null) {
        print(c1.sash);
        print(c1.sash.unit);
      }
    }

    print("Kesim Listesi");
    for (var part in cuttingParts) {
      part.calculateCutLen(6);
      print("Kesim Uzunluk: " +
          part.cutlen.toString() +
          " Uzunluk: " +
          part.len.toString() +
          " Profil:" +
          part.profile.name);
    }

    print("Cam Listesi");
    for (var cellUnit in cellUnits) {
      print(cellUnit);
    }

    return;
  }
*/
  printCell(Wincell cell) {
    if (cell.cells.length != 0) {
      for (var mullion in cell.mullions) {
        cuttingParts.add(mullion.part);
        print(mullion.toString());
      }
      for (var icell in cell.cells) {
        print(icell);
        printCell(icell);
        if (icell.unit != null) {
          cellUnits.add(icell.unit!);
          print(icell.unit);
        }
        if (icell.sash != null) {
          cuttingParts.add(icell.sash!.left);
          cuttingParts.add(icell.sash!.right);
          cuttingParts.add(icell.sash!.top);
          cuttingParts.add(icell.sash!.bottom);
          print(icell.sash);
          cellUnits.add(icell.sash!.unit);
          print(icell.sash!.unit);
        }
      }
    }
  }
}
