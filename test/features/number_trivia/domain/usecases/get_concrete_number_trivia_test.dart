import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repositorie.dart';

import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRespository extends Mock implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRespository mockNumberTriviaRespository;

  setUp(() {
    mockNumberTriviaRespository = MockNumberTriviaRespository();
    usecase = GetConcreteNumberTrivia(repository: mockNumberTriviaRespository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: "test");

  test("should get trivia for the number from the repository", () async {
    // Arrange
when(mockNumberTriviaRespository.getConcreteNumberTrivia(any ))
    .thenAnswer((_) async => const Right(tNumberTrivia));


    
    // Act
    final result = await usecase.execute(number: tNumber);

    // Assert
    expect(result,  const Right(tNumberTrivia));
    verify(mockNumberTriviaRespository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRespository);
  });
}
