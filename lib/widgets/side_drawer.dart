import 'package:flutter/material.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/screens/accounts/login.dart';
import 'package:shopping_junction/screens/listpage_screen.dart';

class SideDrawer extends StatefulWidget{
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    return 
    Drawer(
      elevation: 1,
      child: 
      Container(
        color: Colors.green,
        child: ListView(        
          // shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 30,),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: category_model.length,
              itemBuilder: (BuildContext context,int index){
                // return ListTile(title: Text(category_model[index].name),);
                return Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10),
                  child: ExpansionTile(
                    title: Text(category_model[index].name.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                    trailing: Icon(Icons.add,color:Colors.white),
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: category_model[index].list.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int i){
                          return InkWell(
                                onTap: (){
                                Navigator.pop(context);
                                // Navigator.push(context, MaterialPageRoute(builder: (_)=>ListPage(
                                //   subCategory: category_model[index].list[i],
                                //   // product: category_model[index].list[i].products,
                                // ))); 
                                },
                                child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: ListTile(
                                title: Text(category_model[index].list[i].name.toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
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
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
              )),
            ListTile(
              title:Text("GIFT CARDS",
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
              ),              
            ),

            ListTile(
              title:Text("THEME STORE",
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
              ),
            ),

            ListTile(
              title:Text("CONTACT US",
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
              ),
            ),

            InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen(
                    // product: category_model[index].list[i].products,
                  )));
                },

                child: ListTile(
                title:Text("LOGIN",
                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
                ),
              ),
            ),

            ListTile(
              title:Text("MORE",
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
              ),
            ),
            
          ],
        )
        
        
        // Column(
        //   children: <Widget>[
        //     SizedBox(height: 50,),
        //     ExpansionTile(
        //       title: Text("MEN",
        //       style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w300),
        //       ),
        //       trailing: Icon(Icons.add,color:Colors.white),
        //       children: <Widget>[
        //         ListTile(
        //           title: Text("Topwear",style: TextStyle(color:Colors.white),),
        //         ),
        //         ListTile(
        //           title: Text("Pents",style: TextStyle(color:Colors.white),),
        //         ),
        //         ListTile(
        //           title: Text("Shoes",style: TextStyle(color:Colors.white),),
        //         ),                                
        //       ],
        //     ),
        //     ExpansionTile(
        //       title: Text("WOMEN",
        //       style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w300),
        //       ),
        //       trailing: Icon(Icons.add,color:Colors.white),
        //     )


        //   ],
        // ),
      ),
    );
  }
}