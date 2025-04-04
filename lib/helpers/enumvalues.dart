class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = {};

  Map<T, String> get reverse {
    return reverseMap;
  }
}
