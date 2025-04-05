import 'dart:convert';
import 'package:windesign/bientity/pricerow.dart';

class PriceList {
  final String name;
  final String? description;
  final DateTime createDate;
  final List<PriceRow> rows;

  PriceList({
    required this.name,
    this.description,
    required this.createDate,
    List<PriceRow>? rows,
  }) : this.rows = rows ?? [];

  PriceList copyWith({
    String? name,
    String? description,
    DateTime? createDate,
    List<PriceRow>? rows,
  }) {
    return PriceList(
      name: name ?? this.name,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
      rows: rows ?? this.rows,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'createDate': createDate.millisecondsSinceEpoch,
      'rows': rows.map((x) => x.toMap()).toList(),
    };
  }

  factory PriceList.fromMap(Map<String, dynamic> map) {
    return PriceList(
      name: map['name'] as String,
      description: map['description'] as String?,
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int),
      rows: map['rows'] != null
          ? List<PriceRow>.from(
              (map['rows'] as List).map((x) => PriceRow.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceList.fromJson(String source) =>
      PriceList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PriceList(name: $name, description: $description, createDate: $createDate, rows: $rows)';
  }
}
