import 'dart:convert';
import 'package:windesign/winentity/direction.dart';
import 'package:windesign/winentity/part.dart';

class Mullion {
  final int order;
  final Direction direction;
  final double len;
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

  factory Mullion.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    if (map['part'] == null) {
      throw ArgumentError("Part cannot be null");
    }

    return Mullion(
      order: map['order'] ?? 0,
      direction: directionValues.map[map['direction']] ?? Direction.horizontal,
      len: map['len'] ?? 0.0,
      position: map['position'] ?? 0.0,
      cellposition: map['cellposition'] ?? 0.0,
      part: Part.fromMap(map['part']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Mullion.fromJson(String source) =>
      Mullion.fromMap(json.decode(source));
}
