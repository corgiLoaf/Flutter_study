class ChatInfo {
  ChatInfo({
    required this.chatName,
    required this.images,
    required this.lastChatTime,
    required this.lastChatContent,
    required this.unreadCount,
  });

  final String chatName;
  final List<String> images;
  final String lastChatContent;
  final DateTime lastChatTime;
  final int unreadCount;
}

String baseUrl = "https://picsum.photos/100/100";

List<ChatInfo> data = [
  ChatInfo(
    chatName: "채팅방",
    images: ["$baseUrl?random=1", "$baseUrl?random=2", "$baseUrl?random=3"],
    lastChatTime: DateTime.now(),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 1,
  ),
  ChatInfo(
    chatName: "채팅    방",
    images: ["$baseUrl?random=4", "$baseUrl?random=5"],
    lastChatTime: DateTime.now().subtract(const Duration(hours: 10)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 99,
  ),
  ChatInfo(
    chatName: "채팅팅팅팅팅팅팅팅팅팅팅방",
    images: [
      "$baseUrl?random=104",
      "$baseUrl?random=105",
      "$baseUrl?random=106"
    ],
    lastChatTime: DateTime.now().subtract(const Duration(hours: 19)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 0,
  ),
  ChatInfo(
    chatName: "Chats",
    images: ["$baseUrl?random=7"],
    lastChatTime: DateTime.now().subtract(const Duration(days: 1)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 13,
  ),
  ChatInfo(
    chatName: "채12345678987654 32123456 7876543234 56787654팅방",
    images: ["$baseUrl?random=100"],
    lastChatTime: DateTime.now().subtract(const Duration(days: 8)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 0,
  ),
  ChatInfo(
    chatName: "채팅방",
    images: ["$baseUrl?random=8", "$baseUrl?random=10"],
    lastChatTime: DateTime.now().subtract(const Duration(days: 10)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 10,
  ),
  ChatInfo(
    chatName: "채팅방",
    images: [
      "$baseUrl?random=282",
    ],
    lastChatTime: DateTime.now().subtract(const Duration(days: 100)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 9,
  ),
  ChatInfo(
    chatName: "채팅방",
    images: ["$baseUrl?random=1", "$baseUrl?random=3"],
    lastChatTime: DateTime.now().subtract(const Duration(days: 300)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 11,
  ),
  ChatInfo(
    chatName: "채팅방",
    images: [
      "$baseUrl?random=238",
      "$baseUrl?random=49",
      "$baseUrl?random=1290",
      "$baseUrl?random=1241",
      "$baseUrl?random=142",
    ],
    lastChatTime: DateTime.now().subtract(const Duration(days: 500)),
    lastChatContent: "카톡 좀 읽어라",
    unreadCount: 100,
  ),
];