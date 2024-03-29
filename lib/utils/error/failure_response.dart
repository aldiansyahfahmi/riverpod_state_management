import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class FailureResponse extends Equatable {
  final String errorMessage;
  final int statusCode;

  const FailureResponse({
    required this.errorMessage,
    required this.statusCode,
  });

  static FailureResponse dio(DioException error) {
    return FailureResponse(
      errorMessage: error.response?.data['message']?.toString() ??
          error.response.toString(),
      statusCode: error.response?.statusCode ?? 500,
    );
  }

  @override
  List<Object?> get props => [errorMessage, statusCode];
}
