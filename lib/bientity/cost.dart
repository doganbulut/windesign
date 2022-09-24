import 'dart:convert';
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
    this.id,
    this.customerCode,
    this.orderId,
    this.date,
    this.units,
    this.total,
  });

  Cost copyWith({
    int id,
    String customerCode,
    int orderId,
    DateTime date,
    List<OfferUnit> units,
    double total,
  }) {
    return Cost(
      id: id ?? this.id,
      customerCode: customerCode ?? this.customerCode,
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
      'orderId': orderId,
      'date': date?.millisecondsSinceEpoch,
      'units': units?.map((x) => x?.toMap())?.toList(),
      'total': total,
    };
  }

  factory Cost.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cost(
      id: map['id'],
      customerCode: map['customerCode'],
      orderId: map['orderId'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      units:
          List<OfferUnit>.from(map['units']?.map((x) => OfferUnit.fromMap(x))),
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cost.fromJson(String source) => Cost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cost(id: $id, customerCode: $customerCode, orderId: $orderId, date: $date, units: $units, total: $total)';
  }
}
