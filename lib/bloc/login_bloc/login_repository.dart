import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/userModel.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginRepostory{
  GraphQLClient client = clientToQuery();

  updatePic(url) async{
    

  }
  
  Future<bool> hasToken() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();    
    // print(preferences.getString("LastToken"));
    // return true;
    // print("Token is .....V");
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
      cartLen:preferences.getInt("cartLen"),
      profileId: preferences.getString("profileId"),
      profilePic: preferences.getString("profilePic")
    );
    return user;
    // return preferences.getString("firstName");

  }
  setUserInfoFromGoogle(username,displayName,phone,photo) async{


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
        cartLen: data["cartSet"]["edges"].length,
        profileId: data["profile"]!=null?data["profile"]["id"]:null,
        profilePic: data["profile"]!=null?
        data["profile"]["image"].isNotEmpty?data["profile"]["image"]:
        data["profile"]["googleImage"]:null

      );
    preferences.setString("id", data["id"]);
    preferences.setString("profileId", user.profileId);
    preferences.setString("profilePic", user.profilePic);
    preferences.setString("firstName", data["firstName"]);
    preferences.setString("lastName", data["lastName"],);
    preferences.setString("username", data["username"]);
    preferences.setInt("cartLen", data["cartSet"]["edges"].length);

    return user;
    }
  }


  setToken(token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("LastToken", token); 
  }

  removeToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    preferences.setInt("cartLen", 0);

    // preferences.setString("LastToken", null);
  }
  Future<FirebaseUser> firebaseuser(AuthCredential credential) async{
        final AuthResult authResult = await _auth.signInWithCredential(credential);
        
        final FirebaseUser user = authResult.user;

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        print('signInWithGoogle succeeded: $user');
        return user;
  }

  Future<AuthCredential> signInWithGoogle() async {
  
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  return credential; 

  // final AuthResult authResult = await _auth.signInWithCredential(credential);
  // final FirebaseUser user = authResult.user;

  // assert(!user.isAnonymous);
  // assert(await user.getIdToken() != null);

  // final FirebaseUser currentUser = await _auth.currentUser();
  // assert(user.uid == currentUser.uid);
  // print('signInWithGoogle succeeded: $user');
  // return user;


  // return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  // await googleSignIn.isSignedIn()
  await googleSignIn.signOut();
  print("User Sign Out");
}


  googleLogin(username,displayName,phone,photo) async{
    print(username);
    print(displayName);
    print(phone??"");
    print(photo);

    QueryResult result = await client.mutate(
      MutationOptions(
        documentNode: gql(createGoogleUser),
        variables: {
            "displayName": displayName,
            "phone": phone??"",
            "username": username,
            "photo": photo??""
        }
      )
    );

    if(!result.hasException){
      if(result.data["createGoogleUser"]["token"]!=null)
      {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        SimpleUserModel user = SimpleUserModel(
          id: result.data["createGoogleUser"]["user"]["id"],
          firstName: displayName.split(" ")[0],
          lastName: displayName.split(" ")[1],
          username: username,
          cartLen: result.data["createGoogleUser"]["user"]["cartSet"]["edges"].length,
          profileId: result.data["createGoogleUser"]["user"]["profile"]["id"],
          profilePic:result.data["createGoogleUser"]["user"]["profile"]["image"].isNotEmpty?result.data["createGoogleUser"]["user"]["profile"]["image"]:result.data["createGoogleUser"]["user"]["profile"]["googleImage"]
        );
        preferences.setString("id", user.id);
        preferences.setString("profileId", user.profileId);
        preferences.setString("profilePic", user.profilePic);
        preferences.setString("firstName", user.firstName);
        preferences.setString("lastName", user.lastName,);
        preferences.setString("username", user.username);
        preferences.setInt("cartLen", user.cartLen);
        preferences.setString("LastToken", result.data["createGoogleUser"]["token"]);
      }
      return result.data["createGoogleUser"]["token"];
      // return {"password":result.data["createGoogleUser"]["token"],"username":username};
      // return result.data["createGoogleUser"]["token"];
    }

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