import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:chat_app_flutter/core/error/failures.dart';
import 'package:chat_app_flutter/core/error/handle_error_dio.dart';
import 'package:chat_app_flutter/core/usecase/usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/repositories/chat_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class AddGroupParams {
  final String groupName;
  final List<User> members;

  AddGroupParams({
    required this.groupName,
    required this.members,
  });
}

class AddGroup implements UseCase<String, AddGroupParams> {
  final ChatRepository _chatRepository;

  AddGroup({
    required ChatRepository chatRepository,
  }) : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, String>> call(AddGroupParams params) async {
    try {
      final group = await _chatRepository.addGroup(
          groupName: params.groupName, members: params.members);
      return right(group);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return HandleErrorDio.call(e);
    } catch (e) {
      print('Catch Error: ${e.toString()}');
      return left(Failure(e.toString()));
    }
  }
}
