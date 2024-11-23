import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeContentButton extends StatefulWidget {
  const TypeContentButton({super.key});

  @override
  State<TypeContentButton> createState() => _TypeContentButtonState();
}

class _TypeContentButtonState extends State<TypeContentButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Xử lý khi nhấn vào icon file
        print("File icon tapped");
        context.read<MessageHandleCubit>().toggleTypeContentMessage();
      },
      child: BlocSelector<MessageHandleCubit, MessageHandleState, bool>(
        selector: (state) {
          return state.isChatBotContent;
        },
        builder: (context, isChatBotContent) {
          return Icon(
            isChatBotContent ? Icons.reviews : Icons.three_p,
            size: 24,
            color: Colors.blueAccent,
          );
        },
      ),
    );
  }
}
