import 'package:username_gen/username_gen.dart';

class UsernameHelper {
  UsernameHelper._(); // prevents instantiation

  static final UsernameGen _generator = UsernameGen();

  /// Generates a random username
  static String generate() {
    return _generator.generate();
  }

  /// Generates multiple suggestions
  static List<String> generateMultiple(int count) {
    return List.generate(count, (_) => _generator.generate());
  }

  /// Generates username with fallback in case package fails
  static String safeGenerate() {
    try {
      return _generator.generate();
    } catch (e) {
      return "user_${DateTime.now().millisecondsSinceEpoch}";
    }
  }
}