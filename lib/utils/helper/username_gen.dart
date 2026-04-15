import 'dart:math';

class UsernameHelper {
  UsernameHelper._();

  static final _random = Random();

  static const _adjectives = [
    'Silent', 'Brave', 'Swift', 'Calm', 'Bold',
    'Clever', 'Fierce', 'Gentle', 'Humble', 'Jolly',
    'Mystic', 'Noble', 'Quirky', 'Rustic', 'Savvy',
    'Witty', 'Zany', 'Epic', 'Funky', 'Goofy',
    'Happy', 'Icy', 'Jazzy', 'Kinky', 'Lucky',
    'Mighty', 'Nerdy', 'Oddly', 'Peppy', 'Rapid',
    'Shiny', 'Tidy', 'Ultra', 'Vivid', 'Wacky',
  ];

  static const _nouns = [
    'Tiger', 'Eagle', 'Panda', 'Wolf', 'Falcon',
    'Dragon', 'Phoenix', 'Raven', 'Storm', 'Shadow',
    'Comet', 'Nebula', 'Pixel', 'Cipher', 'Vortex',
    'Ninja', 'Wizard', 'Pirate', 'Viking', 'Samurai',
    'Coder', 'Hacker', 'Ranger', 'Knight', 'Hunter',
    'Sniper', 'Archer', 'Mage', 'Rogue', 'Paladin',
    'Monk', 'Druid', 'Bard', 'Cleric', 'Warlock',
  ];

  /// Generates a random username like "BraveDragon4821"
  static String generate() {
    final adj = _adjectives[_random.nextInt(_adjectives.length)];
    final noun = _nouns[_random.nextInt(_nouns.length)];
    final num = _random.nextInt(9000) + 1000;
    return '$adj$noun$num';
  }

  /// Generates multiple suggestions
  static List<String> generateMultiple(int count) {
    return List.generate(count, (_) => generate());
  }

  /// Generates username with fallback in case generation fails
  static String safeGenerate() {
    try {
      return generate();
    } catch (e) {
      return "user_${DateTime.now().millisecondsSinceEpoch}";
    }
  }
}