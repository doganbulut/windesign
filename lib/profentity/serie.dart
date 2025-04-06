import 'dart:convert';
import 'profile.dart';

class Serie {
  final String name;
  final bool isSliding;
  final double sashMargin;
  final List<Profile> profiles;

  Serie({
    required this.name,
    required this.isSliding,
    required this.sashMargin,
    List<Profile>? profiles,
  }) : profiles = profiles ?? [];

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
    return {
      'name': name,
      'isSliding': isSliding,
      'sashMargin': sashMargin,
      'profiles': profiles.map((x) => x.toMap()).toList(),
    };
  }

  factory Serie.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError("Map cannot be null");
    }

    List<dynamic>? profileMaps = map['profiles'];
    List<Profile> profiles = [];
    if (profileMaps != null && profileMaps.isNotEmpty) {
      profiles = profileMaps.map((x) => Profile.fromMap(x)).toList();
    }

    return Serie(
      name: map['name'] ?? '',
      isSliding: map['isSliding'] ?? false,
      sashMargin: map['sashMargin'] ?? 0.0,
      profiles: profiles,
    );
  }

  String toJson() => json.encode(toMap());

  factory Serie.fromJson(String source) => Serie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Serie(name: $name, isSliding: $isSliding, sashMargin: $sashMargin, profiles: $profiles)';
  }
}
