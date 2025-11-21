// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'serie.dart';

class Manufacturer {
  String name;
  List<Serie> series;
  Manufacturer({
    required this.name,
    required this.series,
  });

  Manufacturer copyWith({
    String? name,
    List<Serie>? series,
  }) {
    return Manufacturer(
      name: name ?? this.name,
      series: series ?? this.series,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'series': series.map((x) => x.toMap()).toList(),
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      name: map['name'] as String,
      series: List<Serie>.from(
        (map['series'] as List<int>).map<Serie>(
          (x) => Serie.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Manufacturer(name: $name, series: $series)';

  @override
  bool operator ==(covariant Manufacturer other) {
    if (identical(this, other)) return true;

    return other.name == name && listEquals(other.series, series);
  }

  @override
  int get hashCode => name.hashCode ^ series.hashCode;
}
