import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/controller/authController.dart';
import 'package:hackathon/routes/routes.dart';
import 'package:hackathon/widgets/dialogBox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import '../validation/validation.dart';
import '../widgets/circularIndicator.dart';
import '../widgets/textFormDecoration.dart';
// import 'package:hackathon/widgets/theme.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  bool eyeClicked = true;
  bool eyeClicked2 = true;
  String password1 = "";

  String password2 = "";

  bool networkCheck = true;
  bool verified = true;

  final name = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _validation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showSpinner = true;
      });
      setState(() {
        networkCheck = false;
      });
      var stream = http.ByteStream(image!.openRead());
      print("The stream is ${stream}");
      stream.cast;
      var length = await image!.length();
      AuthController ac = AuthController();
      // ignore: use_build_context_synchronouslys
      bool signUp = await ac.signUp(
          context, name.text, email.text, password.text, stream, length);
      print(signUp);
      if (signUp == true || signUp == false) {
        setState(() {
          showSpinner = false;
        });
        setState(() {
          networkCheck = true;
        });
      }
      if (signUp) {
        setState(() {
          verified = false;
        });
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, MyRoutes.loginPage);
        setState(() {
          verified = true;
        });
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
    return verified
        ? networkCheck
            ? ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: topContent(context),
                          ),
                          GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: (image == null)
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.amber,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/vector/login.png"))),
                                    )
                                  : Container(
                                      width: 110,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // color: Colors.amber,
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(image!.path).absolute))),
                                    )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: [
                                midldleContent(context),
                                const SizedBox(
                                  height: 5,
                                ),
                                lowerContext(context),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : myCustomLoading(
                context: context, message: "Verifying Credentials")
        : myCustomLoading(context: context, message: "Successfully Registered");
  }

  Widget topContent(BuildContext context) => Column(
        children: [
          Text(
            "Sign Up",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 17,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Create an New Account",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 25,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          )
        ],
      );

  Widget midldleContent(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Full Name"),
                TextFormField(
                  controller: name,
                  decoration: MyTextFormField(context),
                  validator: (value) {
                    NameValidation ac = NameValidation(
                        value: value,
                        validationType: "Name",
                        minLength: 4,
                        maxLength: 10);
                    String? error = ac.empty();
                    if (error != null) {
                      return "Name Field Cannot be empty";
                    }
                    error = ac.specialCharacters();
                    if (error != null) {
                      return "Name Field Cannot have special Characters";
                    }
                    error = ac.fullNameValidation();
                    if (error != null) {
                      return "Please Enter First and Last Name Only";
                    }
                    return null;
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email"),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    EmailValidation ac = EmailValidation(
                        value: value,
                        validationType: "Email",
                        minLength: 4,
                        maxLength: 50);
                    String? error = ac.empty();
                    if (error != null) {
                      return "Email Field Cannot be Empty";
                    }
                    error = ac.domainValidation();
                    if (error != null) {
                      return "Domain of iic.edu.np is only supported ";
                    }
                    return null;
                  },
                  decoration: MyTextFormField(context),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password"),
                TextFormField(
                  obscureText: eyeClicked,
                  controller: password,
                  onChanged: (value) {
                    password1 = value;
                    setState(() => {});
                  },
                  validator: (value) {
                    PasswordValidation ac = PasswordValidation(
                      value: value,
                      validationType: "Password",
                      minLength: 7,
                      maxLength: 20,
                    );
                    String? error = ac.empty();
                    if (error != null) {
                      return "Password Field Cannot be empty";
                    }
                    error = ac.length();
                    if (error != null) {
                      return "Password Field Cannot have less than 7 characters";
                    }
                    error = ac.passwordSecurity();
                    if (error != null) {
                      return "Please Enter a Stronger Password";
                    }
                    if (password2 != value) {
                      return "${ac.validationType} Field do not match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    helperText: "",
                    suffixIcon: InkWell(
                        onTap: () {
                          eyeClicked = !eyeClicked;
                          setState(() {});
                          print(eyeClicked);
                        },
                        child: !eyeClicked
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash)),
                    // helperText: "",
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error, width: 2),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error, width: 2),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Confirm Password"),
                TextFormField(
                  obscureText: eyeClicked2,
                  onChanged: (value) {
                    password2 = value;
                    setState(() => {});
                  },
                  validator: (value) {
                    PasswordValidation ac = PasswordValidation(
                        value: value,
                        validationType: "Password",
                        minLength: 7,
                        maxLength: 20);
                    // print(password.toString());
                    if (value == "") {
                      return "Password Field cannot be empty";
                    }
                    if (password.text != password2) {
                      return "${ac.validationType} Field do not match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    helperText: "",
                    suffixIcon: InkWell(
                        onTap: () {
                          eyeClicked2 = !eyeClicked2;
                          setState(() {});
                          // print(eyeClicked);
                        },
                        child: !eyeClicked2
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash)),
                    // helperText: "",
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error, width: 2),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error, width: 2),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget lowerContext(BuildContext context) => Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              print(password.text);
              print(password2.toString());
              return _validation(context);
            },
            child: const Text("Signup"),
            style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(
                    MediaQuery.of(context).size.width / 0.4,
                    MediaQuery.of(context).size.height / 15))),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              InkWell(
                onTap: () => Navigator.pushNamed(context, MyRoutes.loginPage),
                child: Text(
                  " Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              )
            ],
          ),
        ],
      );
}
