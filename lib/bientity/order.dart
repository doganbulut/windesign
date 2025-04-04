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

  Map<String, dynamic> toMap() {
    return {
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
