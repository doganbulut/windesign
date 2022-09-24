import 'dart:convert';
import 'package:windesign/bientity/pricerow.dart';

class PriceList {
  String name;
  String desciription;
  DateTime createDate;
  List<PriceRow> rows;
  PriceList({
    this.name,
    this.desciription,
    this.createDate,
    this.rows,
  });

  PriceList copyWith({
    String name,
    String desciription,
    DateTime createDate,
    List<PriceRow> rows,
  }) {
    return PriceList(
      name: name ?? this.name,
      desciription: desciription ?? this.desciription,
      createDate: createDate ?? this.createDate,
      rows: rows ?? this.rows,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'desciription': desciription,
      'createDate': createDate?.millisecondsSinceEpoch,
      'rows': rows?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PriceList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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
