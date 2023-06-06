// import 'package:flutter/cupertino.dart';

// class HomePage extends StatelessWidget{
//   @override
//   Widget build(BuildContext contexx)
// }

import 'dart:convert';
// import 'dart:html';
// import 'package:flip_card/flip_card.dart';/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/controller/threeFlasCard.dart';
import 'package:hackathon/controller/userController.dart';
import 'package:hackathon/model/article.dart';
import 'package:hackathon/model/user.dart';
import 'package:http/http.dart' as http;

import '../controller/api.dart';
import '../model/threeflipfact.dart';
import '../widgets/popScope.dart';
import 'flashCards.dart';
// import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ArticleModel> article = [];
  String? token = "";
  String? email = "";
  LocalStorage ls = LocalStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readToken();
    // getUserDetail();
    getUserDetails();
    getArticleDetails();
    getCommunityDetails();
  }

  void readToken() async {
    var tokenRead = await ls.readFromStorage('token');
    token = tokenRead;
    var emailRead = await ls.readFromStorage('email');
    email = emailRead;

    print(email);
    getUserDetail(email.toString(), token.toString());
  }

  void getUserDetail(String emailNew, String tokenNew) async {
    print("hello");
    // print(email);
    // Future.delayed(Duration(seconds: 2));
    final response = await http.get(
      Uri.parse('http://${getIp()}/api/users/$emailNew'),
      headers: {'Authorization': 'Barear $tokenNew'},
    );
    var json = jsonDecode(response.body);
    var studentData = json["message"];
    print(studentData);
    UserController.student =
        studentData.map<Student>((item) => Student.fromJson(item)).toList();
    // = one;
    print(UserController.student[0].email);
  }

  void getUserDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://${getIp()}/api/flips/three'),
      );
      // print(response.body);
      // print(UserController.student[0]);
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> data = json['data'];
      ThreeFlasCard.cards =
          data.map((item) => ThreeFlipFact.fromJson(item)).toList();
      setState(() {});
      // print(ThreeFlasCard.cards[0].);
    } catch (e) {
      print(e);
    }
  }

  void getArticleDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://${getIp()}/api/article'),
      );
      Map<String, dynamic> json = jsonDecode(response.body);

      var data = json["message"];
      article = data
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void getCommunityDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://${getIp()}/api/communities'),
      );
      Map<String, dynamic> json = jsonDecode(response.body);
      print("oNe");
      var data = json["message"];

      print(data);
      // article = data
      //     .map<ArticleModel>((json) => ArticleModel.fromJson(json))
      // .toList();
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
        body: SingleChildScrollView(
          child: Column(children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Flash Cards",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: MediaQuery.of(context).size.width / 18),
            //       ),
            //       InkWell(
            //         onTap: () => Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => FlashcardView(),
            //             )),
            //         child: Container(
            //           child: Text(
            //             "View Cards",
            //             style: TextStyle(
            //                 fontSize: MediaQuery.of(context).size.width / 25),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: List.generate(
            //       ThreeFlasCard.cards.length,
            //       (index) => FlipCard(
            //         fill: Fill
            //             .fillBack, // Fill the back side of the card to make in the same size as the front.
            //         direction: FlipDirection.HORIZONTAL, // default
            //         side: CardSide.FRONT, // The side to initially display.
            //         front: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //           child: Container(
            //             alignment: Alignment.center,
            //             child: Text("${ThreeFlasCard.cards[0].cardTitle}"),
            //             decoration: BoxDecoration(
            //               color: Colors.red,
            //               borderRadius: BorderRadius.circular(6),
            //             ),
            //             width: MediaQuery.of(context).size.width / 1.5,
            //             height: MediaQuery.of(context).size.width / 2,
            //           ),
            //         ),
            //         back: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //           child: Container(
            //             alignment: Alignment.center,
            //             child:
            //                 Text("${ThreeFlasCard.cards[0].cardDescription}"),
            //             decoration: BoxDecoration(
            //               color: Colors.red,
            //               borderRadius: BorderRadius.circular(6),
            //             ),
            //             width: MediaQuery.of(context).size.width / 1.5,
            //             height: MediaQuery.of(context).size.width / 2,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Did you know?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 18),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Row(
                  children: article.map<Widget>((article) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          // Handle article tap event
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffE0E6F3),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  article.subtitle,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Expanded(
                                  child: Text(
                                    article.description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "College Communities",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 18),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Community 1"),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur, adipisicing elit. ",
                        ),
                      ),
                      ElevatedButton(onPressed: null, child: Text("Apply"))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Community 1"),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur, adipisicing elit. ",
                        ),
                      ),
                      ElevatedButton(onPressed: null, child: Text("Apply"))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2,
                ),
              ]
                  .map((e) => Padding(
                        padding: EdgeInsets.all(10),
                        child: e,
                      ))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Community 3"),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur, adipisicing elit. ",
                        ),
                      ),
                      ElevatedButton(onPressed: null, child: Text("Apply"))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Community 4"),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur, adipisicing elit. ",
                        ),
                      ),
                      ElevatedButton(onPressed: null, child: Text("Apply"))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2,
                ),
              ]
                  .map((e) => Padding(
                        padding: EdgeInsets.all(10),
                        child: e,
                      ))
                  .toList(),
            )
          ]),
        ),
      ),
    );
  }
}
