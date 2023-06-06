// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/controller/userController.dart';
import 'package:hackathon/model/message.dart';
import 'package:hackathon/widgets/circularIndicator.dart';
import 'package:http/http.dart' as http;
import 'package:hackathon/model/user.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/api.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  final Student student;
  const ChatPage({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool send = false;
  bool empty = false;

  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Message> message = [];
  LocalStorage ls = LocalStorage();
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  bool isLoading = false;
  bool isSending = false;

  _validation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // setState(() {
      //   networkAction = false;
      // });
      sendMessage();
      getUserDetails();
      setState(() {
        isSending = true;
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isSending = false;
      });
      send = true;
    }
  }

  void sendMessage() async {
    final response = await http.post(
      Uri.parse('http://${getIp()}/api/users/sendChat'),
      headers: {
        'Content-Type': 'application/json', // Set the Content-Type header
        'Authorization': 'Bearer ${await ls.readFromStorage('token') as String}'
      },
      body: jsonEncode({
        "sender_id": UserController.student[0].id,
        "reciever_id": widget.student.id,
        "message": _messageController.text
      }),
    );
  }

  void getUserDetails() async {
    try {
      final response = await http.post(
        Uri.parse('http://${getIp()}/api/users/viewChat'),
        headers: {
          'Content-Type': 'application/json', // Set the Content-Type header
          'Authorization':
              'Bearer ${await ls.readFromStorage('token') as String}'
        },
        body: jsonEncode({
          "sender_id": UserController.student[0].id,
          "reciever_id": widget.student.id
        }),
      );
      print(response.body);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> messagesData = jsonData['data'];
      if (messagesData.isEmpty) {
        empty = true;
        setState(() {});
      } else {
        message = messagesData
            .map((messageData) => Message.fromJson(messageData))
            .toList();

        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: empty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text("Start A Conversation With ${widget.student.name}"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _messageController,
                      validator: (value) {
                        if (value.isEmptyOrNull) {
                          return "Message field cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Write a message here",
                          suffixIcon: InkWell(
                              onTap: () => _validation(context),
                              child: Icon(Icons.send))),
                    ),
                  ),
                ),
              ],
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ? Expanded(
                          child: Center(
                              child: myCustomLoading(
                                  context: context,
                                  message: "Sending Message")))
                      : Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: message.length,
                              itemBuilder: (context, index) {
                                final currentMessage = message[index];

                                // Check if the receiver ID is equal to the student ID
                                final alignLeft = currentMessage.receiverId ==
                                    widget.student.id;

                                return Row(
                                  mainAxisAlignment: alignLeft
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: alignLeft
                                            ? Colors.blue
                                            : Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        currentMessage.message.toString(),
                                        style: TextStyle(
                                            color: alignLeft
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      maxLines: null,
                      controller: _messageController,
                      validator: (value) {
                        if (value.isEmptyOrNull) {
                          return "Message field cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message),
                          hintText: "Write a message here",
                          suffixIcon: isSending
                              ? Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator())
                              : InkWell(
                                  onTap: () => _validation(context),
                                  child: Icon(Icons.send))),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
