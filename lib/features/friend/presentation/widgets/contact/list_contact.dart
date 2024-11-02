import 'package:flutter/material.dart';

class ListContact extends StatelessWidget {
  final List<Map<String, String>> contacts;

  const ListContact({super.key, required this.contacts});


  @override
  Widget build(BuildContext context) {
      if (contacts.isEmpty) {
      return Center(
        child: Text(
          'Danh sách bạn bè trống',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        final name = contact['name'] ?? '';
        final letter = name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 ||
                ((contacts[index - 1]['name'] ?? '').isNotEmpty &&
                    contacts[index - 1]['name']![0].toUpperCase() != letter))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  letter,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: contact['avatar'] != null
                          ? NetworkImage(contact['avatar']!)
                          : null,
                      child: contact['avatar'] == null ? Text(letter) : null,
                    ),
                    title: Text(name.isNotEmpty ? name : 'No Name'),
                  ),
                  if (index != contacts.length - 1) const Divider(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}
