import 'dart:io';

abstract interface class UploadFileRepository {
  Future<String?> uploadFile(File file);
}
