import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test Text");

  test("should be a subclass of NumberTrivia entity", () async {
//arrage

//act
    expect(tNumberTriviaModel, isA<NumberTrivia>());

//assert
  });

  group("fromJson", () {
    test("should return a valid model when the json number is an int",
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixtures("trivia.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

    test(
        "should return a valid model when the json number is an regarded as a double",
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixtures("trivia_double.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });

  group("toJson", () {
    test("should return JSON map containing the proper data ", () async {
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
