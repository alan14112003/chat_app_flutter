import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Map<String, String>> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        final letter = contact['letter'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 || contacts[index - 1]['letter'] != letter)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  letter!,
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
                      backgroundImage: const AssetImage(
                          'assets/avatar_placeholder.png'),
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
