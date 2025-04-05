import 'dart:convert';
import 'serie.dart';

class Manufacturer {
  final String name;
  final List<Serie> series;

  Manufacturer({
    required this.name,
    List<Serie>? series,
  }) : this.series = series ?? [];

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
    return {
      'name': name,
      'series': series.map((x) => x.toMap()).toList(),
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      name: map['name'] as String,
      series: map['series'] != null
          ? List<Serie>.from(
              (map['series'] as List).map((x) => Serie.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() => 'Manufacturer(name: $name, series: $series)';
}
