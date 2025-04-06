class EnumValues<T extends Enum> {
  final Map<String, T> map;
  final Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));

  Map<T, String> get reverse => reverseMap;
}
