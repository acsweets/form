class EnumUtils {
  static T? stringToEnum<T>(List<T> enumValues, String value) {
    try {
      return enumValues.firstWhere(
        (e) => parse(e) == value,
      );
    } on StateError {
      return null;
    }
  }

  static String? parse(enumItem) {
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }
}
