import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/bloc/login_bloc/login_bloc.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/models/userModel.dart';
import 'package:shopping_junction/screens/accounts/account.dart';
import 'package:shopping_junction/screens/accounts/login.dart';
// import 'package:shopping_junction/screens/accounts/profile.dart';
import 'package:shopping_junction/screens/listpage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatefulWidget{
  List<ProductCategory> productCategory;
  SimpleUserModel user;
  SideDrawer({this.productCategory,this.user});
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class SharedPreferencesHelper{
  // static final String key = "";
  static Future<String> getToken() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString("LastToken");
  }
  static Future<String> getName() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString("LastUser");
  }  
}

class _SideDrawerState extends State<SideDrawer>
{
  // final username = SharedPreferencesHelper.getName();
  String user ='Login';
  int uid;
  List<ProductCategory> listCategory = List<ProductCategory>();


  @override
  var isLoading = false;
  var isError = false;
  var Error = "";
  void initState(){
    super.initState();
    _loadUser(); 
    
    // BlocProvider.of<AuthenticateBloc>(context).add(
    //   AppStarted()
    // );

  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getInt('Id'));
      user = (prefs.getString("LastUser"));
    });
  }

  Widget build(BuildContext context)
  {
    return 
    Container(
      child: Drawer(
        elevation: 1,
        child: 
        ListView(        
          shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          children: <Widget>[
            // this.widget.user==null?
            // ListTile(
            //   onTap: (){
            //     Navigator.pop(context);
            //     Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
            //   },
            //   trailing: Icon(Icons.account_circle,),
            //   title: Text("LOGIN",style: TextStyle(fontSize: 18),),
            // )
            // :
            
            InkWell(
                onTap: (){
                  this.widget.user==null?{
                    Navigator.pop(context),
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()))
                  }:
                  {
                  Navigator.pop(context),
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen(uid: uid,user:this.widget.user)))
                  };
                },
                child: 
                Container(
                  color: Colors.teal,
                  padding: EdgeInsets.all(10),
                  child: Row(children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(left:10),
                      width: 50,
                      height:50,
                      child: Hero(
                        tag: "imageHero",
                        child: 
                        this.widget.user==null||this.widget.user.profilePic==null?Icon(Icons.account_circle,size: 40,color: Colors.white,):
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: CachedNetworkImageProvider(
                            this.widget.user.profilePic.startsWith("https://") ||this.widget.user.profilePic.startsWith("http://") ?this.widget.user.profilePic:
                            server_url+"/media/"+this.widget.user.profilePic
                          ))
                        ),

                    ),
                    SizedBox(width:10),
                    Expanded(
                      child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            this.widget.user==null?Text("Welcome",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),)
                            :Text(this.widget.user.firstName+" "+ this.widget.user.lastName,style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),),
                            this.widget.user==null?Text("Login",style: TextStyle(color:Colors.white),)
                            :Text(this.widget.user.username,style: TextStyle(color:Colors.white),)
                          ],
                        )
                      ),
                      Container(
                        child: Icon(Icons.chevron_right,size: 30,color:Colors.white,),
                      )
                    ],
                  ),
                )
                
                
                
                // UserAccountsDrawerHeader(
                //   accountName: 
                //   Text(this.widget.user.firstName+" "+ this.widget.user.lastName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),), 
                //   accountEmail: null,
                //   currentAccountPicture: 
                //     Hero(
                //       tag: "imageHero",
                //       child: 
                //       CircleAvatar(
                //         radius: 70,
                //         backgroundImage: CachedNetworkImageProvider(server_url+"/media/"+
                //         this.widget.user.profilePic
                        
                //         ))
                //     ),
                // ),



            ),

            // Text(this.widget.user.profilePic),
            // SizedBox(height: 30,),
            isLoading
            ?
            
            Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator()),
            ):
            
            
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              // itemCount:  listCategory.length,
              itemCount: this.widget.productCategory.length,
              itemBuilder: (BuildContext context,int index){
                // return ListTile(title: Text(category_model[index].name),);
                return Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10),
                  child: ExpansionTile(
                    title: Text(this.widget.productCategory[index].name.toUpperCase(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                    trailing: 
                    Icon(Icons.keyboard_arrow_down),


                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: this.widget.productCategory[index].subCat.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int i){
                          return InkWell(
                                onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>ListPage(
                                  subCategory:this.widget.productCategory[index].subCat[i]
                                  // product: category_model[index].list[i].products,
                                ))); 
                                },
                                child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: ListTile(
                                title: Text(this.widget.productCategory[index].subCat[i].name.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w400),),
                                ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              
              },
            ),
            Divider(height: 1,color: Colors.white,),

            ListTile(
              title:Text("SHOPPING TRENDS",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
              )),
            ListTile(
              title:Text("GIFT CARDS",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
              ),              
            ),

            ListTile(
              title:Text("THEME STORE",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
              ),
            ),

            ListTile(
              title:Text("CONTACT US",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
              ),
            ),

            // ListTile(
            //   onTap: (){
            //     Navigator.pop(context);
            //       this.widget.user==null?Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen(
            //         ))):

            //       Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen(
            //         uid:uid
            //       )));
            //   },
            //   title: Text(this.widget.user==null?"Login":this.widget.user,
            //   style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
            //   ),
              
            // ),
            ListTile(
              title:Text("MORE",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}