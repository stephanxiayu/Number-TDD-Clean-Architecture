
import 'package:dartz/dartz.dart';

import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repositorie.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({ required this.repository});

 Future<Either<Failure, NumberTrivia>?> execute({required  number}) async {

 return  await repository.getConcreteNumberTrivia(number);
}
}