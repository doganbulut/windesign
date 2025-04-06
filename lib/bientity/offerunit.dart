import 'dart:convert';
import 'package:windesign/bientity/pricerow.dart';

class OfferUnit {
  final PriceRow pricerow;
  final double amount;
  final double total;

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
    return {
      'pricerow': pricerow.toMap(),
      'amount': amount,
      'total': total,
    };
  }

  factory OfferUnit.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    if (map['pricerow'] == null) {
      throw ArgumentError("PriceRow cannot be null");
    }

    return OfferUnit(
      pricerow: PriceRow.fromMap(map['pricerow']),
      amount: map['amount'] ?? 0.0,
      total: map['total'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferUnit.fromJson(String source) =>
      OfferUnit.fromMap(json.decode(source));

  @override
  String toString() =>
      'OfferUnit(pricerow: $pricerow, amount: $amount, total: $total)';
}
