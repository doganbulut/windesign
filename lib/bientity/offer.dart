import 'dart:convert';
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
    this.id,
    this.customerCode,
    this.pricelistName,
    this.orderId,
    this.date,
    this.units,
    this.discountPercent,
    this.discountAmount,
    this.total,
  });

  Offer copyWith({
    int id,
    String customerCode,
    String pricelistName,
    int orderId,
    DateTime date,
    List<OfferUnit> units,
    double discountPercent,
    double discountAmount,
    double total,
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
    return {
      'id': id,
      'customerCode': customerCode,
      'pricelistName': pricelistName,
      'orderId': orderId,
      'date': date?.millisecondsSinceEpoch,
      'units': units?.map((x) => x?.toMap())?.toList(),
      'discountPercent': discountPercent,
      'discountAmount': discountAmount,
      'total': total,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Offer(
      id: map['id'],
      customerCode: map['customerCode'],
      pricelistName: map['pricelistName'],
      orderId: map['orderId'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      units:
          List<OfferUnit>.from(map['units']?.map((x) => OfferUnit.fromMap(x))),
      discountPercent: map['discountPercent'],
      discountAmount: map['discountAmount'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Offer(id: $id, customerCode: $customerCode, pricelistName: $pricelistName, orderId: $orderId, date: $date, units: $units, discountPercent: $discountPercent, discountAmount: $discountAmount, total: $total)';
  }
}
