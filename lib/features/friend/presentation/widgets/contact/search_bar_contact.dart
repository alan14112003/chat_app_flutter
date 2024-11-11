import 'package:chat_app_flutter/features/friend/presentation/screens/suggest_screen.dart';
import 'package:flutter/material.dart';

class SearchBarContact extends StatelessWidget {
  const SearchBarContact({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('click');
        Navigator.push(context, SuggestScreen.route());
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm bạn bè...',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[600],
              ),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }
}
