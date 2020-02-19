import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/top_sellings.dart';
import 'package:shopping_junction/widgets/App_bar.dart';
import 'package:shopping_junction/widgets/category.dart';
import 'package:shopping_junction/widgets/side_drawer.dart';
import 'package:shopping_junction/widgets/slider.dart';

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
        drawer: SideDrawer(),
        body: ListView(
          children: <Widget>[          
            Container(
              width:MediaQuery.of(context).size.width,
              child: Stack(
                overflow: Overflow.visible,
                children:<Widget>[
                  TopSlider(),
                  CustomAppBar(),
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