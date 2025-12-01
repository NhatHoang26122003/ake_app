import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tekup_connection_mobile/common/base/api/api_connect.dart';
import 'package:tekup_connection_mobile/common/base/controller/base_controller.dart';
import 'package:tekup_connection_mobile/common/base/controller/observer_func.dart';
import 'package:tekup_connection_mobile/common/base/storage/local_data.dart';
import 'package:tekup_connection_mobile/common/repository/chat_repository.dart';
import 'package:tekup_connection_mobile/common/repository/message_repository.dart';
import 'package:tekup_connection_mobile/data/model/chat_model.dart';
import 'package:tekup_connection_mobile/data/model/message_model.dart';
import 'package:tekup_connection_mobile/data/model/user_model.dart';
import 'package:tekup_connection_mobile/data/response/base_get_response.dart';
import 'package:tekup_connection_mobile/data/response/message_response.dart';
import 'package:tekup_connection_mobile/routes/app_routes.dart';

class MainController extends BaseController {
  static MainController get to => Get.find<MainController>();

  Rx<UserModel?> user = Rx<UserModel?>(LocalData.shared.user);
  RxList<ChatModel> chatHistories = <ChatModel>[].obs;
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  Rx<bool> isLoadingResponse = false.obs;

  var currentChatId = Rxn<String>();
  var currentMessagePage = Rx<int>(1);

  late IO.Socket socket;
  final ChatRepository _chatRepository = Get.find();
  final MessageRepository _messageRepository = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _initWebSocket();
    loadChatHistory();
  }

  @override
  void onClose() {
    _disconnectWebSocket();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _initWebSocket() {
    socket = IO.io(
        ApiConstants.baseUrlDevWebsocket,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .disableAutoConnect()
            .setAuth({"token": LocalData.shared.tokenData.val})
            .build());
    socket.on('receive-answer', (data) => _handleIncomingMessage(data));
    socket.connect();
  }

  void _disconnectWebSocket() {
    if (socket.connected) {
      socket.disconnect();
    }
    socket.dispose();
  }

  Future<void> loadChatHistory() async {
    subscribe(
      future: _chatRepository.getChatHistories(),
      observer: ObserverFunc(
        onSubscribe: () {},
        onSuccess: (response) {
          final chatResponse = BaseGetResponse<ChatModel>.fromJson(
              response.body, ChatModel.fromJson);
          chatHistories.value = chatResponse.chatSessions ?? [];
        },
        onError: (error) {
          showSimpleErrorSnackBar(message: error.message ?? "");
        },
      ),
    );
  }

  Future<void> renameChat(String? chatId, String newTitle) async {
    if (chatId == null) return;
    final request = {"newTitle": newTitle};
    subscribe(
      future: _chatRepository.renameChat(chatId, body: request),
      observer: ObserverFunc(
        onSubscribe: () {},
        onSuccess: (response) {
          final newTitleResponse = ChatModel.fromJson(response.body);
          final index = chatHistories.indexWhere((element) => element.id == chatId);
          if (index != -1) {
            chatHistories[index].title = newTitleResponse.title ?? newTitle;
            chatHistories.refresh();
          }
        },
        onError: (error) {
          showSimpleErrorSnackBar(message: error.message ?? "renameFailed".tr);
        },
      ),
    );
    Get.back();
  }

  Future<void> deleteChat(String? chatId) async {
    if (chatId != null) {
      subscribe(
        future: _chatRepository.deleteChat(chatId),
        observer: ObserverFunc(
          onSubscribe: () {},
          onSuccess: (response) {
            final index = chatHistories.indexWhere((element) => element.id == chatId);
            if (index != -1) {
              chatHistories.removeAt(index);
              chatHistories.refresh();
            }
          },
          onError: (error) {
            showSimpleErrorSnackBar(message: error.message ?? "");
          },
        ),
      );
    }
    Get.back();
  }

  Future<void> loadMessages(String? chatId) async {
    currentChatId.value = chatId;
    if (chatId != null) {
      subscribe(
        future:
            _messageRepository.getMessages(chatId, currentMessagePage.value),
        observer: ObserverFunc(
          onSubscribe: () {},
          onSuccess: (response) {
            final msgResponse =
                MessageResponse.fromJson(response.body, MessageModel.fromJson);
            messageList.clear();
            messageList.value = msgResponse.chatMessages ?? [];
            Get.back();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              FocusManager.instance.primaryFocus?.unfocus();
              _scrollToBottom();
            });
          },
          onError: (error) {
            showSimpleErrorSnackBar(message: error.message ?? "");
          },
        ),
      );
    } else {
      Get.back();
    }
  }

  void sendMessage() {
    String content = textController.text.trim();
    if (content.isEmpty) {
      return;
    }

    textController.clear();
    MessageModel msg = MessageModel(
      content: content,
      role: 'user',
      timestamp: DateTime.now(),
    );

    messageList.add(msg);
    _scrollToBottom();
    isLoadingResponse.value = true;

    Map<String, dynamic> payload = {
      "question": content,
      "chatSessionId": currentChatId.value
    };
    socket.emit('ask-question', payload);
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    isLoadingResponse.value = false;

    String answer = data["answer"] ?? "";
    String? chatSessionId = data["chatSessionId"];

    if (currentChatId.value == null && chatSessionId != null) {
      currentChatId.value = chatSessionId;
      loadChatHistory();
    }
    MessageModel botMsg =
        MessageModel(content: answer, role: "bot", timestamp: DateTime.now());
    messageList.add(botMsg);

    _scrollToBottom();
  }

  void onNewChat() {
    currentChatId.value = null;
    messageList.clear();
    Get.back();
  }

  void onProfileTapped() {
    Get.toNamed(PageName.profilePage);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool checkCurrentChat(String? chatId) {
    return (currentChatId.value == chatId) ? true : false;
  }
}
