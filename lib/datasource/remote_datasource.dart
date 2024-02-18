import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_state_management/models/user.dart';
import 'package:riverpod_state_management/utils/error/failure_response.dart';

abstract class RemoteDataSource {
  Future<Either<FailureResponse, UserResponse>> getUsers();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<Either<FailureResponse, UserResponse>> getUsers() async {
    try {
      String url = 'https://reqres.in/api/users?page=1';
      final response = await dio.get(url);
      return Right(UserResponse.fromJson(response.data));
    } on DioException catch (error) {
      return Left(FailureResponse.dio(error));
    }
  }
}
