// ignore_for_file: public_member_api_docs, sort_constructors_first
//Customer order
//all drawing
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:windesign/bientity/orderWin.dart';

class Order {
  int id;
  int customerId;
  String info1;
  String info2;
  String info3;
  String info4;
  String info5;
  DateTime date;
  List<OrderWin> winOrders;
  Order({
    required this.id,
    required this.customerId,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.info5,
    required this.date,
    required this.winOrders,
  });

  Order copyWith({
    int? id,
    int? customerId,
    String? info1,
    String? info2,
    String? info3,
    String? info4,
    String? info5,
    DateTime? date,
    List<OrderWin>? winOrders,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      info1: info1 ?? this.info1,
      info2: info2 ?? this.info2,
      info3: info3 ?? this.info3,
      info4: info4 ?? this.info4,
      info5: info5 ?? this.info5,
      date: date ?? this.date,
      winOrders: winOrders ?? this.winOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'info1': info1,
      'info2': info2,
      'info3': info3,
      'info4': info4,
      'info5': info5,
      'date': date.millisecondsSinceEpoch,
      'winOrders': winOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      customerId: map['customerId'] as int,
      info1: map['info1'] as String,
      info2: map['info2'] as String,
      info3: map['info3'] as String,
      info4: map['info4'] as String,
      info5: map['info5'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      winOrders: List<OrderWin>.from(
        (map['winOrders'] as List<int>).map<OrderWin>(
          (x) => OrderWin.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, date: $date, winOrders: $winOrders)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerId == customerId &&
        other.info1 == info1 &&
        other.info2 == info2 &&
        other.info3 == info3 &&
        other.info4 == info4 &&
        other.info5 == info5 &&
        other.date == date &&
        listEquals(other.winOrders, winOrders);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        info1.hashCode ^
        info2.hashCode ^
        info3.hashCode ^
        info4.hashCode ^
        info5.hashCode ^
        date.hashCode ^
        winOrders.hashCode;
  }
}
