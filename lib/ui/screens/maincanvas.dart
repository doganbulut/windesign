import 'package:flutter/material.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:windesign/windrawer/drawcontainer.dart';
import 'package:windesign/winentity/windowobject.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  State<MainCanvas> createState() => _MainCanvasState();
}

class _MainCanvasState extends State<MainCanvas> {
  late InfiniteCanvasController controller;
  final gridSize = const Size.square(50);

  @override
  void initState() {
    super.initState();

    controller = InfiniteCanvasController(
        nodes: [], edges: [], snapMovementToGrid: true, snapResizeToGrid: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Win Designer'),
        centerTitle: false,
      ),
      body: InfiniteCanvas(
        drawVisibleOnly: true,
        canAddEdges: true,
        controller: controller,
        gridSize: gridSize,
        menus: [
          MenuEntry(
            label: 'Create',
            menuChildren: [
              MenuEntry(
                label: 'Window',
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
              MenuEntry(
                label: 'Triangle',
                onPressed: () {},
              ),
              MenuEntry(
                label: 'Rectangle',
                onPressed: () {},
              ),
            ],
          ),
          MenuEntry(
            label: 'Info',
            menuChildren: [
              MenuEntry(
                label: 'Cycle',
                onPressed: () {
                  final fd = controller.getDirectedGraph();
                  final messenger = ScaffoldMessenger.of(context);
                  final result = fd.cycle;
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                          'Cycle found: ${result.map((e) => e.key.toString()).join(', ')}'),
                    ),
                  );
                },
              ),
              MenuEntry(
                label: 'In Degree',
                onPressed: () {
                  final fd = controller.getDirectedGraph();
                  final result = fd.inDegreeMap;
                  // Show dismissible dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('In Degree'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final entry in result.entries.toList()
                                ..sort(
                                  (a, b) => b.value.compareTo(a.value),
                                ))
                                Text(
                                  '${entry.key.id}: ${entry.value}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InlineCustomPainter extends CustomPainter {
  const InlineCustomPainter({
    required this.brush,
    required this.builder,
    this.isAntiAlias = true,
  });
  final Paint brush;
  final bool isAntiAlias;
  final void Function(Paint paint, Canvas canvas, Rect rect) builder;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    brush.isAntiAlias = isAntiAlias;
    canvas.save();
    builder(brush, canvas, rect);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
