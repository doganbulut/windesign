import 'dart:convert';

import 'direction.dart';
import 'part.dart';

class Mullion {
  int? order;
  Direction? direction;
  double? len;
  double? position;
  double? cellposition;
  Part? part;

  Mullion({
    this.order,
    this.direction,
    this.len,
    this.position,
    this.cellposition,
    this.part,
    required String name,
    required String code,
  });

  @override
  String toString() {
    return "Mullion: order: $order, Len: $len, direction: $direction, position: $position, cellposition: $cellposition, part: $part";
  }

  Map<String, dynamic> toMap() {
    if (part == null) {
      print("part is null");
      return {}; // Return an empty map instead of null
    }
    return {
      'order': order,
      'direction': directionValues.reverse[direction],
      'len': len,
      'position': position,
      'cellposition': cellposition,
      'part': part!.toMap(), // Use null-aware operator
    };
  }

  factory Mullion.fromMap(Map<String, dynamic> map) {
    return Mullion(
      order: map['order'] as int?,
      direction: directionValues.map[map['direction'] as String?],
      len: map['len'] as double?,
      position: map['position'] as double?,
      cellposition: map['cellposition'] as double?,
      part: map['part'] != null
          ? Part.fromMap(map['part'] as Map<String, dynamic>)
          : null,
      name: '',
      code: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Mullion.fromJson(String source) =>
      Mullion.fromMap(json.decode(source) as Map<String, dynamic>);
}
