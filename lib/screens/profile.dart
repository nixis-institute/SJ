import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_junction/models/userModel.dart';
import 'package:shopping_junction/screens/accounts/infoForm.dart';
import 'package:shopping_junction/screens/cart/second_screen.dart';

import 'accounts/addressScreen.dart';
class MyInfo extends StatefulWidget{
  @override
  UserModel user;
  MyInfo({this.user});
  _MyInfoState  createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo>
{
  @override

  var usr;

  void initState()
  {
    super.initState();
    usr = this.widget.user;
  }

  Widget build(BuildContext context)
  {

    _updInfo(user)
    async{
    final info = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => UserEditFormScreen(user:usr)
    ));

    if(info!=null)
    {
      setState(() {
        usr = info;
      });

      }
    }

    return Scaffold(
      appBar:AppBar(title:Text("My Info")),
      body: ListView(
        children: <Widget>[


          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:15,right:15,top:5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Personal Details",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      InkWell(
                          onTap: (){

                            

                              _updInfo(usr);
                            
                            // Navigator.push(context, MaterialPageRoute(builder: (_)=>UserEditFormScreen(
                            //   user:usr
                            // )));



                          },
                          child: Icon(Icons.edit)
                        
                        )
                    ],
                  ),
                ),
                
              SizedBox(height:10,),
              Container(
                // padding: EdgeInsets.only(left:5,right:5),
                child: Column(
                  children: <Widget>[
                  ListTile(
                    leading:Icon(Icons.person) ,
                    title: Text(usr.firstName+ " "+ usr.lastName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                  ),

                  ListTile(
                    leading:Icon(Icons.call) ,
                    title: Text(usr.phone??"Add Phone",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                  ),

                  ListTile(
                    leading:Icon(Icons.email) ,
                    title: Text(usr.email??"Add Email",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                  ),
                ],
              ),
              
            )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:15,right:15,top:5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Address",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      
                      IconButton(
                        icon: Icon(Icons.edit), 
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Addresses(
                                  address:this.widget.user.address
                                )
                              ));                          
                        }
                        
                        )
                      // Icon(Icons.edit)


                    ],
                  ),
                ),
              SizedBox(height:10,),
              Container(
                child: Column(
                  children: <Widget>[
                  ListView.builder(
                    // physics: ScrollPhysics()
                    physics: ClampingScrollPhysics(),
                    itemCount: usr.address.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Icon(FontAwesomeIcons.university,size: 22,color: Colors.grey,),
                        SizedBox(width:30,),
                        Text(
                            usr.address[index].personName+"\n\n"+
                            usr.address[index].houseNo+"\n\n"+
                            usr.address[index].colony,
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                      ],),
                    );
                    }
                  ,
                  )
                ],
              ),
            )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:15,right:15,top:5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Bank Details",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      // Icon(Icons.edit)
                    ],
                  ),
                ),
                
              SizedBox(height:10,),
              Container(
                // padding: EdgeInsets.only(left:5,right:5),
                child: Column(
                  children: <Widget>[
                  ListTile(
                    leading:Icon(FontAwesomeIcons.university) ,
                    // title: Text(this.widget.user.firstName+ " "+ this.widget.user.lastName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                    title: Text("Add Bank Account"),
                    trailing: Icon(FontAwesomeIcons.angleRight),
                  ),
                ],
              ),
            )
              ],
            ),
          ),
        ],
      )
      
      );
  }
}