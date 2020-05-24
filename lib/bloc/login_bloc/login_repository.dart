import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/userModel.dart';

class LoginRepostory{
  GraphQLClient client = clientToQuery();

  Future<bool> hasToken() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();    
    // print(preferences.getString("LastToken"));
    // return true;
    print("Token is .....V");
    print(preferences.getString("LastToken"));
    // return false;
    return preferences.getString("LastToken")==null?false:true;
  }
  Future<SimpleUserModel> getPersistInfo() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    SimpleUserModel user = SimpleUserModel( 
    id:preferences.getString("id"),
    firstName:preferences.getString("firstName"),
    lastName:preferences.getString("lastName"),
    username:preferences.getString("username"),
    cartLen:preferences.getInt("cartLen")
    );
    return user;
    // return preferences.getString("firstName");

  }

  setUserInfo() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    QueryResult result = await client.query(
      QueryOptions(
        documentNode: gql(currentUserQuery)
      )
    );

    if(!result.hasException){
      var data = result.data["user"];
      SimpleUserModel user = SimpleUserModel(
        id: data["id"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        username: data["username"],
        cartLen: data["cartSet"]["edges"].length
      );
    preferences.setString("id", data["id"]);
    preferences.setString("firstName", data["firstName"]);
    preferences.setString("lastName", data["lastName"],);
    preferences.setString("username", data["username"]);
    preferences.setInt("cartLen", data["cartLen"]);

    // return user;
    }
  }


  setToken(token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("LastToken", token); 
  }

  removeToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("LastToken", null);
  }

  login(username,password) async{
    QueryResult result = await client.mutate(
      MutationOptions(
        documentNode: gql(getTokenQuery),
        variables: {
          "username":username,
          "password":password
        }
      )
    );

    if(!result.hasException){
      var token = result.data["tokenAuth"]["token"];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("LastToken", token);
      return token;
    }
  }
}