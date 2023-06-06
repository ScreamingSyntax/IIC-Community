import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:hackathon/model/flipfactCategories.dart';
import 'package:hackathon/pages/detailed_flashCards.dart';
import 'package:hackathon/widgets/circularIndicator.dart';

import '../controller/api.dart';
import '../widgets/popScope.dart';
import 'package:http/http.dart' as http;

class FlashcardView extends StatefulWidget {
  final String? text;

  FlashcardView({Key? key, this.text}) : super(key: key);

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  List<FlipDataItem>? data = [];
  void getFlipCards() async {
    final response = await http.get(
      Uri.parse('http://${getIp()}/api/flips/'),
      headers: {
        'Content-Type': 'application/json', // Set the Content-Type header
      },
    );
    var json = jsonDecode(response.body);
    var categories = json;
    print(categories);
    FlipApiResponse fas = FlipApiResponse.fromJson(json);
    data = fas.data;
    setState(() {});
    // FlipFactCategory ffc = FlipFactCategory(category: categories);
    // print(response.body);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getFlipCards();
  }

  @override
  Widget build(BuildContext context) {
    return data!.isEmpty
        ? myCustomLoading(context: context, message: "Loading Your Cards")
        : WillPopScope(
            onWillPop: () {
              return showExitPopup(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Flash Cards",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w900),
                            ),
                            Icon(Icons.post_add)
                          ],
                        )),
                    Divider(thickness: 3),
                  ],
                ),
                Text(""),
                Text(""),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        data!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedFlashCard(item: data![index]),
                                )),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${data![index].category}",
                                style: TextStyle(fontSize: 23),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffE0E6F3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: MediaQuery.of(context).size.width / 1.4,
                              height: MediaQuery.of(context).size.width / 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text("Please Scroll and View Categories"),
                Text(""),
              ],
            ));
  }
}
