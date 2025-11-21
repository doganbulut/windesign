// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:windesign/bientity/pricerow.dart';

class OfferUnit {
  PriceRow pricerow;
  double amount;
  double total;
  OfferUnit({
    required this.pricerow,
    required this.amount,
    required this.total,
  });

  OfferUnit copyWith({
    PriceRow? pricerow,
    double? amount,
    double? total,
  }) {
    return OfferUnit(
      pricerow: pricerow ?? this.pricerow,
      amount: amount ?? this.amount,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pricerow': pricerow.toMap(),
      'amount': amount,
      'total': total,
    };
  }

  factory OfferUnit.fromMap(Map<String, dynamic> map) {
    return OfferUnit(
      pricerow: PriceRow.fromMap(map['pricerow'] as Map<String, dynamic>),
      amount: map['amount'] as double,
      total: map['total'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferUnit.fromJson(String source) =>
      OfferUnit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OfferUnit(pricerow: $pricerow, amount: $amount, total: $total)';

  @override
  bool operator ==(covariant OfferUnit other) {
    if (identical(this, other)) return true;

    return other.pricerow == pricerow &&
        other.amount == amount &&
        other.total == total;
  }

  @override
  int get hashCode => pricerow.hashCode ^ amount.hashCode ^ total.hashCode;
}
