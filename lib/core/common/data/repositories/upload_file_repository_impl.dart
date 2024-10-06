import 'dart:io';
import 'package:chat_app_flutter/core/common/data/sources/upload_file_data_source.dart';
import 'package:chat_app_flutter/core/common/domain/repositories/upload_file_repository.dart';

class UploadFileRepositoryImpl implements UploadFileRepository {
  final UploadFileDataSource _uploadFileDataSource;

  UploadFileRepositoryImpl({
    required UploadFileDataSource uploadFileDataSource,
  }) : _uploadFileDataSource = uploadFileDataSource;

  @override
  Future<String?> uploadFile(File file) {
    return _uploadFileDataSource.uploadFile(file);
  }
}
