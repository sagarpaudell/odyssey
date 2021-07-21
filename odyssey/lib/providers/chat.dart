import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Chat with ChangeNotifier {
  final String userId;
  final String username;
  String friendUserName;
  final String authToken;
  List<dynamic> messageData;
  Chat([this.username, this.userId, this.authToken]);
  WebSocketChannel sendMessage() {
    WebSocketChannel channel;
    try {
      channel = new WebSocketChannel.connect(Uri.parse(
          "ws://travellum.herokuapp.com/ws/chat/$friendUserName/?token=$authToken"));
      // channel.sink.add(json.encode({'message': 'Tuna'}));
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

  Future<List<dynamic>> getMessageHistory() async {
    print(friendUserName);
    print(username);
    final _url = 'https://travellum.herokuapp.com/chat-api/$friendUserName';
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
      messageData = json.decode(response.body);
      // messageData.forEach((element) {
      //   print(element['sender']['username']);
      // });
      // print(DateFormat.yMMMd(json.decode(response.body)[1]['message_time']));
      //final responseData = json.decode(response.body);

      return messageData;
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

  Future<List<dynamic>> getChatOverview() async {
    final _url = 'https://travellum.herokuapp.com/chat-api/';
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
      messageData = json.decode(response.body);
      // messageData.forEach((element) {
      //   print(element['sender']['username']);
      // });
      // print(DateFormat.yMMMd(json.decode(response.body)[1]['message_time']));
      //final responseData = json.decode(response.body);
      return messageData;
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
