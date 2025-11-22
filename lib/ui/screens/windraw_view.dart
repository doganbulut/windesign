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
  String data = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('WinDesign Studio'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Toolbar
          Container(
            height: 70,
            width: double.infinity,
            color: theme.colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildToolButton(Icons.add_box_outlined, "New Window", () {
                  _showNewWindowDialog();
                }),
                SizedBox(width: 16),
                _buildToolButton(Icons.grid_on, "Add Mullion", () {
                  if (WinDraw().windows.isEmpty) return;
                  
                  var pWindow = WinDraw().activeWindow;
                  pWindow.calculateWinParts();
                  pWindow.frame.addVerticalCenterMullion(
                      WinDraw().testwin.mullionProfile, 2);
                  pWindow.frame.computeVerticalMullion();
                  pWindow.frame.computeCells();
                  
                  // Add horizontal mullions to cells
                  for (var icell in pWindow.frame.cells) {
                    icell.addHorizontalMullion(
                        WinDraw().testwin.mullionProfile, [500]);
                    icell.computeHorizontalMullion();
                    icell.computeCells();
                  }

                  // Add sashes
                  for (var icell in pWindow.frame.cells) {
                    var j = 0;
                    for (var jcell in icell.cells) {
                      if (j == 0)
                        jcell.createCellUnit("cam01", "çift cam", 90);
                      else
                        jcell.createSashCell(WinDraw().testwin.sashProfile,
                            "rightdouble", 8, "cam01", "çift cam", 90);
                      ++j;
                    }
                  }
                  setState(() {});
                }),
                SizedBox(width: 16),
                _buildToolButton(Icons.save, "Save JSON", () {
                  data = WinDraw().toJson();
                  print(data);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved to memory")));
                }),
                SizedBox(width: 16),
                _buildToolButton(Icons.file_upload, "Load JSON", () {
                  if (data.isNotEmpty) {
                    WinDraw().fromJson(data);
                    if (WinDraw().windows.isNotEmpty) {
                      WinDraw().activeWindow = WinDraw().windows[0];
                    }
                    setState(() {});
                  }
                }),
                Spacer(),
                _buildToolButton(Icons.delete_outline, "Clear", () {
                  WinDraw().windows.clear();
                  setState(() {});
                }),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1),
          // Main Content Area
          Expanded(
            child: Container(
              color: theme.colorScheme.background,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: WinPainter(context),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(IconData icon, String tooltip, VoidCallback onPressed) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Text(value),
          ),
        ),
      ],
    );
  }

  Future<void> _showNewWindowDialog() async {
    final widthController = TextEditingController();
    final heightController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Window'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: widthController,
                decoration: const InputDecoration(labelText: 'Width (mm)', hintText: '3000'),
                keyboardType: TextInputType.number,
                autofocus: true,
              ),
              TextField(
                controller: heightController,
                decoration: const InputDecoration(labelText: 'Height (mm)', hintText: '1500'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                double width = double.tryParse(widthController.text) ?? 3000;
                double height = double.tryParse(heightController.text) ?? 1500;
                
                var frameProfile = WinDraw().testwin.frameProfile;
                WinDraw().windows.clear();
                var window = new PWindow.create(2, 1, frameProfile, width, height);
                WinDraw().windows.add(window);
                WinDraw().activeWindow = window;
                var pWindow = WinDraw().activeWindow;
                pWindow.calculateWinParts();
                pWindow.frame.computeCells();
                setState(() {});
                
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
