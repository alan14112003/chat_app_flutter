import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Đóng thanh tìm kiếm khi nhấn nút back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Bạn có thể hiển thị kết quả tìm kiếm ở đây. Ví dụ:
    return Center(child: Text("Search Results"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Hiển thị các gợi ý tìm kiếm khi người dùng nhập. Ví dụ:
    return Center(child: Text("Search Suggestions"));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Các hành động trên thanh tìm kiếm, ví dụ như nút xóa
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Làm mới query khi nhấn nút xóa
          showSuggestions(context); // Hiển thị lại gợi ý sau khi làm mới
        },
      ),
    ];
  }
}
