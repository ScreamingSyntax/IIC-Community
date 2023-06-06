// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon/controller/makePost.dart';
import 'package:hackathon/controller/userController.dart';
import 'package:hackathon/pages/cards.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/model/user.dart';

import '../widgets/dialogBox.dart';
import '../widgets/popScope.dart';

// ignore: must_be_immutable
class PostPage extends StatefulWidget {
  Student st;
  PostPage({
    Key? key,
    required this.st,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  File? image;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  final headingController = TextEditingController();

  final bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.st.id);
    print(widget.st.email);
    print(widget.st.image);
    print(widget.st.name);
    // print(widget.st.id);

    // getStudentData();
  }

  String getDate() {
    final date = DateTime.now();
    final year = date.year;
    final month = date.month;
    final day = date.day;
    String finalDate = "${year}-${month}-${day}";
    return finalDate;
  }

  void _validation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showSpinner = true;
      });
      var stream = http.ByteStream(image!.openRead());
      print("The stream is ${stream}");
      stream.cast;
      var length = await image!.length();
      MakePost mp = MakePost();
      int? user_id = UserController.student[0].id;
      String date = getDate();
      bool makePost = await mp.signUp(context, headingController.text,
          bodyController.text, user_id!, date, stream, length);
      if (makePost == true || makePost == false) {
        setState(() {
          showSpinner = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Forums(),
            ));
      }
    }
  }

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      displayErrorDialog(
          context: context,
          message: "Image upload Error",
          errorType: "No Image selected :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        excludeHeaderSemantics: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close)),
        // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.amber),
        // bottom: PreferredSize(child: SizedBox(), preferredSize: Size(100, 100)),
        title: Text('Make Post'),
        actions: [],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text("a")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title:
                                Text(UserController.student[0].name.toString()),
                            subtitle: Text(
                                UserController.student[0].email.toString()),
                            leading: Container(
                              // child: CircleAvatar(),
                              width: 50,
                              height: 50,

                              child: Icon(Icons.people),
                            ),
                          ),
                        ),
                        VxTextField(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "The Heading cannot be empty";
                            }
                            return null;
                          },
                          controller: headingController,
                          maxLine: null,
                          hint: "Enter Heading",
                          autovalidateMode: AutovalidateMode.always,
                          textAlign: TextAlign.center,
                          hintStyle: TextStyle(),
                          labelText: "Heading",
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                        ),
                        VxTextField(
                          autovalidateMode: AutovalidateMode.always,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "The Description cannot be empty";
                            }
                            return null;
                          },
                          controller: bodyController,
                          maxLine: 5,
                          hint: "Enter Description",
                          labelText: "Description",
                        ),
                      ],
                    ),
                  ),
                  if (image == null)
                    SizedBox(
                      height: 10,
                    ),
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Image.file(File(image!.path).absolute),
                    ),
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(
                              MediaQuery.of(context).size.width / 1.2,
                              MediaQuery.of(context).size.height / 17))),
                      onPressed: () => getImage(),
                      child: image != null
                          ? Text("Change Image")
                          : Text("Choose Image")),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(
                              MediaQuery.of(context).size.width / 1.2,
                              MediaQuery.of(context).size.height / 17))),
                      onPressed: () => _validation(context),
                      child: Text("Post"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
