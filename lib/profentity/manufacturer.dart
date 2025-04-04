import 'dart:convert';
import 'serie.dart';

class Manufacturer {
  String name;
  List<Serie> series;
  Manufacturer({
    required this.name,
    required this.series,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'series': series.map((x) => x.toMap()).toList(),
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      name: map['name'],
      series: List<Serie>.from(map['series']?.map((x) => Serie.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() => 'Manufacturer(name: $name, series: $series)';
}
