//Customer order
//all drawing
import 'dart:convert';
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
    this.id,
    this.customerId,
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    this.date,
    this.winOrders,
  });

  Order copyWith({
    int id,
    int customerId,
    String info1,
    String info2,
    String info3,
    String info4,
    String info5,
    DateTime date,
    List<OrderWin> winOrders,
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
    return {
      'id': id,
      'customerId': customerId,
      'info1': info1,
      'info2': info2,
      'info3': info3,
      'info4': info4,
      'info5': info5,
      'date': date?.millisecondsSinceEpoch,
      'winOrders': winOrders?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      id: map['id'],
      customerId: map['customerId'],
      info1: map['info1'],
      info2: map['info2'],
      info3: map['info3'],
      info4: map['info4'],
      info5: map['info5'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      winOrders: List<OrderWin>.from(
          map['winOrders']?.map((x) => OrderWin.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, date: $date, winOrders: $winOrders)';
  }
}
