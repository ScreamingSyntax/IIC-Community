import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/dialogBox.dart';
import 'package:http_parser/http_parser.dart';

import 'api.dart';

class MakePost {
  Future<bool> signUp(
      context,
      String thread_title,
      String thread_description,
      int user_id,
      String creationDate,
      http.ByteStream stream,
      var length) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("http://${getIp()}/api/thread/"));
      request.fields['thread_title'] = thread_title;
      request.fields['thread_description'] = thread_description;
      request.fields['user_id'] = user_id.toString();
      request.fields['creationDate'] = creationDate;
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
}
