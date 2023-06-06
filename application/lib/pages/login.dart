import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/controller/authController.dart';
import 'package:hackathon/pages/signup.dart';
import 'package:hackathon/routes/routes.dart';
import 'package:hackathon/widgets/circularIndicator.dart';
// import 'package:hackathon/routes/routes.dart';
import 'package:hackathon/widgets/textFormDecoration.dart';

import '../validation/validation.dart';
// import 'package:hackathon/widgets/theme.dart';
// import 'package:keyboard_detection/keyboard_detection.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool eyeClicked = true;
  bool networkAction = true;
  bool verified = true;
  // bool textFormField = false;
  // GlobalKey<FormState> _formKey = GlobalKey()
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  _validation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        networkAction = false;
      });
      AuthController ac = AuthController();
      bool login = await ac.login(
          context, emailController.text, passwordController.text);
      if (login == true || login == false) {
        setState(() {
          networkAction = true;
        });
      }
      if (login) {
        print(login);
        setState(() {
          verified = false;
        });
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, MyRoutes.homePage);
        // setState(() {
        //   verified = true;
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return verified
        ? networkAction
            ? Scaffold(
                // resizeToAvoidBottomInset: false,
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: SafeArea(
                    // maintainBottomViewPadding: false,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          upperContent(context),
                          forms(context),
                          bottomContent(context)
                        ],
                      ),
                    ),
                  ),
                ))
            : myCustomLoading(
                context: context, message: "Verifying Credentials")
        : myCustomLoading(
            context: context, message: "Successfully Logged in 😊");
  }

  Widget upperContent(BuildContext context) => Column(
        children: [
          Image.asset(
            "assets/vector/login.png",
            width: MediaQuery.of(context).size.width / 1.4,
          ),
          Text(
            "Welcome back!",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 17,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Login in to your account",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 25,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  Widget forms(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email"),
                TextFormField(
                    controller: emailController,
                    validator: (value) {
                      EmailValidation bc = EmailValidation(
                          value: value,
                          validationType: "Email",
                          minLength: 4,
                          maxLength: 50);
                      String? error = bc.empty();
                      if (error != null) {
                        return "Email Field Cannot be empty";
                      }
                      error = bc.domainValidation();
                      if (error != null) {
                        return "Domain of iic.edu.np are only supported";
                      }
                      return null;
                    },
                    decoration: MyTextFormField(context))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password"),
                TextFormField(
                  controller: passwordController,
                  obscureText: eyeClicked,
                  validator: (value) {
                    PasswordValidation ac = PasswordValidation(
                      value: value,
                      validationType: "Password",
                      minLength: 7,
                      maxLength: 20,
                    );
                    String? error = ac.empty();
                    if (error != null) {
                      // _showToast(error);
                      return "Password Field Cannot Be Empty";
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
                            ? Icon(CupertinoIcons.eye)
                            : Icon(CupertinoIcons.eye_slash)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      );

  Widget bottomContent(BuildContext context) => Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              _validation(context);
            },
            style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(
                    MediaQuery.of(context).size.width / 1.15,
                    MediaQuery.of(context).size.height / 15))),
            child: Text("Login"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    )),
                child: Text(
                  " Signup",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              )
            ],
          ),
        ],
      );
}
