import 'dart:convert';
import 'package:windesign/winentity/window.dart';

class OrderWin {
  String pose;
  int count;
  double windowsWidth = 0;
  double windowsHeight = 0;
  String productinfo1;
  String productinfo2;
  String productinfo3;
  String productinfo4;
  String productinfo5;
  String info1;
  String info2;
  String info3;
  String info4;
  String info5;
  List<PWindow> win;
  OrderWin({
    required this.pose,
    required this.count,
    required this.windowsWidth,
    required this.windowsHeight,
    required this.productinfo1,
    required this.productinfo2,
    required this.productinfo3,
    required this.productinfo4,
    required this.productinfo5,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.info5,
    required this.win,
  });

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

  factory OrderWin.fromMap(Map<String, dynamic> map) {
    return OrderWin(
      pose: map['pose'],
      count: map['count'],
      windowsWidth: map['windowsWidth'],
      windowsHeight: map['windowsHeight'],
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
      win: List<PWindow>.from(map['win']?.map((x) => PWindow.fromMap(x))),
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
