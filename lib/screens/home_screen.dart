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

import 'accounts/login.dart';
import 'cart/first_secreen.dart';
import 'searchResult.dart';

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
        appBar: AppBar(
            title: Text("Shopping Junction",style: TextStyle(color: Colors.white),),
                actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: (){
                    showSearch(context: context, delegate:DataSearch());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: (){},
                ),

                Stack(
                    children:<Widget>[
                      IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      iconSize: 30,
                      color: Colors.white,
                      
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
                        )));
                      },
                  ),
                  Positioned(
                    top: 1,
                    left: 20,
                    child: Container(
                      height: 20,
                      width: 20,
                      // color: Colors.red,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("3"),
                    ),
                  )
                ]
              ),
            ],
            ),
        drawer: SideDrawer(),
        body: ListView(
          children: <Widget>[          

            Container(
              width:MediaQuery.of(context).size.width,
              child: Stack(
                overflow: Overflow.visible,
                children:<Widget>[
                  TopSlider(),
                  // CustomAppBar(),
                  Positioned(
                    top: 240,
                    width: MediaQuery.of(context).size.width*1,
                    child: Category()
                  )

                ], 
                
                ),
            ),

            SizedBox(height: 80),

            Container(
              // height: 500,
              // color: Colors.pink,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black)
              ),

              child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        // padding: EdgeInsets.all(0),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Top Selling",style: TextStyle(fontSize: 19,color: Colors.grey[800]),),
                          Text("View All",style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor),)
                        ],
                      ),
                    ),


                  
                  Container(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 2/3,
                      children: List.generate(top_sellings.length, (index){

                        // return Container(
                        //   margin: EdgeInsets.all(1),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)
                        //   ),
                        //   child: Center(
                        //     child: Text(top_sellings[index].name),
                        //   ),
                        //   // child: Column(
                        //   //     children: <Widget>[
                        //   //       Image.asset(top_sellings[index].imageUrl),
                        //   //       Text(top_sellings[index].name)
                        //   //     ],
                        //   // ),
                        // );
                        return Container(
                          child: Card(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 240,
                                    child: Image.asset(top_sellings[index].imageUrl,fit:BoxFit.cover),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 3,),
                                        Text(top_sellings[index].name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        // Text(top_sellings[index].name),
                                        SizedBox(height: 2,),
                                        
                                        Text(top_sellings[index].count.toString()+" items"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                          ),
                        );
                        // return Container(
                        //   height: 600,
                        //   child: Card(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //     ),
                        //     semanticContainer: true,
                        //     clipBehavior: Clip.antiAliasWithSaveLayer,
                            
                        //     elevation: 1,
                        //     child: Column(
                            
                        //     mainAxisSize: MainAxisSize.min,
                        //     crossAxisAlignment: CrossAxisAlignment.start,                          
                        //       children: <Widget>[
                        //         Container(
                        //           child: 
                        //             Image.asset(products[index].imageUrl,fit:BoxFit.cover,),                                  
                        //             height: 250,
                        //             width: MediaQuery.of(context).size.width/2.2,
                        //           // decoration: BoxDecoration(
                        //           //   image: DecorationImage(
                        //           //     image:AssetImage(products[index].imageUrl),
                        //           //     fit: BoxFit.cover
                        //           //   )
                        //           // ),
                        //         ),

                        //         SizedBox(height:8,),
                        //         Padding(
                        //           padding: EdgeInsets.only(left: 8),
                        //           child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               mainAxisSize: MainAxisSize.min,                                
                        //               children: <Widget>[
                        //                 Center(child: Text(products[index].name),),
                        //                   SizedBox(
                        //                     height: 2.0,
                        //                   ),
                        //                 // Center(child: Text('$products[index].price'),)
                        //               ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     // color: Colors.greenAccent,
                        //     // child:Container(
                        //     //   // height: 40,
                        //     //   decoration: BoxDecoration(
                        //     //     image: DecorationImage(
                        //     //       image: AssetImage(products[index].imageUrl),
                        //     //       fit: BoxFit.cover
                        //     //     )
                        //     //   ),
                        //     // ),

                          
                        //   ),
                        // );


                      }),
                    ),
                  )      

                ],
              ),
            ),


                              
          ],
        )
      ),
    );
  }
}





class DataSearch extends SearchDelegate<String>{
  final cities=[
    'delhi',
    "mumbai",
    "kolkata",
  ];

  final rec=[
    'delhi',
    // "mumbai",
    "kolkata",
  ];


  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query="";
        },
        )
      ];

  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,),
        onPressed: (){
          close(context,null);
        } 
        );
  }

  @override
  Widget buildResults(BuildContext context){
    return Text(query);

  //   Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen(
  // )));  // return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context){
    final suggestion = query.isEmpty
    ?rec:
    cities.where((p)=>p.startsWith(query)).toList();
    
    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder:(context,index){
        return Container(
          child: ListTile(
          onTap: (){
            query = suggestion[index];
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchResultScreen(
                  )));
          },
          // leading: Icon,
          title: RichText(
            text: TextSpan(
              text: suggestion[index].substring(0,query.length),
              style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
              children: [TextSpan(
                text: suggestion[index].substring(query.length),
                style: TextStyle(color:Colors.grey)
              )]
            ),
          ),
          // title: Text(suggestion[index]),
          ),
        );
      }


      // ListTile(
      //   // leading: Icon,
      //   title: RichText(
      //     text: TextSpan(
      //       text: suggestion[index].substring(0,query.length),
      //       style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
      //       children: [TextSpan(
      //         text: suggestion[index].substring(query.length),
      //         style: TextStyle(color:Colors.grey)
      //       )]
      //     ),
      //   ),
      //   // title: Text(suggestion[index]),
      //   ) 
      );
  }

  // @override
  // Widget buildResults(BuildContext context) {
  //   // TODO: implement buildResults
  //   return null;
  // }

}