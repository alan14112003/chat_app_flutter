import 'package:flutter/material.dart';

class SearchBarChat extends StatelessWidget {
  final Function(String) onSearchChanged;

  const SearchBarChat({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Tìm kiếm',
          hintStyle: TextStyle(color: Colors.grey[700]),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[700],
            size: 20,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.all(8.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
        // Gọi callback với giá trị tìm kiếm
        onChanged: onSearchChanged,
      ),
    );
  }
}
