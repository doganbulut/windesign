import 'dart:convert';
import 'package:windesign/accessoryentity/accessory.dart';

class Accessories {
  final List<Accessory> accessorieslist;

  Accessories({
    List<Accessory>? accessorieslist,
  }) : accessorieslist = accessorieslist ?? [];

  Accessories copyWith({
    List<Accessory>? accessorieslist,
  }) {
    return Accessories(
      accessorieslist: accessorieslist ?? this.accessorieslist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessorieslist': accessorieslist.map((x) => x.toMap()).toList(),
    };
  }

  factory Accessories.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Accessories();
    }

    List<dynamic>? accessoryMaps = map['accessorieslist'];
    if (accessoryMaps == null || accessoryMaps.isEmpty) {
      return Accessories();
    }

    return Accessories(
      accessorieslist: accessoryMaps
          .map((x) => Accessory.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessories.fromJson(String source) =>
      Accessories.fromMap(json.decode(source));

  @override
  String toString() => 'Accessories(accessorieslist: $accessorieslist)';
}
