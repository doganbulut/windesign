import 'dart:convert';
import 'package:windesign/bientity/offerunit.dart';

class Offer {
  final int? id;
  final String customerCode;
  final String pricelistName;
  final int orderId;
  final DateTime date;
  final List<OfferUnit> units;
  final double discountPercent;
  final double discountAmount;
  final double total;

  Offer({
    this.id,
    required this.customerCode,
    required this.pricelistName,
    required this.orderId,
    required this.date,
    List<OfferUnit>? units,
    required this.discountPercent,
    required this.discountAmount,
    required this.total,
  }) : units = units ?? [];

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

  factory Offer.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? unitMaps = map['units'];
    List<OfferUnit> units = [];
    if (unitMaps != null && unitMaps.isNotEmpty) {
      units = unitMaps.map((x) => OfferUnit.fromMap(x)).toList();
    }

    return Offer(
      id: map['id'],
      customerCode: map['customerCode'] ?? '',
      pricelistName: map['pricelistName'] ?? '',
      orderId: map['orderId'] ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
      units: units,
      discountPercent: map['discountPercent'] ?? 0.0,
      discountAmount: map['discountAmount'] ?? 0.0,
      total: map['total'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Offer(id: $id, customerCode: $customerCode, pricelistName: $pricelistName, orderId: $orderId, date: $date, units: $units, discountPercent: $discountPercent, discountAmount: $discountAmount, total: $total)';
  }
}
