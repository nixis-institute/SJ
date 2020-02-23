import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/top_sellings.dart';
// import 'package:shopping_junction/screens/flappy_search_bar.dart';
import 'package:shopping_junction/widgets/App_bar_custom.dart';
// import 'package:shopping_junction/widgets/App_bar.dart';

import 'package:shopping_junction/widgets/category.dart';
import 'package:shopping_junction/widgets/side_drawer.dart';
import 'package:shopping_junction/widgets/slider.dart';

import 'cart/first_secreen.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build (BuildContext context){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.light,      
            statusBarBrightness:Brightness.dark  
      ),
      
      child: Scaffold(
        // appBar: AppBar(
        //     title: Text("Shopping Junction"),
        //         actions: <Widget>[
        //         IconButton(
        //           icon: Icon(Icons.search),
        //           iconSize: 25,
        //           color: Colors.white,
        //           onPressed: (){
        //           },
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.notifications),
        //           iconSize: 25,
        //           color: Colors.white,
        //           onPressed: (){},
        //         ),

        //         Stack(
        //             children:<Widget>[
        //               IconButton(
        //               icon: Icon(Icons.add_shopping_cart),
        //               iconSize: 30,
        //               color: Colors.white,
                      
        //               onPressed: (){
        //                 Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
        //                 )));
        //               },
        //           ),
        //           Positioned(
        //             top: 1,
        //             left: 20,
        //             child: Container(
        //               height: 20,
        //               width: 20,
        //               // color: Colors.red,
        //               alignment: Alignment.center,
        //               decoration: BoxDecoration(
        //                 color: Colors.red,
        //                 borderRadius: BorderRadius.circular(10)
        //               ),
        //               child: Text("3"),
        //             ),
        //           )
        //         ]
        //       ),
        //     ],
        //     // bottom: SearchBar(onSearch: null, onItemFound: null),


        //     // bottom: PreferredSize(
        //     //   child: Container(
        //     //     decoration: BoxDecoration(
        //     //       color: Colors.blue
        //     //     ),
        //     //   ),
        //     //   preferredSize: Size(50, 50)
        //     //   ):
        //     //   PreferredSize(child: Text(""), preferredSize: Size(1,0)),



        //     ),
        drawer: SideDrawer(),
        
        
        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text("Shopping Junction"),
              // flexibleSpace: 
              floating: true,
              bottom: PreferredSize(child: Icon(Icons.linear_scale,size: 60.0,), preferredSize: Size.fromHeight(50.0)),
              
          
              ),
              SliverList(delegate: SliverChildListDelegate([
                


                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),
                                    ListTile(title: Text("sdf"),),ListTile(title: Text("sdf"),),
                  ListTile(title: Text("sdf"),),



              ]))

            ],
            
        

        )
      ),
    );
  }
}