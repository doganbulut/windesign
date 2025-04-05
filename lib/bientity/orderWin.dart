import 'dart:convert';
import 'package:windesign/winentity/windowobject.dart';

class OrderWin {
  String? pose;
  int? count;
  double? windowsWidth;
  double? windowsHeight;
  String? productinfo1;
  String? productinfo2;
  String? productinfo3;
  String? productinfo4;
  String? productinfo5;
  String? info1;
  String? info2;
  String? info3;
  String? info4;
  String? info5;
  List<WindowObject>? win;
  OrderWin({
    this.pose,
    this.count,
    this.windowsWidth,
    this.windowsHeight,
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
    this.win,
  });

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
    List<WindowObject>? win,
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
      'win': win?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderWin.fromMap(Map<String, dynamic> map) {
    return OrderWin(
      pose: map['pose'] as String?,
      count: map['count'] as int?,
      windowsWidth: map['windowsWidth'] as double?,
      windowsHeight: map['windowsHeight'] as double?,
      productinfo1: map['productinfo1'] as String?,
      productinfo2: map['productinfo2'] as String?,
      productinfo3: map['productinfo3'] as String?,
      productinfo4: map['productinfo4'] as String?,
      productinfo5: map['productinfo5'] as String?,
      info1: map['info1'] as String?,
      info2: map['info2'] as String?,
      info3: map['info3'] as String?,
      info4: map['info4'] as String?,
      info5: map['info5'] as String?,
      win: map['win'] != null
          ? List<WindowObject>.from(
              map['win']?.map((x) => WindowObject.fromMap(x)) as Iterable)
          : null,
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
