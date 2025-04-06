import 'dart:convert';
import 'package:windesign/winentity/window.dart';

class OrderWin {
  final String? pose;
  final int count;
  final double windowsWidth;
  final double windowsHeight;
  final String? productinfo1;
  final String? productinfo2;
  final String? productinfo3;
  final String? productinfo4;
  final String? productinfo5;
  final String? info1;
  final String? info2;
  final String? info3;
  final String? info4;
  final String? info5;
  final List<PWindow> win;

  OrderWin({
    this.pose,
    required this.count,
    required this.windowsWidth,
    required this.windowsHeight,
    this.productinfo1,
    this.productinfo2,
    this.productinfo3,
    this.productinfo4,
    this.productinfo5,
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    List<PWindow>? win,
  }) : win = win ?? [];

  OrderWin copyWith({
    String? pose,
    int? count,
    double? windowsWidth,
    double? windowsHeight,
    String? productinfo1,
    String? productinfo2,
    String? productinfo3,
    String? productinfo4,
    String? productinfo5,
    String? info1,
    String? info2,
    String? info3,
    String? info4,
    String? info5,
    List<PWindow>? win,
  }) {
    return OrderWin(
      pose: pose ?? this.pose,
      count: count ?? this.count,
      windowsWidth: windowsWidth ?? this.windowsWidth,
      windowsHeight: windowsHeight ?? this.windowsHeight,
      productinfo1: productinfo1 ?? this.productinfo1,
      productinfo2: productinfo2 ?? this.productinfo2,
      productinfo3: productinfo3 ?? this.productinfo3,
      productinfo4: productinfo4 ?? this.productinfo4,
      productinfo5: productinfo5 ?? this.productinfo5,
      info1: info1 ?? this.info1,
      info2: info2 ?? this.info2,
      info3: info3 ?? this.info3,
      info4: info4 ?? this.info4,
      info5: info5 ?? this.info5,
      win: win ?? this.win,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pose': pose,
      'count': count,
      'windowsWidth': windowsWidth,
      'windowsHeight': windowsHeight,
      'productinfo1': productinfo1,
      'productinfo2': productinfo2,
      'productinfo3': productinfo3,
      'productinfo4': productinfo4,
      'productinfo5': productinfo5,
      'info1': info1,
      'info2': info2,
      'info3': info3,
      'info4': info4,
      'info5': info5,
      'win': win.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderWin.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? winMaps = map['win'];
    List<PWindow> win = [];
    if (winMaps != null && winMaps.isNotEmpty) {
      win = winMaps.map((x) => PWindow.fromMap(x)).toList();
    }

    return OrderWin(
      pose: map['pose'],
      count: map['count'] ?? 0,
      windowsWidth: map['windowsWidth'] ?? 0.0,
      windowsHeight: map['windowsHeight'] ?? 0.0,
      productinfo1: map['productinfo1'],
      productinfo2: map['productinfo2'],
      productinfo3: map['productinfo3'],
      productinfo4: map['productinfo4'],
      productinfo5: map['productinfo5'],
      info1: map['info1'],
      info2: map['info2'],
      info3: map['info3'],
      info4: map['info4'],
      info5: map['info5'],
      win: win,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderWin.fromJson(String source) =>
      OrderWin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderWin(pose: $pose, count: $count, windowsWidth: $windowsWidth, windowsHeight: $windowsHeight, productinfo1: $productinfo1, productinfo2: $productinfo2, productinfo3: $productinfo3, productinfo4: $productinfo4, productinfo5: $productinfo5, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, win: $win)';
  }
}
