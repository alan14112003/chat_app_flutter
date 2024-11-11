import 'package:chat_app_flutter/features/friend/presentation/bloc/friend_view/friend_view_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/buttons/delete_request_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListContact extends StatelessWidget {
  final List<Map<String, String>> contacts;

  const ListContact({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    // Sắp xếp danh sách theo tên
    contacts.sort((a, b) {
      final nameA = a['name']?.toUpperCase() ?? '';
      final nameB = b['name']?.toUpperCase() ?? '';
      return nameA.compareTo(nameB);
    });

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
        final letter =
            name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 ||
                ((contacts[index - 1]['name'] ?? '').isNotEmpty &&
                    contacts[index - 1]['name']![0].toUpperCase() != letter))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    trailing: DeleteRequestButton(
                      friendId: contact['id']!,
                      onDeleteSuccess: () {
                        context
                            .read<FriendViewBloc>()
                            .add(ReloadAllFriendsEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
