import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  var chatHistory = <Map<String, dynamic>>[].obs;
  var isAiTyping = false.obs;

  Future<void> sendMessage(String message) async {
    chatHistory.add({
      "message": message,
      "isSender": true,
      "timestamp": DateTime.now(),
    });

    isAiTyping.value = true;

    var url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=Your-API-KEY");
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": message}
          ]
        }
      ]
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final aiResponse =
            responseData["candidates"]?[0]["content"]?["parts"]?[0]["text"];

        if (aiResponse != null) {
          // Add AI response to chat history with timestamp
          chatHistory.add({
            "message": aiResponse,
            "isSender": false,
            "timestamp": DateTime.now(), // Add timestamp for the AI response
          });
        } else {
          chatHistory.add({
            "message": "No response from AI.",
            "isSender": false,
            "timestamp": DateTime.now(), // Add timestamp
          });
        }
      } else {
        chatHistory.add({
          "message": "Error occurred. Please try again.",
          "isSender": false,
          "timestamp": DateTime.now(),
        });
      }
    } catch (e) {
      chatHistory.add({
        "message": "An error occurred. Please check your connection.",
        "isSender": false,
        "timestamp": DateTime.now(),
      });
    }
    isAiTyping.value = false;
  }
}
