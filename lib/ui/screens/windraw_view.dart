import 'package:flutter/material.dart';
import 'package:windesign/windrawer/windraw.dart';
import 'package:windesign/windrawer/winpainter.dart';
import 'package:windesign/winentity/wincell.dart';
import 'package:windesign/winentity/window.dart';

class WinDrawView extends StatefulWidget {
  const WinDrawView({required Key key}) : super(key: key);

  @override
  _WinDrawViewState createState() => _WinDrawViewState();
}

class _WinDrawViewState extends State<WinDrawView> {
  final double toolbarHeight = 50;
  final double menuHeight = 56;
  WinPainter? winPainter;
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
                /** */
                WindowLayoutManager().initializeTestWindows();
                var frameProfile =
                    WindowLayoutManager().windowTestData!.frameProfile;
                WindowLayoutManager().windowList.clear();
                var window =
                    new PWindow.create(2, 1, frameProfile!, 3000, 1500);
                WindowLayoutManager().windowList.add(window);
                WindowLayoutManager().activeWindow = window;
                var pWindow = WindowLayoutManager().activeWindow;
                pWindow!.calculateWinParts();
                pWindow.frame.computeCells();
                //pWindow.frame.createCellUnit("cam01", "çift cam", 90);
                print(pWindow.toString());
              },
            ),
            TextButton(
              child: Text('Change Size'),
              onPressed: () {
                /** */
                var pWindow = WindowLayoutManager().activeWindow;
                pWindow!.width = 3000;
                pWindow.height = 2000;
                pWindow.calculateWinParts();
                pWindow.frame.computeVerticalMullion();
                pWindow.frame.computeCells();
                print(pWindow.toString());
              },
            ),
            TextButton(
              child: Text('Json'),
              onPressed: () {
                /** */
                var pWindow = WindowLayoutManager().activeWindow;
                String pdata = pWindow!.toJson();
                var zwindow = PWindow.fromJson(pdata);
                WindowLayoutManager().windowList.clear();
                WindowLayoutManager().windowList.add(zwindow);
                WindowLayoutManager().activeWindow = zwindow;

                //pWindow.frame.createCellUnit("cam01", "çift cam", 90);
                print(zwindow.toString());
              },
            ),
            TextButton(
              child: Text('Json2'),
              onPressed: () {
                /** */
                data = WindowLayoutManager().toJson();
                print(data);
                WindowLayoutManager().windowList.clear();
                //pWindow.frame.createCellUnit("cam01", "çift cam", 90);
                //print(zwindow.toString());
              },
            ),
            TextButton(
              child: Text('Json3'),
              onPressed: () {
                /** */
                WindowLayoutManager().fromJson(data);
                WindowLayoutManager().activeWindow =
                    WindowLayoutManager().windowList[0];
                //pWindow.frame.createCellUnit("cam01", "çift cam", 90);
                //print(zwindow.toString());
              },
            ),
            TextButton(
              child: Text('Json4'),
              onPressed: () {
                /** */
                WindowLayoutManager().fromJson(data);
                WindowLayoutManager().activeWindow =
                    WindowLayoutManager().windowList[0];
                //pWindow.frame.createCellUnit("cam01", "çift cam", 90);
                //print(zwindow.toString());
              },
            ),
            TextButton(
              child: Text('Add Mullion'),
              onPressed: () {
                /** */
                var pWindow = WindowLayoutManager().activeWindow;
                pWindow!.calculateWinParts();
                pWindow.frame.addVerticalCenterMullion(
                    WindowLayoutManager().windowTestData!.mullionProfile!, 2);
                pWindow.frame.computeVerticalMullion();
                pWindow.frame.computeCells();
                //createDefautUnit(pWindow.frame.cells);
                //pWindow.frame.createCellUnit("cam01", "çift cam", 90);
                for (var icell in pWindow.frame.cells) {
                  icell.addHorizontalMullion(
                      WindowLayoutManager().windowTestData!.mullionProfile!,
                      [500]);
                  icell.computeHorizontalMullion();
                  icell.computeCells();
                }

                for (var icell in pWindow.frame.cells) {
                  var j = 0;
                  for (var jcell in icell.cells) {
                    if (j == 0)
                      jcell.createCellUnit("cam01", "çift cam", 90);
                    else
                      jcell.createSashCell(
                          WindowLayoutManager().windowTestData!.sashProfile!,
                          "rightdouble",
                          8,
                          "cam01",
                          "çift cam",
                          90);
                    ++j;
                  }
                }

                print("Hücreler");
                for (var c1 in pWindow.frame.cells) {
                  print(c1);
                  printCell(c1);
                  if (c1.unit != null) print(c1.unit);
                  if (c1.sash != null) {
                    print(c1.sash);
                    print(c1.sash!.unit);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  printCell(Wincell cell) {
    if (cell.cells.length != 0) {
      for (var mullion in cell.mullions) {
        print(mullion.toString());
      }
      for (var icell in cell.cells) {
        print(icell);
        printCell(icell);
        if (icell.unit != null) {
          print(icell.unit);
        }
        if (icell.sash != null) {
          print(icell.sash);
          print(icell.sash!.unit);
        }
      }
    }
  }

  createDefautUnit(List<Wincell> cells) {
    if (cells.isNotEmpty)
      for (var cell in cells) {
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
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          print("Tapped at: ${details.localPosition}");
          // Handle tap events here
        },
        child: CustomPaint(
            size: sizeCanvas, painter: this.winPainter = WinPainter(context)),
      ),
    );
  }
}
