import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaRepositoryImpl repositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repositoryImpl = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);

  when(mockNetworkInfo.isConnected).thenAnswer((_) async => Future.value(true));

  });

  group("getConcreteNumberTrivia", () {
    const tNumber = 1;
    const tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: "test trivia");
    const NumberTrivia tNumbertrivia = tNumberTriviaModel;



    test("should check if the device is online", () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async {
  return Future.delayed(const Duration(milliseconds: 200), ()async => Future.value(true));
});

      await repositoryImpl.getConcreteNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);
    });

    group("device is online", () {
      setUp(() {
       when(mockNetworkInfo.isConnected).thenAnswer((_) async {
  return Future.delayed(const Duration(milliseconds: 100), () async => Future.value(true));
});
        test(
            "should return remote data when the call to remote data source is successful ",
            () async {
          if (kDebugMode) {
            print('Running remote data source test');
          }
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(const Right(tNumbertrivia)));
        });

        test(
            "should cache the data locally when the call to remote data source is successful ",
            () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          await repositoryImpl.getConcreteNumberTrivia(tNumber);
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        });

        test(
            "should return server failure when the call to remote data source is unsuccessful ",
            () async {
          if (kDebugMode) {
            print('Running remote data source test');
          }
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenThrow(ServerException());

          final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(const Left(ServerFailure)));
        });
      });
    });
    group("device is Offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
