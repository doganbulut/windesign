// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(
    this.map,
  );

  Map<T, String> get reverse {
    return map.map((k, v) => new MapEntry(v, k));
  }
}
