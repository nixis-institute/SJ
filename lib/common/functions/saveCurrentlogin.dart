import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/userModel.dart';
import 'dart:convert';
// import '../model/loginModel.dart';

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

// dynamic GetUser(id) async {
//   GraphQLClient _client = clientToQuery();
  
//   QueryResult result = await _client.query(
//     QueryOptions(
//       documentNode: gql(getUser),
//       variables:{
//         "Id":id,
//         }
//     )
//   );

//   if(!result.hasException)
//   {
//     // print(object)
//     print("no exception");
//     return result.data["user"];
//   }
//   else{
//     print("nexception");
//     return null;
//   }

// }





saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var user;
  if ((responseJson != null && !responseJson.isEmpty)) {
    user = LoginModel.fromJson(responseJson).userName;
  } else {
    user = "";
  }
  var username = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).userName : ""; 
  var token = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).token : "";
  var email = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).email : "";
  var pk = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).userId : 0;

  // LoginModel()

  final parts = token.split(".");
  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  int id = payloadMap["user_id"];
  username = payloadMap["username"];
  // var data = GetUser(id);
  // print("--V");
  // var 
  // print(data["id"]);
  // print(GetUser(id));


  await preferences.setString('LastUser', (username != null && username.length > 0) ? username : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
  await preferences.setString('LastEmail', (email != null && email.length > 0) ? email : "");
  await preferences.setInt('LastUserId', (pk != null && pk > 0) ? pk : 0);
  await preferences.setInt('Id', ( id!= null && id > 0) ? id : 0);
}