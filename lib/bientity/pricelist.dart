// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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

  PriceList copyWith({
    String? name,
    String? desciription,
    DateTime? createDate,
    List<PriceRow>? rows,
  }) {
    return PriceList(
      name: name ?? this.name,
      desciription: desciription ?? this.desciription,
      createDate: createDate ?? this.createDate,
      rows: rows ?? this.rows,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'desciription': desciription,
      'createDate': createDate.millisecondsSinceEpoch,
      'rows': rows.map((x) => x.toMap()).toList(),
    };
  }

  factory PriceList.fromMap(Map<String, dynamic> map) {
    return PriceList(
      name: map['name'] as String,
      desciription: map['desciription'] as String,
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int),
      rows: List<PriceRow>.from(
        (map['rows'] as List<int>).map<PriceRow>(
          (x) => PriceRow.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceList.fromJson(String source) =>
      PriceList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PriceList(name: $name, desciription: $desciription, createDate: $createDate, rows: $rows)';
  }

  @override
  bool operator ==(covariant PriceList other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.desciription == desciription &&
        other.createDate == createDate &&
        listEquals(other.rows, rows);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        desciription.hashCode ^
        createDate.hashCode ^
        rows.hashCode;
  }
}
