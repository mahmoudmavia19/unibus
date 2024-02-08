import 'package:get/get.dart';

import '../model/chat_model.dart';

class ChatCenterController extends GetxController {
  // Define a list to store chat models
  RxList<ChatModel> chats = <ChatModel>[].obs;

  @override
  void onInit() {
    // Initialize the controller
    fetchChats();
    super.onInit();
  }

  // Fetch chats from your data source (e.g., API, database)
  void fetchChats() {
    // In a real application, you would fetch chats from an API or database
    // For demonstration purposes, let's add some dummy data
    chats.assignAll([
      ChatModel(title: 'Chat Room 1', lastMessage: 'Hello!', lastMessageTime: DateTime.now()),
      ChatModel(title: 'Chat Room 2', lastMessage: 'Hi there!' , lastMessageTime: DateTime.now()),
      // Add more chat rooms if needed
    ]);
  }

// Add more methods for managing chats, sending messages, etc.
}
