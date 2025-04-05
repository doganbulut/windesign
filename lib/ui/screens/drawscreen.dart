import 'package:flutter/material.dart';
import 'package:windesign/windrawer/drawcontainer.dart';
import 'package:windesign/windrawer/winpainter.dart';
import 'package:windesign/winentity/wincell.dart';
import 'package:windesign/winentity/windowobject.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({Key? key}) : super(key: key);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  final double toolbarHeight = 50;
  final double menuHeight = 56;
  late WinPainter winPainter;
  late BuildContext context;
  String data = '';

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getToolBar(this.toolbarHeight),
          getCanvas(MediaQuery.of(context).size, this.toolbarHeight),
        ],
      ),
    );
  }

  Widget getToolBar(double toolHeight) {
    return SizedBox(
      height: toolHeight,
      child: Container(
        color: Colors.amber,
        child: OverflowBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
              child: Text('Create Window'),
              onPressed: () {
                final frameProfile = DrawContainer().testwin!.frameProfile;
                DrawContainer().windows.clear();
                final window = WindowObject.create(
                    order: 2,
                    count: 1,
                    frameProfile: frameProfile,
                    width: 3000,
                    height: 1500);
                DrawContainer().windows.add(window);
                DrawContainer().activeWindow = window;
                final activeWindow = DrawContainer().activeWindow!;
                activeWindow.calculateWinParts();
                activeWindow.frame.computeCells();
                print(activeWindow.toString());
              },
            ),
            TextButton(
              child: Text('Change Size'),
              onPressed: () {
                final activeWindow = DrawContainer().activeWindow!;
                activeWindow.width = 3000;
                activeWindow.height = 1500;
                activeWindow.calculateWinParts();
                activeWindow.frame.computeVerticalMullion();
                activeWindow.frame.computeCells();
                print(activeWindow.toString());
              },
            ),
            TextButton(
              child: Text('Json'),
              onPressed: () {
                final activeWindow = DrawContainer().activeWindow!;
                final pdata = activeWindow.toJson();
                final zwindow = WindowObject.fromJson(pdata);
                DrawContainer().windows.clear();
                DrawContainer().windows.add(zwindow);
                DrawContainer().activeWindow = zwindow;
                print(zwindow.toString());
              },
            ),
            TextButton(
              child: Text('Json2'),
              onPressed: () {
                data = DrawContainer().toJson();
                print(data);
              },
            ),
            TextButton(
              child: Text('Json3'),
              onPressed: () {
                DrawContainer().fromJson(data);
                DrawContainer().activeWindow = DrawContainer().windows[0];
              },
            ),
            TextButton(
              child: Text('Json4'),
              onPressed: () {
                DrawContainer().fromJson(data);
                DrawContainer().activeWindow = DrawContainer().windows[0];
              },
            ),
            TextButton(
              child: Text('Add Mullion'),
              onPressed: () {
                final activeWindow = DrawContainer().activeWindow!;
                activeWindow.calculateWinParts();
                activeWindow.frame.addVerticalCenterMullion(
                    DrawContainer().testwin!.mullionProfile, 2);
                activeWindow.frame.computeVerticalMullion();
                activeWindow.frame.computeCells();
                for (final icell in activeWindow.frame.cells) {
                  icell.addHorizontalMullion(
                      DrawContainer().testwin!.mullionProfile, [500]);
                  icell.computeHorizontalMullion();
                  icell.computeCells();
                }

                for (final icell in activeWindow.frame.cells) {
                  var j = 0;
                  for (final jcell in icell.cells) {
                    if (j == 0)
                      jcell.createCellUnit("cam01", "çift cam", 90);
                    else
                      jcell.createSashCell(DrawContainer().testwin!.sashProfile,
                          "rightdouble", 8, "cam01", "çift cam", 90);
                    ++j;
                  }
                }

                print("Hücreler");
                for (final c1 in activeWindow.frame.cells) {
                  print(c1);
                  printCell(c1);
                  print(c1.unit);
                  print(c1.sash);
                  print(c1.sash.unit);
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
      for (final mullion in cell.mullions) {
        print(mullion.toString());
      }
      for (final icell in cell.cells) {
        print(icell);
        printCell(icell);
        print(icell.unit);
        print(icell.sash);
        print(icell.sash.unit);
      }
    }
  }

  createDefautUnit(List<Wincell> cells) {
    if (cells.isNotEmpty)
      for (final cell in cells) {
        cell.createCellUnit("cam01", "çift cam", 90);
        createDefautUnit(cell.cells);
      }
  }

  Widget getCanvas(Size mediaSize, double toolbarHeight) {
    Size sizeCanvas =
        Size(mediaSize.width, mediaSize.height - (toolbarHeight + menuHeight));
    return Container(
      constraints: BoxConstraints(
          maxWidth: sizeCanvas.width, maxHeight: sizeCanvas.height),
      color: Colors.grey,
    );
  }
}
