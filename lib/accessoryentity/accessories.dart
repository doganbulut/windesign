import 'dart:convert';
import 'package:windesign/accessoryentity/accessory.dart';

class Accessories {
  List<Accessory> accessorieslist;
  Accessories({
    required this.accessorieslist,
  });

  Accessories copyWith({
    required List<Accessory> accessorieslist,
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

  factory Accessories.fromMap(Map<String, dynamic> map) {
    return Accessories(
      accessorieslist: List<Accessory>.from(
          map['accessorieslist']?.map((x) => Accessory.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessories.fromJson(String source) =>
      Accessories.fromMap(json.decode(source));

  @override
  String toString() => 'Accessories(accessorieslist: $accessorieslist)';
}
