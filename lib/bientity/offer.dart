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
  Map<String, dynamic> toMap() {
    return {
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
