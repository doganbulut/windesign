import 'dart:convert';
import 'package:windesign/bientity/pricerow.dart';

class PriceList {
  String name;
  String desciription;
  DateTime createDate;
  List<PriceRow> rows;
  PriceList({
    required this.name,
    required this.desciription,
    required this.createDate,
    required this.rows,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'desciription': desciription,
      'createDate': createDate.millisecondsSinceEpoch,
      'rows': rows.map((x) => x.toMap()).toList(),
    };
  }

  factory PriceList.fromMap(Map<String, dynamic> map) {
    return PriceList(
      name: map['name'],
      desciription: map['desciription'],
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
      rows: List<PriceRow>.from(map['rows']?.map((x) => PriceRow.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceList.fromJson(String source) =>
      PriceList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PriceList(name: $name, desciription: $desciription, createDate: $createDate, rows: $rows)';
  }
}
