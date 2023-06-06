import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/model/notificationmodel.dart';
import 'package:hackathon/widgets/circularIndicator.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/api.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notification = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotification();
  }

  void getNotification() async {
    try {
      final response = await http.get(
        Uri.parse('http://${getIp()}/api/article/notification'),
      );
      // print(response.body);
      // print(UserController.student[0]);
      var json = jsonDecode(response.body);
      // List<dynamic> data = json;
      // ThreeFlasCard.cards =
      // json.map<ArticleModel>((json) => ArticleModel.fromJson(json)).toList();
      var data = json["message"];
      notification = data
          .map<NotificationModel>((json) => NotificationModel.fromJson(json))
          .toList();
      // article = json.map((item) => NotificatioNModel.fromJson(json)).toList();
      // setState(() {});
      setState(() {});
      // print(ThreeFlasCard.cards[0].);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return notification.isEmpty
        ? myCustomLoading(context: context, message: "Loading Notifications")
        : Scaffold(
            appBar: AppBar(
                // title: Text('Notifications'),
                ),
            body: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest Notifications",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        Icon(Icons.notifications_active_outlined)
                      ],
                    )),
                const Divider(thickness: 3),
                ListView.builder(
                  itemCount: notification.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(FontAwesomeIcons.speakap),
                          title: Text("${notification[index].sender}"),
                          subtitle:
                              Text("Subject: ${notification[index].subject}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 73, right: 50),
                          child: Container(
                            child:
                                Text("${"${notification[index].description}"}"),
                          ),
                        ),
                        const Divider(thickness: 3),
                      ],
                    );
                  },
                )
              ],
            ),
          );
  }
}
