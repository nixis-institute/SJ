import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/functions/saveCurrentlogin.dart';
import 'package:shopping_junction/models/userModel.dart';
// import 'dart:convert';
// import '../model/loginModel.dart';

// import './saveCurrentLogin.dart';
// String getJsonFromJWT(String splittedToken){
//   String normalizedSource = base64Url.normalize(encodedStr);
//   return utf8.decode(base64Url.decode(normalizedSource));
// }


Future<LoginModel> requestLoginApi(BuildContext context,String username,String password) async {



  // final url = "http://10.0.2.2:8000/api-token-auth/";
  final url = server_url+"/api-token-auth/";
  // final url = "http://mybebo.pythonanywhere.com/api-token-auth/";

    Map<String, String> body = {
    'username': username,
    'password': password,
  };

  final response = await http.post(
    url,
    body: body,
  );


  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    var user = new LoginModel.fromJson(responseJson);

    saveCurrentLogin(responseJson);

    // Navigator.of(context).pushReplacementNamed('/HomeScreen');

    return LoginModel.fromJson(responseJson);
  } else {
    final responseJson = json.decode(response.body);

    print("error");
    // saveCurrentLogin(responseJson);
    //showDialogSingleButton(context, "Unable to Login", "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.", "OK");
    return null;
  }
  


}