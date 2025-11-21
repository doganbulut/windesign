// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'direction.dart';
import 'part.dart';

class Mullion {
  late int order;
  late Direction direction;
  late double len;
  late double position;
  late double cellposition;
  late Part part;
  Mullion({
    int? order,
    Direction? direction,
    double? len,
    double? position,
    double? cellposition,
    Part? part,
  }) {
    if (order != null) this.order = order;
    if (direction != null) this.direction = direction;
    if (len != null) this.len = len;
    if (position != null) this.position = position;
    if (cellposition != null) this.cellposition = cellposition;
    if (part != null) this.part = part;
  }

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
      'part': part.toMap(),
    };
  }

  factory Mullion.fromMap(Map<String, dynamic> map) {
    return Mullion(
      order: map['order'],
      direction: directionValues.map[map['direction']]!,
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
