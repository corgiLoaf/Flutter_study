import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kakaotalk_clone/data/kakao_data.dart';
import 'package:kakaotalk_clone/shared/round_square.dart';
import 'package:kakaotalk_clone/shared/simple_chip.dart';

void main() {
  runApp(const KakaoTalk());
}

class KakaoTalk extends StatelessWidget {
  const KakaoTalk({super.key});

  @override
  Widget build(BuildContext context) {
    // the number of unread messages (across all chats)
    int unreadSum =
        data.fold(0, (value, element) => value + element.unreadCount);

    Widget header = Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          const Text(
            "채팅",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 160),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.search),
                Icon(Icons.add_comment_outlined),
                Icon(Icons.forum_outlined),
                Icon(Icons.settings),
              ],
            ),
          ),
        ],
      ),
    );

    Widget body = ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ChatListElement(chatInfo: data[index]),
    );

    Widget footer = Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[100],
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(Icons.person_outline),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Positioned(
              child: Icon(Icons.chat_bubble),
            ),
            Positioned(
              top: -3,
              left: 15,
              child: SimpleChip(
                content: unreadSum.toString(),
              ),
            ),
          ],
        ),
        const Icon(Icons.info_outline),
        const Icon(Icons.shopping_bag_outlined),
        const Icon(Icons.more_horiz_outlined),
      ]),
    );

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              header,
              const Divider(height: 0.0, thickness: 1),
              Expanded(child: body),
              const Divider(height: 0.0, thickness: 1),
              footer,
            ],
          ),
        ),
      ),
    );
  }
}

class ChatListElement extends StatelessWidget {
  const ChatListElement({super.key, required this.chatInfo});

  final ChatInfo chatInfo;

  // on single image, return RoundSquareImage.
  // on multiple images, return Stack of RoundSquareImage.
  Widget _buildChatImage() {
    switch (chatInfo.images.length) {
      case 1:
        return RoundSquareImage(
          image: Image.network(chatInfo.images[0]),
          size: 50,
        ); // 1 person (image size: 50px)
      case 2:
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[0]),
                size: (50 * 3 / 5),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[1]),
                size: (50 * 3 / 5),
              ),
            ),
          ],
        ); // 2 people (image size: 50px * 3 / 5)
      case 3:
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[0]),
                size: (50 * 4 / 7),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[1]),
                size: (50 * 4 / 7),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[2]),
                size: (50 * 4 / 7),
              ),
            ),
          ],
        ); // 3 people (image size: 50px * 4 / 7)
      default:
        return Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[0]),
                size: (50 * 1 / 2),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[1]),
                size: (50 * 1 / 2),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[2]),
                size: (50 * 1 / 2),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: RoundSquareImage(
                image: Image.network(chatInfo.images[3]),
                size: (50 * 1 / 2),
              ),
            ),
          ],
        ); // 4 or more people in the chat (image size: 50px * 1 / 2)
    }
  }

  String _lastChatTimeFormatted() {
    DateTime now = DateTime.now();
    // Extract (year, month, day) information from 'now' and 'chatInfo.lastChatTime'.
    // This makes comparing dates easier.
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime dateToCheck = DateTime(chatInfo.lastChatTime.year,
        chatInfo.lastChatTime.month, chatInfo.lastChatTime.day);

    // Return formatted strings
    if (dateToCheck == today) {
      return DateFormat('hh시 mm분').format(today);
    } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
      return "어제"; // yesterday
    } else if (dateToCheck.year == today.year) {
      return DateFormat('MM월 dd일')
          .format(dateToCheck); // day before yesterday & this year
    } else {
      return DateFormat('yyyy년 MM월 dd일')
          .format(dateToCheck); // last year & before
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleAndLastChat = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  chatInfo.chatName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),
              if(chatInfo.images.length != 1) Text(
                chatInfo.images.length.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ), 
            ],
          ),
          Text(
            chatInfo.lastChatContent,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ]);

    Widget timeAndUnreadCount = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _lastChatTimeFormatted(),
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (chatInfo.unreadCount != 0) (
          SimpleChip(
          content: chatInfo.unreadCount.toString(),)
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: _buildChatImage(),
          ),
          const SizedBox(width: 10),
          Expanded(child: titleAndLastChat),
          timeAndUnreadCount
        ],
      ),
    );
  }
}
