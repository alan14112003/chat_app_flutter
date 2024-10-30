import 'package:equatable/equatable.dart';

class ChatUsers extends Equatable {
  final String name;
  final String text;
  final String image;
  final bool isMessageRead; // Giữ nguyên trạng thái đọc

  const ChatUsers({
    required this.name,
    required this.text,
    required this.image,
    this.isMessageRead = false, // Mặc định là false
  });

  ChatUsers copyWith({bool? isMessageRead}) {
    return ChatUsers(
      name: name,
      text: text,
      image: image,
      isMessageRead: isMessageRead ??
          this.isMessageRead, // Cho phép thay đổi trạng thái đọc
    );
  }

  @override
  List<Object> get props => [name, text, image, isMessageRead];
}
