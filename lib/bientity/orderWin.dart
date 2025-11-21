// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
    return <String, dynamic>{
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
      pose: map['pose'] as String,
      count: map['count'] as int,
      windowsWidth: map['windowsWidth'] as double,
      windowsHeight: map['windowsHeight'] as double,
      productinfo1: map['productinfo1'] as String,
      productinfo2: map['productinfo2'] as String,
      productinfo3: map['productinfo3'] as String,
      productinfo4: map['productinfo4'] as String,
      productinfo5: map['productinfo5'] as String,
      info1: map['info1'] as String,
      info2: map['info2'] as String,
      info3: map['info3'] as String,
      info4: map['info4'] as String,
      info5: map['info5'] as String,
      win: List<PWindow>.from(
        (map['win'] as List<int>).map<PWindow>(
          (x) => PWindow.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderWin.fromJson(String source) =>
      OrderWin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderWin(pose: $pose, count: $count, windowsWidth: $windowsWidth, windowsHeight: $windowsHeight, productinfo1: $productinfo1, productinfo2: $productinfo2, productinfo3: $productinfo3, productinfo4: $productinfo4, productinfo5: $productinfo5, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, win: $win)';
  }

  @override
  bool operator ==(covariant OrderWin other) {
    if (identical(this, other)) return true;

    return other.pose == pose &&
        other.count == count &&
        other.windowsWidth == windowsWidth &&
        other.windowsHeight == windowsHeight &&
        other.productinfo1 == productinfo1 &&
        other.productinfo2 == productinfo2 &&
        other.productinfo3 == productinfo3 &&
        other.productinfo4 == productinfo4 &&
        other.productinfo5 == productinfo5 &&
        other.info1 == info1 &&
        other.info2 == info2 &&
        other.info3 == info3 &&
        other.info4 == info4 &&
        other.info5 == info5 &&
        listEquals(other.win, win);
  }

  @override
  int get hashCode {
    return pose.hashCode ^
        count.hashCode ^
        windowsWidth.hashCode ^
        windowsHeight.hashCode ^
        productinfo1.hashCode ^
        productinfo2.hashCode ^
        productinfo3.hashCode ^
        productinfo4.hashCode ^
        productinfo5.hashCode ^
        info1.hashCode ^
        info2.hashCode ^
        info3.hashCode ^
        info4.hashCode ^
        info5.hashCode ^
        win.hashCode;
  }
}
