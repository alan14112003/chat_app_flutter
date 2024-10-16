import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/core/utils/show_snack_bar.dart';
import 'package:chat_app_flutter/features/message/presentation/bloc/message_view/message_view_bloc.dart';
import 'package:chat_app_flutter/features/message/presentation/cubit/message_handle_cubit.dart';
import 'package:chat_app_flutter/features/message/presentation/widgets/message_item/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageContainer extends StatefulWidget {
  const MessageContainer({super.key});

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  late ItemScrollController _itemScrollController;
  late ItemPositionsListener _itemPositionsListener;
  bool isRecall = false;

  @override
  void initState() {
    super.initState();
    // khởi tạo scroll controller
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();

    // Sử dụng context.select để lấy chatId từ MessageHandleCubit
    final chatId = context.read<MessageHandleCubit>().state.chatId;

    // Gửi sự kiện để fetch messages từ MessageViewBloc
    context.read<MessageViewBloc>().add(FetchAllMessagesEvent(chatId: chatId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // reset _itemPositionsListener
    _resetItemPositionsListener();
  }

  @override
  void dispose() {
    super.dispose();
    _removeScrollListener();
    context.read<MessageHandleCubit>().toggleMessageReplyActive(null);
  }

  void _resetItemPositionsListener() {
    _removeScrollListener();
    _itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  void _removeScrollListener() {
    _itemPositionsListener.itemPositions.removeListener(_onScroll);
  }

  // Gửi sự kiện để tải thêm tin nhắn cũ hơn
  void _loadMoreMessages() {
    final messageState = context.read<MessageViewBloc>().state;
    if (messageState is! MessagesDisplaySuccess) return;

    // kiểm tra nếu là tin nhắn cuối cùng thì dừng lại
    if (messageState.isLast) {
      return;
    }

    final messages = messageState.messages;
    final lastMessage = messages.last;
    final chatId = context.read<MessageHandleCubit>().state.chatId;

    Future.delayed(
      Duration(minutes: 0),
      () => setState(() {
        isRecall = true;
      }),
    );

    context.read<MessageViewBloc>().add(
          FetchAllMessagesEvent(
            chatId: chatId,
            before: lastMessage.id,
            isNew: false,
          ),
        );
  }

  // Kiểm tra xem mục cuối cùng có hiển thị hoàn toàn không
  bool _isLastItemVisible() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty || isRecall) {
      return false;
    }

    final messageState = context.read<MessageViewBloc>().state;
    if (messageState is! MessagesDisplaySuccess) {
      return false;
    }

    final messages = messageState.messages;

    final lastItem = positions
        .where((item) => item.index == messages.length - 1)
        .firstOrNull;

    if (lastItem == null) {
      return false;
    }

    if (positions.last.index != messages.length - 1) {
      return false;
    }

    // Kiểm tra nếu item cuối cùng đã cuộn hết
    return double.parse(lastItem.itemTrailingEdge.toStringAsFixed(2)) == 1.0;
  }

  void _onScroll() {
    if (_isLastItemVisible()) {
      _loadMoreMessages();
    }
  }

  void _listenMessageReplyActiveAndHandle(BuildContext context) {
    // lấy ra messageReplyActive
    final messageReplyActive = context.select<MessageHandleCubit, Message?>(
      (messageHandleCubit) => messageHandleCubit.state.messageReplyActive,
    );

    if (messageReplyActive == null) {
      return;
    }

    // lấy ra danh sách message
    final messageState = context.read<MessageViewBloc>().state;

    if (messageState is! MessagesDisplaySuccess) {
      context.read<MessageHandleCubit>().toggleMessageReplyActive(null);
      return;
    }

    final messages = messageState.messages;

    // lấy ra vị trí của message reply active
    final checkMessageIndex = messages.indexWhere(
      (element) => element.id == messageReplyActive.id,
    );

    // nếu không có thì thực hiện recall
    if (checkMessageIndex == -1) {
      print('nờ ô nô');

      if (isRecall) {
        return;
      }

      _loadMoreMessages();
      return;
    }

    // active message sau khi scroll
    Future.delayed(
      Duration(
        milliseconds: 1500,
      ),
      () {
        if (context.mounted) {
          context
              .read<MessageHandleCubit>()
              .toggleMessageReplyAfterActive(messages[checkMessageIndex]);
        }
      },
    );

    // lấy ra vị trí message cuối được hiển thị trong danh sách
    final lastMessageShowedIndex =
        _itemPositionsListener.itemPositions.value.last.index;

    // nếu vị trí message reply quá xa với message cuối trong danh sách
    // thì dùng jumpTo cụ thể lớn hơn (vị trí cuối)
    if (checkMessageIndex > lastMessageShowedIndex) {
      print('too long');
      Future.delayed(
        Duration(milliseconds: 500),
        () {
          _itemScrollController.jumpTo(
            index: checkMessageIndex,
            alignment: 0.1,
          );
        },
      );
      return;
    }

    // ngược lại dùng scrollTo để mượt
    // scroll message reply vào khung hình
    _itemScrollController.scrollTo(
      index: checkMessageIndex,
      duration: Duration(seconds: 1),
      curve: Curves.ease,
      alignment: 0.1,
      opacityAnimationWeights: [20, 20, 30],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<MessageViewBloc, MessageViewState>(
          listener: (context, state) {
            if (state is MessageFailure) {
              showSnackBar(context, state.error);
            }
            if (state is MessagesDisplaySuccess) {
              setState(() {
                isRecall = false;
              });
            }
          },
          builder: (context, state) {
            if (state is MessageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MessagesDisplaySuccess) {
              // lắng nghe sự kiện click vào message reply
              _listenMessageReplyActiveAndHandle(context);

              return Stack(
                children: [
                  ScrollablePositionedList.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemPositionsListener: _itemPositionsListener,
                    itemScrollController: _itemScrollController,
                    itemBuilder: (context, index) {
                      return MessageItem(
                        message: state.messages[index],
                        messages: state.messages,
                        index: index,
                      );
                    },
                  ),

                  // Hiển thị loader trên cùng khi isLoading là true
                  if (isRecall)
                    Positioned(
                      top: 20, // Khoảng cách từ trên cùng
                      left: 0,
                      right: 0, // Để loader căn giữa ngang
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircularProgressIndicator(),
                        ), // Loader ở giữa
                      ),
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
