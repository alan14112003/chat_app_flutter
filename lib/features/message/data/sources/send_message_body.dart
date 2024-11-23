import 'package:equatable/equatable.dart';

class SendMessageBody extends Equatable {
  final int type;
  final String? text;
  final String? file;
  final String? image;
  final int? replyId;
  final bool isChatBotContent;

  const SendMessageBody({
    required this.type,
    this.text,
    this.file,
    this.image,
    this.replyId,
    this.isChatBotContent = false,
  });

  @override
  List<Object?> get props => [
        type,
        text,
        file,
        image,
        replyId,
        isChatBotContent,
      ];

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
      'isChatBotContent': isChatBotContent,
    };
  }
}
