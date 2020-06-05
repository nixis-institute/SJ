import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/bloc/login_bloc/login_bloc.dart';
import 'package:shopping_junction/models/userModel.dart';
import 'package:shopping_junction/screens/accounts/checkpassword.dart';
import 'package:shopping_junction/screens/orders/order_list.dart';

import '../profile.dart';
import 'addressScreen.dart';
// import 'package:shopping_junction/widgets/profile.dart';

class ProfileScreen extends StatefulWidget{
  @override
  // SimpleModelUser
  SimpleUserModel user;
  final int uid;
  ProfileScreen({this.uid,this.user});
  _ProfileScreenState createState() => _ProfileScreenState();
}


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}



class _ProfileScreenState extends State<ProfileScreen>{
  UserModel user;
  Widget _simplePopup() => PopupMenuButton<int>(
    itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("First"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Second"),
          ),
        ],
  );

  void updateUser() async{
    // print(uid);
    GraphQLClient _client = clientToQuery();
  
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getUser),
        // variables:{
        //   "id":_uid,
        //   }
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
      List t = d["addressSet"]["edges"];
      for(int j=0;j<t.length;j++)
      {
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
  BlocProvider.of<LoginBloc>(context).add(
      OnLogout()
  );
  // final pref = await SharedPreferences.getInstance();
  // pref.getString("key")
  // pref.clear();
}


  // int uid;
  bool loading = true;
  bool isSubmit = false;
  int _uid;
  @override
  void initState()
  {
    super.initState();
    _loadUser();
    _uid = this.widget.uid;
    updateUser();
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid = (prefs.getInt('Id'));
      // user = (prefs.getString("LastUser"));
    });
  }
  File _image;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    _image!=null?Uploading():null;
  }

  Future<FormData> ImageForm() async{
    var formData = FormData();
    // formData.fields..add(MapEntry("image", this.widget.subProduct.id));

    formData.files.add(
      MapEntry("image", await  MultipartFile.fromFile(_image.path) )
    );
    return formData;
  }

    
    void Uploading() async{
    
    setState(() {
      isSubmit = true;
    });

    Dio dio = new Dio();
    dio.options.baseUrl = server_url;
    dio.interceptors.add(LogInterceptor());
    Response response;

    var formData = await ImageForm();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var byte1 = formData.readAsBytes();
    print("$server_url/api/profile/"+preferences.getString("profileId")+"/");
    response = await dio.put(

      "$server_url/api/profile/"+preferences.getString("profileId")+"/",

      // api/profile/1/
      data: await ImageForm(),
      onSendProgress: (send,total){
        print("$send from $total");
      }
    );


    
    String relative_url = response.data["image"].replaceAll(server_url+"/media/","");
    setState(() {
      this.user.profilePic = relative_url;
      // response.data["image"]
    });
    print(relative_url);
    preferences.setString("profilePic", relative_url);
    BlocProvider.of<AuthenticateBloc>(context).add(
      OnProfilePicUpdate(url: relative_url)
    );
    setState(() {
      isSubmit = false;
    });
    

  }


  Widget build(BuildContext context){
    // print(uid);
    // final prefs =  SharedPreferences.getInstance();

  

    _gotoInfo(user) async{
    Navigator.push(context, MaterialPageRoute(builder: (_)=>MyInfo(
        user:user
    )));

    // if(id!=null)
    // {
    //   setState(() {
    //     _uid = int.parse(id.toString());
    //   });
    // }

    }

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
      
      body: 
      
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

                GestureDetector(
                    onTap: (){
                      // _simplePopup();
                      isSubmit==false?
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return FullScreenImage(server_url+"/media/"+this.widget.user.profilePic);
                        })):{};
                    }
                    
                    ,
                    // child: CircleAvatar(
                    child:
                    
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: "imageHero",
                          child: this.widget.user.profilePic==null?Text("Upload"):
                          CircleAvatar(
                            child: isSubmit==true?
                            Center(child: CircularProgressIndicator(),):null,
                            
                            radius: 70,
                            backgroundImage: 
                            // _image != null?Image.file(_image,fit: BoxFit.fitHeight,):
                            
                            CachedNetworkImageProvider(server_url+"/media/"+this.widget.user.profilePic))
                        
                        ),
                        
                        Positioned(
                          left: 95,
                          top: 95,
                          child: GestureDetector(
                              onTap: (){
                                isSubmit==false?
                                  getImage():{};
                              },
                              child: Container(
                              padding:EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:Colors.green
                              ),
                              child: Icon(Icons.edit,color:Colors.white)
                              
                              ),
                          )
                          
                          )
                      ],
                    ),
                ),
                SizedBox(height: 10,),
                Text(this.widget.user.firstName+" "+ this.widget.user.lastName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                // Text(user.firstName)
              ],
            )
          ),
          Container(
            child: loading?Center(child: CircularProgressIndicator()):
            Column(children: <Widget>[
              // ListTile(trailing: Icon(Icons.info),)
              ListTile(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderList(
                )));  
                  
                  // OrderList();

                },
                leading: Icon(Icons.shopping_cart), 
                title: Text("My Orders",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                ),


              ListTile(
                leading: Icon(Icons.person),
                title: Text("My Info",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                onTap: (){
                  _gotoInfo(user);
                  
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyInfo(
                  //   user:user
                  //   // uid:uid
                  // )));



                },
                ),
              ListTile(leading: Icon(Icons.home),
              title: Text("My Address",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Addresses(
                  address:user.address
                  // id:user.id
                  // uid:uid
                )));                
              },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.redo),
                title: Text("Change Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (_)=>ChangePasswordScreen(
                  id:user.id
                  // uid:uid
                )));

                },
              ),
              
              ListTile(leading: Icon(Icons.power_settings_new,color: Colors.red,),title: Text('Logout',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
              onTap:(){
              // _clear();
              BlocProvider.of<AuthenticateBloc>(context).add(
                  LoggedOut()
              );
              Navigator.pop(context);
              }
              ),


            ],),
          )
        ],
      )

    );
  }
}

class FullScreenImage extends StatelessWidget{
  String img;
  FullScreenImage(this.img);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: ()=> Navigator.pop(context),
                    child: Hero(
                    tag:"imageHero",
                    child: CachedNetworkImage(
                      imageUrl: this.img,
                    ),
                  ),
                ),
                // FlatButton(
                //   onPressed: null, 
                //   child: Text("Update")
                //   )
                // Text("Upload Another")
              ],
            ),
            // FlatButton(
            //   onPressed: null, 
            //   child: Text("Update")
            //   )
            // Text("Upload Another")
          ],
        ),
      ),
    );
  }
}
