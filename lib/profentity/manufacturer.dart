import 'dart:convert';
import 'serie.dart';

class Manufacturer {
  final String name;
  final List<Serie> series;

  Manufacturer({
    required this.name,
    List<Serie>? series,
  }) : series = series ?? [];

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

  factory Manufacturer.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? serieMaps = map['series'];
    List<Serie> series = [];
    if (serieMaps != null && serieMaps.isNotEmpty) {
      series = serieMaps.map((x) => Serie.fromMap(x)).toList();
    }

    return Manufacturer(
      name: map['name'] ?? '',
      series: series,
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() => 'Manufacturer(name: $name, series: $series)';
}
