import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/controller/friendsController.dart';
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/controller/userController.dart';
import 'package:hackathon/pages/chat.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../controller/api.dart';
import '../model/user.dart';

class MessagesPage extends StatefulWidget {
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  LocalStorage ls = LocalStorage();
  void getUserDetails() async {
    final response = await http.get(
      Uri.parse(
          'http://${getIp()}/api/users/viewFriends/${UserController.student[0].id}'),
      headers: {
        'Authorization': 'Barear ${await ls.readFromStorage('token') as String}'
      },
    );
    print(response.body);
    var json = jsonDecode(response.body);
    var student = json["data"];
    print(student);
    FriendsController.student = List.from(student)
        .map<Student>((item) => Student.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // leading: true,
          // automaticallyImplyLeading: false,
          title: Text("Your Chats"),
          actions: [
            const VxDarkModeButton(
              showSingleIcon: true,
            ).px12().scale75()
          ],
        ),
        body: ListView.builder(
          itemCount: FriendsController.student.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(student: FriendsController.student[index]),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(FriendsController.student[index].name.toString()),
                  subtitle:
                      Text(FriendsController.student[index].email.toString()),
                  leading: Container(
                    // child: CircleAvatar(),
                    width: 50,
                    height: 50,
                    // color: Colors.black,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              image(FriendsController.student[index].image)),
                        )),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
