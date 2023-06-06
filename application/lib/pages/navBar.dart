import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon/controller/api.dart';
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/pages/chat.dart';
import 'package:hackathon/pages/home.dart';
import 'package:hackathon/pages/notification.dart';
import 'package:hackathon/pages/settings.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import 'cards.dart';
import 'flashCards.dart';
import 'messages.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NavBarContent extends StatefulWidget {
  const NavBarContent({super.key});

  @override
  State<NavBarContent> createState() => _NavBarContentState();
}

class _NavBarContentState extends State<NavBarContent> {
  LocalStorage ls = LocalStorage();
  String? token = "";
  String? email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.settings,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.people_alt_rounded,
      size: 30,
      color: Colors.white,
    )
  ];
  int currentIndex = 0;
  List<Widget> pages = [HomePage(), Forums(), FlashcardView(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagesPage(),
              )),
          child: Icon(FontAwesomeIcons.facebookMessenger),
        ),
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage())),
                child: const Icon(FontAwesomeIcons.bell).px12().scale75()),
            const VxDarkModeButton(
              showSingleIcon: true,
            ).scale75()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            print(currentIndex);
            setState(() {});
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_filled),
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              // activeIcon: Icon(Icons.car_crash),
              icon: Icon(Icons.person_pin_outlined),
              label: 'Posts',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'FAQ',
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              // backgroundColor: Colors.pink,
            ),
          ],
        ),
        body: pages.elementAt(currentIndex));
  }
}
