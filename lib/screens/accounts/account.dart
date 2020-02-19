import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/userModel.dart';
import 'package:shopping_junction/widgets/profile.dart';

class ProfileScreen extends StatefulWidget{
  @override
  final int uid;
  ProfileScreen({this.uid});
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  UserModel user;

  void updateUser() async{
    // print(uid);
    GraphQLClient _client = clientToQuery();
  
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getUser),
        variables:{
          "id":this.widget.uid,
          }
      )
    );

    if(result.loading)
    {
      setState(() {
        loading = true;
      });
    }

    if(!result.hasException)
    {
      setState(() {
        loading=false;
      });
      // print(result);
      var d = result.data["user"];

      var phone,gender = "";



      if(d["profile"]!= null)
      {
        phone = d["profile"]["phoneNumber"]??"";
        gender = d["profile"]["gender"]??"";
      }

      List<Address> adds = [];
      // print(d["addressSet"]["edges"][0]["node"]["houseNo"]);
      List t = d["addressSet"]["edges"];
      for(int j=0;j<t.length;j++)
      {
        // print(t[j]["node"]["houseNo"]);
        
        adds.add(Address(t[j]["node"]["id"],
          t[j]["node"]["houseNo"],
          t[j]["node"]["colony"],
          t[j]["node"]["personName"],
          t[j]["node"]["landmark"],
          t[j]["node"]["city"],
          t[j]["node"]["state"],
          t[j]["node"]["phoneNumber"].toString(),
          t[j]["node"]["alternateNumber"].toString()
          ));
      }

      setState(() {
        user = UserModel(
          d["username"],
          d["id"],d["firstName"],
          d["lastName"],
          d['email'],
          phone,
          gender,
          adds,
          );
      });
    }
    if(result.hasException)
    {
      print(result.exception.toString());
    }
    

  }

_clear() async{
  final pref = await SharedPreferences.getInstance();
  pref.clear();
}


  // int uid;
  bool loading = true;
  @override
  void initState()
  {
    super.initState();
    // _loadUser();
    updateUser();
  }

  // _loadUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = (prefs.getInt('Id'));
  //     // user = (prefs.getString("LastUser"));
  //   });
  // }


  Widget build(BuildContext context){
    // print(uid);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 25,
            color: Colors.white,
            onPressed: (){},
          ),          
        ],
      ),
      
      body: loading?Center(child: CircularProgressIndicator()):
      
      ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.fromBorderSide(BorderSide.lerp(, b, t) )
            ),
            child: Column(
              children: <Widget>[
                // Text(user.username)
                // loading?Center(child: CircularProgressIndicator()):
                SizedBox(height: 15,),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("assets/category/1.jpg",),
                ),
                SizedBox(height: 10,),
                Text(user.firstName+" "+ user.lastName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                // Text(user.firstName)
              ],
            )
          ),
          Container(
            child: Column(children: <Widget>[
              // ListTile(trailing: Icon(Icons.info),)
              ListTile(leading: Icon(Icons.shopping_cart), title: Text("My Orders",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("My Info",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>MyInfo(
                    user:user
                    // uid:uid
                  )));
                },
                ),
              ListTile(leading: Icon(Icons.home),title: Text("My Address",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),),
              
              ListTile(leading: Icon(Icons.power_settings_new,color: Colors.red,),title: Text('Logout',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
              onTap:(){
              _clear();
              Navigator.pop(context);

              } 
              )
            ],),
          )
        ],
      )

    );
  }
}
