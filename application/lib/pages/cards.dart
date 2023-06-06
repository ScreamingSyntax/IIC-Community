import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/controller/userController.dart';
import 'package:hackathon/model/loadThread.dart';
import 'package:hackathon/model/user.dart';
import 'package:hackathon/pages/post.dart';
import 'package:http/http.dart' as http;
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/routes/routes.dart';

import '../controller/api.dart';
import '../widgets/popScope.dart';
import '../widgets/sessionExpiredBox.dart';
// import 'package:hackathon/routes/routes.dart';
// import 'package:velocity_x/velocity_x.dart';

class Forums extends StatefulWidget {
  const Forums({super.key});

  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  LocalStorage ls = LocalStorage();
  String? token = "";
  String? email = "";
  List<Thread> thread = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readToken();
    getThreadDetails();
  }

  void getThreadDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://${getIp()}/api/thread/'),
      );
      var json = jsonDecode(response.body);
      final List<dynamic> message = json['message'];
      thread = message.map<Thread>((item) => Thread.fromJson(item)).toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(5),
            constraints: const BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // VxDarkModeButton(),
                //  VxDarkModeMutation(isDarkMode),
                // Text("$email"),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest on IIC",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostPage(st: UserController.student[0]),
                                  ));
                            },
                            child: Icon(Icons.post_add))
                      ],
                    )),
                Divider(thickness: 3),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: thread.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          color: Theme.of(context).cardColor,
                          // width: MediaQuery.of(context).size.width / 1.1,
                          // height: MediaQuery.of(context).size.width / 11,
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${thread[index].threadTitle}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              22),
                                ),
                                Text(
                                  "Created on ${thread[0].creationDate}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              35),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${thread[0].threadDescription}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              35),
                                ),
                                Image.network(image(thread[index].imagePath)),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [Text("21.5K"), Text("likes")],
                                    ),
                                    Column(
                                      children: [Text("21.5K"), Text("likes")],
                                    ),
                                    Column(
                                      children: [Text("9"), Text("Comments")],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                // ElevatedButton(
                //     onPressed: () {
                //       ls.deleteAll();
                //       Navigator.pushReplacementNamed(context, MyRoutes.loginPage);
                //     },
                //     child: Text("Log Out"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
