// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'offerunit.dart';

class Cost {
  int id;
  String customerCode;
  String pricelistName; //Cost
  int orderId;
  DateTime date;
  List<OfferUnit> units;
  double total;
  Cost({
    required this.id,
    required this.customerCode,
    required this.pricelistName,
    required this.orderId,
    required this.date,
    required this.units,
    required this.total,
  });

  Cost copyWith({
    int? id,
    String? customerCode,
    String? pricelistName,
    int? orderId,
    DateTime? date,
    List<OfferUnit>? units,
    double? total,
  }) {
    return Cost(
      id: id ?? this.id,
      customerCode: customerCode ?? this.customerCode,
      pricelistName: pricelistName ?? this.pricelistName,
      orderId: orderId ?? this.orderId,
      date: date ?? this.date,
      units: units ?? this.units,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerCode': customerCode,
      'pricelistName': pricelistName,
      'orderId': orderId,
      'date': date.millisecondsSinceEpoch,
      'units': units.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory Cost.fromMap(Map<String, dynamic> map) {
    return Cost(
      id: map['id'] as int,
      customerCode: map['customerCode'] as String,
      pricelistName: map['pricelistName'] as String,
      orderId: map['orderId'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      units: List<OfferUnit>.from(
        (map['units'] as List<int>).map<OfferUnit>(
          (x) => OfferUnit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cost.fromJson(String source) =>
      Cost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cost(id: $id, customerCode: $customerCode, pricelistName: $pricelistName, orderId: $orderId, date: $date, units: $units, total: $total)';
  }

  @override
  bool operator ==(covariant Cost other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerCode == customerCode &&
        other.pricelistName == pricelistName &&
        other.orderId == orderId &&
        other.date == date &&
        listEquals(other.units, units) &&
        other.total == total;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerCode.hashCode ^
        pricelistName.hashCode ^
        orderId.hashCode ^
        date.hashCode ^
        units.hashCode ^
        total.hashCode;
  }
}
