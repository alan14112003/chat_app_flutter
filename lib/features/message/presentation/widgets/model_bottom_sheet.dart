import 'package:flutter/material.dart';

class ModelBottomSheet extends StatelessWidget {
  const ModelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceAround, // Sắp xếp các mục đều nhau
        children: [
          GestureDetector(
            onTap: () {
              // Xử lý hành động trả lời
              Navigator.pop(context); // Đóng hộp thoại
            },
            child: const Column(
              children: [
                Icon(Icons.reply),
                SizedBox(height: 8),
                Text('Reply'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý hành động sao chép
              Navigator.pop(context); // Đóng hộp thoại
            },
            child: const Column(
              children: [
                Icon(Icons.copy),
                SizedBox(height: 8),
                Text('Copy'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý hành động xóa
              Navigator.pop(context); // Đóng hộp thoại
            },
            child: const Column(
              children: [
                Icon(Icons.delete),
                SizedBox(height: 8),
                Text('Delete'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
