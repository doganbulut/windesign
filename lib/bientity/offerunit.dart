import 'dart:convert';

import 'package:windesign/bientity/pricerow.dart';

class OfferUnit {
  PriceRow pricerow;
  double amount;
  double total;
  OfferUnit({
    this.pricerow,
    this.amount,
    this.total,
  });

  OfferUnit copyWith({
    PriceRow pricerow,
    double amount,
    double total,
  }) {
    return OfferUnit(
      pricerow: pricerow ?? this.pricerow,
      amount: amount ?? this.amount,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pricerow': pricerow?.toMap(),
      'amount': amount,
      'total': total,
    };
  }

  factory OfferUnit.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OfferUnit(
      pricerow: PriceRow.fromMap(map['pricerow']),
      amount: map['amount'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferUnit.fromJson(String source) =>
      OfferUnit.fromMap(json.decode(source));

  @override
  String toString() =>
      'OfferUnit(pricerow: $pricerow, amount: $amount, total: $total)';
}
