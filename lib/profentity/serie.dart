import 'dart:convert';
import 'profile.dart';

class Serie {
  String name;
  bool isSliding;
  double sashMargin;
  List<Profile> profiles;
  Serie({
    this.name,
    this.isSliding,
    this.sashMargin,
    this.profiles,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isSliding': isSliding,
      'sashMargin': sashMargin,
      'profiles': profiles?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Serie.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Serie(
      name: map['name'],
      isSliding: map['isSliding'],
      sashMargin: map['sashMargin'],
      profiles:
          List<Profile>.from(map['profiles']?.map((x) => Profile.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Serie.fromJson(String source) => Serie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Serie(name: $name, isSliding: $isSliding, sashMargin: $sashMargin, profiles: $profiles)';
  }
}
