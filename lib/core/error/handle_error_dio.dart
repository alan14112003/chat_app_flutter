import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class HandleErrorDio {
  static Either<Failure, R> call<R>(DioException e) {
    final response = e.response;

    if (response != null) {
      return left(Failure(response.data['message']));
    }

    if (e.message != null) {
      return left(Failure(e.message as String));
    }
    return left(Failure());
  }
}
