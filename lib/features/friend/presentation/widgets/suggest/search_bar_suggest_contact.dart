import 'package:flutter/material.dart';

class SearchBarSuggestContact extends StatelessWidget {
  const SearchBarSuggestContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Tìm kiếm...',
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
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
