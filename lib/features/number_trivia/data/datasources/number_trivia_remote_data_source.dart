
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_models.dart';


abstract class NumberTriviaRemoteDataSource{
  /// calls the http://numbersapi.com/{number} endpoint
   /// Throws [ServerException] for all error codes
  Future< NumberTriviaModel> getConcreteNumberTrivia(int number);

   /// calls the http://numbersapi.com/random endpoint
   /// Throws [ServerException] for all error codes
Future< NumberTriviaModel>  getRandomNumberTrivia();
}