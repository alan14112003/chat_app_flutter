import 'package:chat_app_flutter/features/message/presentation/widgets/speech_dialog.dart';
import 'package:flutter/material.dart';

class SpeechToTextButton extends StatelessWidget {
  final TextEditingController _controller;

  const SpeechToTextButton({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SpeechDialog.show(context, _controller);
      },
      child: const Icon(
        Icons.mic,
        size: 24,
        color: Colors.blueAccent,
      ),
    );
  }
}
