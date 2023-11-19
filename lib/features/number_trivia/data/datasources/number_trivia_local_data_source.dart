

import 'package:number_trivia/features/number_trivia/data/models/number_trivia_models.dart';

abstract class NumberTriviaLocalDataSource{
  /// gets the cahced [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection
  /// 
  /// Throws [CacheException] if no chached data present

  Future<NumberTriviaModel> ?getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}