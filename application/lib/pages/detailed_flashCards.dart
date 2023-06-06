// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon/widgets/circularIndicator.dart';
import 'package:http/http.dart' as http;

import 'package:hackathon/model/flipfactCategories.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/api.dart';
import '../model/threeflipfact.dart';
import 'notification.dart';

// ignore: must_be_immutable
class DetailedFlashCard extends StatefulWidget {
  FlipDataItem item;
  DetailedFlashCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DetailedFlashCard> createState() => _DetailedFlashCardState();
}

class _DetailedFlashCardState extends State<DetailedFlashCard> {
  List<ThreeFlipFact> cards = [];
  bool loadingState = false;
  void getFlashCards() async {
    final response = await http.post(
      Uri.parse('http://${getIp()}/api/flips/cat/'),
      headers: {
        'Content-Type': 'application/json', // Set the Content-Type header
      },
      body: jsonEncode({"category": "${widget.item.category}"}),
    );
    // print(response.body);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> data = json['data'];
    cards = data.map((item) => ThreeFlipFact.fromJson(item)).toList();
    print(cards);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFlashCards();
  }

  @override
  Widget build(BuildContext context) {
    return cards.isEmpty
        ? myCustomLoading(context: context, message: "Loading your cards")
        : Scaffold(
            appBar: AppBar(
              leading: null,
              title: Text("${cards[0].category} Cards"),
              centerTitle: true,
              // automaticallyImplyLeading: false,
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
            body: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: cards.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // Set the number of grid tiles per row
                        childAspectRatio:
                            1.0, // Set the aspect ratio to create even-sized tiles
                      ),
                      itemBuilder: (context, index) {
                        final fact = cards[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridTile(
                            child: FlipCard(
                              back: Container(
                                color: Colors
                                    .red, // Set your desired color for the tile
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        fact.cardDescription ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        fact.category ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              front: Container(
                                color: Colors
                                    .red, // Set your desired color for the tile
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        fact.cardTitle ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        fact.category ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ]),
            ));
  }
}
