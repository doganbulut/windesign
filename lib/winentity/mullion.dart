import 'dart:convert';

import 'direction.dart';
import 'part.dart';

class Mullion {
  final int order;
  final Direction direction;
  double? len;
  final double position;
  final double cellposition;
  final Part part;

  Mullion({
    required this.order,
    required this.direction,
    required this.len,
    required this.position,
    required this.cellposition,
    required this.part,
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

  Mullion copyWith({
    int? order,
    Direction? direction,
    double? len,
    double? position,
    double? cellposition,
    Part? part,
  }) {
    return Mullion(
      order: order ?? this.order,
      direction: direction ?? this.direction,
      len: len ?? this.len,
      position: position ?? this.position,
      cellposition: cellposition ?? this.cellposition,
      part: part ?? this.part,
    );
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
      order: map['order'] as int,
      direction: directionValues.map[map['direction']] as Direction,
      len: map['len'] as double,
      position: map['position'] as double,
      cellposition: map['cellposition'] as double,
      part: Part.fromMap(map['part']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Mullion.fromJson(String source) =>
      Mullion.fromMap(json.decode(source));
}
