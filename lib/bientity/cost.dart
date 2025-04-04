import 'dart:convert';
import 'offerunit.dart';

class Cost {
  int id;
  String customerCode;
  String pricelistName;
  int orderId;
  DateTime date;
  List<OfferUnit> units;
  double total;
  Cost({
    required this.id,
    required this.customerCode,
    required this.orderId,
    required this.date,
    required this.units,
    required this.total,
    required this.pricelistName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerCode': customerCode,
      'orderId': orderId,
      'date': date.millisecondsSinceEpoch,
      'units': units.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory Cost.fromMap(Map<String, dynamic> map) {
    return Cost(
      id: map['id'],
      customerCode: map['customerCode'],
      orderId: map['orderId'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      units:
          List<OfferUnit>.from(map['units']?.map((x) => OfferUnit.fromMap(x))),
      total: map['total'],
      pricelistName: map['pricelistName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cost.fromJson(String source) => Cost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cost(id: $id, customerCode: $customerCode, orderId: $orderId, date: $date, units: $units, total: $total)';
  }
}
