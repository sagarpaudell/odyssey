import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Chat with ChangeNotifier {
  final String userId;
  final String username;
  final String authToken;
  WebSocketChannel channel;
  List<Map<String, dynamic>> chatMessages = [];

  List<dynamic> messageData;

  Chat([this.username, this.userId, this.authToken]);
  WebSocketChannel sendMessage(String friendUserName) {
    try {
      channel = new WebSocketChannel.connect(Uri.parse(
          "ws://travellum.herokuapp.com/ws/chat/$friendUserName/?token=$authToken"));

      // channel.sink.add(json.encode({'message': 'Tuna'}));
    } catch (e) {
      ///
      /// An error occurred
      ///
    }
    notifyListeners();
    return channel;
    //https://travellum.herokuapp.com/chat-api/sagar/
    // return WebSocketChannel.connect(Uri.parse(
    //     "ws://travellum.herokuapp.com/ws/chat/buddha/?token=$authToken"));
  }

  addImmediateMsg() {
    print('current message is $chatMessages');
    channel.stream.listen((message) {
      chatMessages.add({
        'sender': {'username': json.decode(message)['sender']},
        'message_text': json.decode(message)['message'],
        'message_time': json.decode(message)['time']
      });

      notifyListeners();
    });
  }

  Future<List<dynamic>> getMessageHistory(String friendUserName) async {
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
      //notifyListeners();
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

  setChatMessagesEmpty() {
    chatMessages = [];
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

  Future<void> deleteChat(String friendUserName) async {
    final _url = 'https://travellum.herokuapp.com/chat-api/$friendUserName';
    try {
      final response = await http.delete(
        Uri.parse(_url),
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
