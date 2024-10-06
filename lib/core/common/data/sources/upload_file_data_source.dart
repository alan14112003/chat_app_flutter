import 'dart:io';

import 'package:dio/dio.dart';

class UploadFileDataSource {
  final Dio _dio;

  UploadFileDataSource({
    required Dio dio,
  }) : _dio = dio;

  Future<String?> uploadFile(File file) async {
    FormData formData = FormData.fromMap(
        {'file': await MultipartFile.fromFile(file.path), 'path': '/messages'});

    Response<dynamic> response = await _dio.post(
      '/uploads/single',
      data: formData,
    );

    return response.data['url'];
  }
}
