
class AppService {
  static isValidString(dynamic value) {
    return (value != null &&
        value.toString().trim().isNotEmpty &&
        value.toString().trim() != "null");
  }
}
