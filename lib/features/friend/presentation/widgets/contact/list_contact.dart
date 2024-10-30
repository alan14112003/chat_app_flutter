import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Map<String, String>> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        final letter = contact['name']!.substring(0, 1).toUpperCase();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 || contacts[index - 1]['name']!.substring(0, 1).toUpperCase() != letter)
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
                      backgroundImage: NetworkImage(contact['avatar']!),
                    ),
                    title: Text(contact['name']!),
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
