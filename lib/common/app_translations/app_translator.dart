import 'package:flutter_translation/flutter_translation.dart';

abstract class AppTranslator extends ITranslator {
  const AppTranslator();

  String get popular;
  String get now;
  String get soon;
  String get favoriteMovies;
  String get languages;
  String get feedback;
  String get about;
}
