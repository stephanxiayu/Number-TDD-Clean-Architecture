

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia{
  const NumberTriviaModel({required String text, required int number}) : super(text:text, number: number);
  

factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
  var numberField = json['number'];

  int number = numberField is int ? numberField : num.parse(numberField.toString()).toInt();

  return NumberTriviaModel(text: json['text'], number: number);
}

Map<String, dynamic> toJson(){
  return{
    'text':text,
    'number':number
  };
}
  
}