// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'profile.dart';

class Serie {
  String name;
  bool isSliding;
  double sashMargin;
  List<Profile> profiles;
  Serie({
    required this.name,
    required this.isSliding,
    required this.sashMargin,
    required this.profiles,
  });

  Serie copyWith({
    String? name,
    bool? isSliding,
    double? sashMargin,
    List<Profile>? profiles,
  }) {
    return Serie(
      name: name ?? this.name,
      isSliding: isSliding ?? this.isSliding,
      sashMargin: sashMargin ?? this.sashMargin,
      profiles: profiles ?? this.profiles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isSliding': isSliding,
      'sashMargin': sashMargin,
      'profiles': profiles.map((x) => x.toMap()).toList(),
    };
  }

  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(
      name: map['name'] as String,
      isSliding: map['isSliding'] as bool,
      sashMargin: map['sashMargin'] as double,
      profiles: List<Profile>.from(
        (map['profiles'] as List<int>).map<Profile>(
          (x) => Profile.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Serie.fromJson(String source) =>
      Serie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Serie(name: $name, isSliding: $isSliding, sashMargin: $sashMargin, profiles: $profiles)';
  }

  @override
  bool operator ==(covariant Serie other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.isSliding == isSliding &&
        other.sashMargin == sashMargin &&
        listEquals(other.profiles, profiles);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        isSliding.hashCode ^
        sashMargin.hashCode ^
        profiles.hashCode;
  }
}
