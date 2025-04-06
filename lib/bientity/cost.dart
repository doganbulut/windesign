import 'dart:convert';
import 'offerunit.dart';

class Cost {
  final int? id;
  final String customerCode;
  final String pricelistName;
  final int orderId;
  final DateTime date;
  final List<OfferUnit> units;
  final double total;

  Cost({
    this.id,
    required this.customerCode,
    required this.pricelistName,
    required this.orderId,
    required this.date,
    List<OfferUnit>? units,
    required this.total,
  }) : units = units ?? [];

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
    return {
      'id': id,
      'customerCode': customerCode,
      'pricelistName': pricelistName,
      'orderId': orderId,
      'date': date.millisecondsSinceEpoch,
      'units': units.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory Cost.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? unitMaps = map['units'];
    List<OfferUnit> units = [];
    if (unitMaps != null && unitMaps.isNotEmpty) {
      units = unitMaps.map((x) => OfferUnit.fromMap(x)).toList();
    }

    return Cost(
      id: map['id'],
      customerCode: map['customerCode'] ?? '',
      pricelistName: map['pricelistName'] ?? '',
      orderId: map['orderId'] ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
      units: units,
      total: map['total'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cost.fromJson(String source) => Cost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cost(id: $id, customerCode: $customerCode, pricelistName: $pricelistName, orderId: $orderId, date: $date, units: $units, total: $total)';
  }
}
