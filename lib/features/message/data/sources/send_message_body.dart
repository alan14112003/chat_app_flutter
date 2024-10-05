import 'package:equatable/equatable.dart';

class SendMessageBody extends Equatable {
  final int type;
  final String? text;
  final String? file;
  final String? image;
  final int? replyId;

  const SendMessageBody({
    required this.type,
    this.text,
    this.file,
    this.image,
    this.replyId,
  });

  @override
  List<Object?> get props => [type, text, file, image, replyId];

  @override
  bool? get stringify => true;

  // Phương thức chuyển đổi thành JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text,
      'file': file,
      'image': image,
      'replyId': replyId,
    };
  }
}
