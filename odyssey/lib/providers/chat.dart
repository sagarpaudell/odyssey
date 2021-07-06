import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chat with ChangeNotifier {
  final String userId;
  final String username;
  final String authToken;

  Chat([this.username, this.userId, this.authToken]);

  WebSocketChannel sendMessage() {
    print('websocket');
    WebSocketChannel channel;
    try {
      channel = new WebSocketChannel.connect(Uri.parse(
          "ws://travellum.herokuapp.com/ws/chat/buddha/?token=$authToken"));
    } catch (e) {
      ///
      /// An error occurred
      ///
    }
    return channel;
    //https://travellum.herokuapp.com/chat-api/sagar/
    // return WebSocketChannel.connect(Uri.parse(
    //     "ws://travellum.herokuapp.com/ws/chat/buddha/?token=$authToken"));
  }

  Future<void> getMessageHistory() async {
    final _url = 'https://travellum.herokuapp.com/chat-api/buddha/';
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
      print(response.body);
      //final responseData = json.decode(response.body);
      print(response.statusCode);
      print('yahoo');
      // if (responseData['email']) {
      //   throw HttpException('email');
      // }
      // if (responseData['username'] != null) {
      //   throw HttpException('username');
      // }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
