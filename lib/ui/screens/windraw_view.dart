import 'package:flutter/material.dart';
import 'package:windesign/windrawer/windraw.dart';
import 'package:windesign/windrawer/winpainter.dart';
import 'package:windesign/winentity/wincell.dart';
import 'package:windesign/winentity/window.dart';

class WinDrawView extends StatefulWidget {
  const WinDrawView({Key? key}) : super(key: key);

  @override
  _WinDrawViewState createState() => _WinDrawViewState();
}

class _WinDrawViewState extends State<WinDrawView> {
  final double toolbarHeight = 50;
  final double menuHeight = 56;
  late WinPainter winPainter;
  late String data = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getToolBar(),
          getCanvas(MediaQuery.of(context).size),
        ],
      ),
    );
  }

  Widget getToolBar() {
    return SizedBox(
      height: toolbarHeight,
      child: Container(
        color: Colors.amber,
        child: OverflowBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
              child: const Text('Create Window'),
              onPressed: () {
                var frameProfile = WinDraw().testwin!.frameProfile;
                WinDraw().windows.clear();
                var window = PWindow.create(2, 1, frameProfile, 3000, 1500);
                WinDraw().windows.add(window);
                WinDraw().activeWindow = window;
                var pWindow = WinDraw().activeWindow;
                pWindow!.calculateWinParts();
                pWindow.frame!.computeCells();
                print(pWindow.toString());
              },
            ),
            TextButton(
              child: const Text('Change Size'),
              onPressed: () {
                var pWindow = WinDraw().activeWindow;
                pWindow!.width = 3000;
                pWindow.height = 1500;
                pWindow.calculateWinParts();
                pWindow.frame!.computeVerticalMullion();
                pWindow.frame!.computeCells();
                print(pWindow.toString());
              },
            ),
            TextButton(
              child: const Text('Json'),
              onPressed: () {
                var pWindow = WinDraw().activeWindow;
                String pdata = pWindow!.toJson();
                var zwindow = PWindow.fromJson(pdata);
                WinDraw().windows.clear();
                WinDraw().windows.add(zwindow);
                WinDraw().activeWindow = zwindow;
                print(zwindow.toString());
              },
            ),
            TextButton(
              child: const Text('Json2'),
              onPressed: () {
                data = WinDraw().toJson();
                print(data);
                WinDraw().windows.clear();
              },
            ),
            TextButton(
              child: const Text('Json3'),
              onPressed: () {
                WinDraw().fromJson(data);
                WinDraw().activeWindow = WinDraw().windows[0];
              },
            ),
            TextButton(
              child: const Text('Json4'),
              onPressed: () {
                WinDraw().fromJson(data);
                WinDraw().activeWindow = WinDraw().windows[0];
              },
            ),
            TextButton(
              child: const Text('Add Mullion'),
              onPressed: () {
                var pWindow = WinDraw().activeWindow;
                pWindow!.calculateWinParts();
                pWindow.frame!.addVerticalCenterMullion(
                    WinDraw().testwin!.mullionProfile, 2);
                pWindow.frame!.computeVerticalMullion();
                pWindow.frame!.computeCells();

                for (var icell in pWindow.frame!.cells) {
                  icell.addHorizontalCenterMullion(
                      WinDraw().testwin!.mullionProfile, 1);
                  icell.computeHorizontalMullion();
                  icell.computeCells();
                }

                for (var icell in pWindow.frame!.cells) {
                  var j = 0;
                  for (var jcell in icell.cells) {
                    if (j == 0) {
                      jcell.createCellUnit("cam01", "çift cam", 90);
                    } else {
                      jcell.createSashCell(WinDraw().testwin!.sashProfile,
                          "rightdouble", 8, "cam01", "çift cam", 90);
                    }
                    ++j;
                  }
                }

                print("Hücreler");
                for (var c1 in pWindow.frame!.cells) {
                  print(c1);
                  printCell(c1);
                  print(c1.unit);
                  print(c1.sash);
                  print(c1.sash!.unit);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void printCell(Wincell cell) {
    if (cell.cells.isNotEmpty) {
      for (var mullion in cell.mullions) {
        print(mullion.toString());
      }
      for (var icell in cell.cells) {
        print(icell);
        printCell(icell);
        print(icell.unit);
        print(icell.sash);
        print(icell.sash!.unit);
      }
    }
  }

  void createDefautUnit(List<Wincell> cells) {
    if (cells.isNotEmpty) {
      for (var cell in cells) {
        cell.createCellUnit("cam01", "çift cam", 90);
        createDefautUnit(cell.cells);
      }
    }
  }

  Widget getCanvas(Size mediaSize) {
    Size sizeCanvas =
        Size(mediaSize.width, mediaSize.height - (toolbarHeight + menuHeight));
    return Container(
      constraints: BoxConstraints(
          maxWidth: sizeCanvas.width, maxHeight: sizeCanvas.height),
      color: Colors.grey,
      child: GestureDetector(
          child: CustomPaint(size: sizeCanvas, painter: WinPainter(context))),
    );
  }
}
