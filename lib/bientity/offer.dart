// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:windesign/bientity/offerunit.dart';

class Offer {
  int id;
  String customerCode;
  String pricelistName;
  int orderId;
  DateTime date;
  List<OfferUnit> units;
  double discountPercent;
  double discountAmount;
  double total;
  Offer({
    required this.id,
    required this.customerCode,
    required this.pricelistName,
    required this.orderId,
    required this.date,
    required this.units,
    required this.discountPercent,
    required this.discountAmount,
    required this.total,
  });

  Offer copyWith({
    int? id,
    String? customerCode,
    String? pricelistName,
    int? orderId,
    DateTime? date,
    List<OfferUnit>? units,
    double? discountPercent,
    double? discountAmount,
    double? total,
  }) {
    return Offer(
      id: id ?? this.id,
      customerCode: customerCode ?? this.customerCode,
      pricelistName: pricelistName ?? this.pricelistName,
      orderId: orderId ?? this.orderId,
      date: date ?? this.date,
      units: units ?? this.units,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
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
      'discountPercent': discountPercent,
      'discountAmount': discountAmount,
      'total': total,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
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
      discountPercent: map['discountPercent'] as double,
      discountAmount: map['discountAmount'] as double,
      total: map['total'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) =>
      Offer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Offer(id: $id, customerCode: $customerCode, pricelistName: $pricelistName, orderId: $orderId, date: $date, units: $units, discountPercent: $discountPercent, discountAmount: $discountAmount, total: $total)';
  }

  @override
  bool operator ==(covariant Offer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerCode == customerCode &&
        other.pricelistName == pricelistName &&
        other.orderId == orderId &&
        other.date == date &&
        listEquals(other.units, units) &&
        other.discountPercent == discountPercent &&
        other.discountAmount == discountAmount &&
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
        discountPercent.hashCode ^
        discountAmount.hashCode ^
        total.hashCode;
  }
}
