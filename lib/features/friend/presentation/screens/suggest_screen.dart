import 'package:chat_app_flutter/core/common/widgets/bottom_navigation.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/friend/presentation/bloc/find_friend_by_email/find_friend_by_email_bloc.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/suggest/app_bar_suggest_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/suggest/search_bar_suggest_contact.dart';
import 'package:chat_app_flutter/features/friend/presentation/widgets/suggest/user_list_suggest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SuggestScreen(),
      );
  const SuggestScreen({super.key});

  @override
  State<SuggestScreen> createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          padding: const EdgeInsets.only(top: 22.0, bottom: 6.0),
          child: AppBarSuggestContact(),
        ),
      ),
      body: Column(
        children: [
          SearchBarSuggestContact(),
          BlocConsumer<FindFriendByEmailBloc, FindFriendByEmailState>(
            listener: (context, state) {
              if (state is FindFriendByEmailFailure) {
                showSnackBar(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is FindFriendByEmailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FindFriendByEmailDisplaySuccess) {
                if (state.user != null) {
                  return UserListSuggest(user: state.user!);
                }
                return Text('người dùng không tồn tại');
              }
              return SizedBox();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
