import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/controller/base_controller.dart';
import 'package:tekup_connection_mobile/data/model/chat_model.dart';
import 'package:tekup_connection_mobile/data/model/message_model.dart';
import 'package:tekup_connection_mobile/routes/app_routes.dart';

class MainController extends BaseController {
  static MainController get to => Get.find<MainController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<ChatModel> chatHistory = <ChatModel>[].obs;
  RxList<MessageModel> messageList = <MessageModel>[].obs;

  var currentChatId = Rxn<int>();

  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadChatHistory();
  }

  void loadChatHistory() {
    final chat1Messages = <MessageModel>[
      MessageModel(
          text:
          "Flutter là một UI toolkit của Google để xây dựng các ứng dụng...",
          role: 'bot',
          timestamp: DateTime.now().subtract(const Duration(minutes: 8))),
      MessageModel(
          text: "Flutter là gì?",
          role: 'user',
          timestamp: DateTime.now().subtract(const Duration(minutes: 9))),
      MessageModel(
          text: "Chào bạn, tôi có thể giúp gì cho bạn hôm nay?",
          role: 'bot',
          timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
    ];

    // Data cho Chat 2
    final chat2Messages = <MessageModel>[
      MessageModel(
          text:
          "class MyController extends GetxController {\n  var count = 0.obs;\n  void increment() => count++;\n}",
          role: 'bot',
          timestamp: DateTime.now().subtract(const Duration(days: 1))),
      MessageModel(
          text: "Viết giùm tôi một đoạn code GetX",
          role: 'user',
          timestamp: DateTime.now().subtract(const Duration(days: 1))),
    ];

    final chat3Messages = <MessageModel>[];

    final mockHistory = <ChatModel>[
      ChatModel(id: 1, name: "Giới thiệu Flutter", messages: chat1Messages),
      ChatModel(id: 2, name: "Hỏi về GetX", messages: chat2Messages),
      ChatModel(id: 3, name: "Chat trống", messages: chat3Messages),
    ];

    chatHistory.value = mockHistory;

    if (chatHistory.isNotEmpty) {
      final firstChat = chatHistory.first;
      messageList.value = firstChat.messages;
      currentChatId.value = firstChat.id;
    }
  }

  void loadMessages(int chatId) {
    final activeChat = chatHistory.firstWhereOrNull((chat) => chat.id == chatId);

    if (activeChat != null) {
      messageList.value = activeChat.messages;
      currentChatId.value = activeChat.id;
    }
    Get.back();
  }

  void onNewChat() {
    messageList.clear();
    currentChatId.value = null;
    Get.back();
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final userMessage =
    MessageModel(text: text, role: 'user', timestamp: DateTime.now());

    _saveMessageToHistory(userMessage);

    messageList.insert(0, userMessage);
    textController.clear();

    Future.delayed(const Duration(seconds: 1), () {
      final botMessage = MessageModel(
          text: "Đây là câu trả lời cho: $text",
          role: 'bot',
          timestamp: DateTime.now());

      _saveMessageToHistory(botMessage);

      messageList.insert(0, botMessage);
    });
  }

  void _saveMessageToHistory(MessageModel message) {
    if (currentChatId.value == null) {

      final newChat = ChatModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: message.text.length > 30
            ? "${message.text.substring(0, 30)}..."
            : message.text,
        messages: [message],
      );

      chatHistory.insert(0, newChat);
      currentChatId.value = newChat.id;
    } else {
      // TRƯỜNG HỢP 2: CHAT CŨ
      final activeChat =
      chatHistory.firstWhereOrNull((chat) => chat.id == currentChatId.value);

      if (activeChat != null) {
        activeChat.messages.insert(0, message);
        // 3. (Tùy chọn) Cập nhật tiêu đề nếu cần
        // activeChat.name = "Tiêu đề mới";

        // 4. Báo cho GetX biết `chatHistory` đã thay đổi (vì `messages` là list con)
        chatHistory.refresh();
      }
    }
  }

  void onProfileTapped() {
    Get.toNamed(PageName.mainPage);
  }
}