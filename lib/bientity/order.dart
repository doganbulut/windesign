import 'dart:convert';
import 'package:windesign/bientity/orderWin.dart';

class Order {
  final int? id;
  final int customerId;
  final String? info1;
  final String? info2;
  final String? info3;
  final String? info4;
  final String? info5;
  final DateTime date;
  final List<OrderWin> winOrders;

  Order({
    this.id,
    required this.customerId,
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    required this.date,
    List<OrderWin>? winOrders,
  }) : winOrders = winOrders ?? [];

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

  factory Order.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? winOrderMaps = map['winOrders'];
    List<OrderWin> winOrders = [];
    if (winOrderMaps != null && winOrderMaps.isNotEmpty) {
      winOrders = winOrderMaps.map((x) => OrderWin.fromMap(x)).toList();
    }

    return Order(
      id: map['id'],
      customerId: map['customerId'] ?? 0,
      info1: map['info1'],
      info2: map['info2'],
      info3: map['info3'],
      info4: map['info4'],
      info5: map['info5'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
      winOrders: winOrders,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, info1: $info1, info2: $info2, info3: $info3, info4: $info4, info5: $info5, date: $date, winOrders: $winOrders)';
  }
}
