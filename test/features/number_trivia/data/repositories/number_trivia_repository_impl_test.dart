
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource{}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource{}

class MockNetworkInfo extends Mock implements NetworkInfo{}


void main(){
 late NumberTriviaRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
 late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource =MockLocalDataSource();
    mockRemoteDataSource =MockRemoteDataSource(); 
    mockNetworkInfo= MockNetworkInfo();
    repositoryImpl =NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo

    );

  });


  group("getConcreteNumberTrivia", () { 
const tNumber=1;
const tNumberTriviaModel=NumberTriviaModel(number: tNumber, text: "test trivia");
const NumberTrivia tNumbertrivia=tNumberTriviaModel;

    test("should check if the device is online", ()async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repositoryImpl.getConcreteNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);


    });});
}