import 'dart:convert';
import 'package:windesign/bientity/pricerow.dart';

class PriceList {
  final String name;
  final String description;
  final DateTime createDate;
  final List<PriceRow> rows;

  PriceList({
    required this.name,
    required this.description,
    required this.createDate,
    List<PriceRow>? rows,
  }) : rows = rows ?? [];

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

  factory PriceList.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? rowMaps = map['rows'];
    List<PriceRow> rows = [];
    if (rowMaps != null && rowMaps.isNotEmpty) {
      rows = rowMaps.map((x) => PriceRow.fromMap(x)).toList();
    }

    return PriceList(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate'] ?? 0),
      rows: rows,
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
