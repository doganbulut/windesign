import 'dart:convert';

import 'direction.dart';
import 'part.dart';

class Mullion {
  int order;
  Direction direction;
  double len;
  double position;
  double cellposition;
  Part part;
  Mullion({
    this.order,
    this.direction,
    this.len,
    this.position,
    this.cellposition,
    this.part,
  });

  @override
  String toString() {
    return "Mullion: " +
        order.toString() +
        " Len: " +
        len.toString() +
        " direction: " +
        direction.toString() +
        " position: " +
        position.toString() +
        " cellposition: " +
        cellposition.toString() +
        " part: " +
        part.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'order': order,
      'direction': directionValues.reverse[direction],
      'len': len,
      'position': position,
      'cellposition': cellposition,
      'part': part?.toMap(),
    };
  }

  factory Mullion.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Mullion(
      order: map['order'],
      direction: directionValues.map[map['direction']],
      len: map['len'],
      position: map['position'],
      cellposition: map['cellposition'],
      part: Part.fromMap(map['part']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Mullion.fromJson(String source) =>
      Mullion.fromMap(json.decode(source));
}
