// import 'dart:convert';
// import 'dart:js';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hackathon/controller/localStorage.dart';
// import 'package:hackathon/controller/localStorage.dart';
import 'dart:convert';
import 'package:hackathon/controller/api.dart';
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/main.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../widgets/dialogBox.dart';
// import 'dart:io';

class AuthController {
  Future<bool> signUp(context, String name, String email, String password,
      http.ByteStream stream, var length) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("http://${getIp()}/api/users/"));
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Create the multipart file
      var multipartFile = http.MultipartFile(
        'register',
        stream,
        length,
        filename: 'image.jpg',
        contentType: MediaType(
            'image', 'jpeg'), // Replace with the actual image MIME type
      );

      // Add the multipart file to the request
      request.files.add(multipartFile);

      var response = await request.send();
      // print(request.fields);
      // print(response.reasonPhrase);
      var responseBody = await response.stream.transform(utf8.decoder).join();
      print(responseBody); // print(response.statusCode);
      Map<String, dynamic> responseDecode = json.decode(responseBody);
      print(responseDecode);
      if (responseDecode["success"] == 0) {
        displayErrorDialog(
            context: context,
            message: responseDecode["message"],
            errorType: "Error");
        return false;
      }

      return true;
    } catch (e) {
      print(e);
      displayErrorDialog(
          context: context,
          errorType: "Server Issue",
          message: "There is a problem with the server");
      return false;
    }
  }

  Future<bool> login(context, String email, String password) async {
    try {
      // final storage = new FlutterSecureStorage();
      http.Response response = await http.post(
          Uri.parse("http://${getIp()}/api/users/login/"),
          body: jsonEncode({"email": email, "password": password}),
          headers: {"Content-Type": "application/json"});
      var jsonFormat = json.decode(response.body);
      if (jsonFormat["success"] == 0) {
        await Future.delayed(const Duration(seconds: 2));
        displayErrorDialog(
            context: context,
            message: "Invalid Email or Password",
            errorType: "Verification Issue");
        return false;
      }

      LocalStorage ls = LocalStorage();
      ls.writeToStorage('email', email);
      // ls.writeToStorage('name', )
      ls.writeToStorage('token', jsonFormat['token']);
      // print(jsonFormat['token']);
      print("Thsis is token ${jsonFormat["token"]}");
      return true;
    } catch (e) {
      print(e);
      displayErrorDialog(
          context: context,
          errorType: "Server Issue",
          message: "There is a problem with the server");
      return false;
    }
  }
}
