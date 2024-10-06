import 'dart:io';

import 'package:chat_app_flutter/core/common/domain/repositories/upload_file_repository.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class UploadFileParams {
  final File file;

  UploadFileParams({
    required this.file,
  });
}

class UploadFile implements UseCase<String?, UploadFileParams> {
  final UploadFileRepository _uploadFileRepository;

  UploadFile({
    required UploadFileRepository uploadFileRepository,
  }) : _uploadFileRepository = uploadFileRepository;

  @override
  Future<Either<Failure, String?>> call(UploadFileParams params) async {
    try {
      final String? fileUrl = await _uploadFileRepository.uploadFile(
        params.file,
      );

      return right(fileUrl);
    } on DioException catch (e) {
      return HandleErrorDio.call(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
