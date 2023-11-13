

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';


void main(){
  const tNumberTriviaModel=NumberTriviaModel(number:1, text: "Test text");

  test("should be a subclass of NumberTrivia entity", ()async{

//arrage

//act
expect(tNumberTriviaModel, isA<NumberTrivia>());

//assert
  });

}