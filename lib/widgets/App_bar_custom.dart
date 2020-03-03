import 'package:flutter/material.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/screens/cart/first_secreen.dart';


class CustomAppBar extends StatefulWidget{
  @override
  final String name;
  CustomAppBar({this.name});
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
{
  String _count="";
  @override
  void initState()
  {
    super.initState();
    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });
  }
  

  Widget build(BuildContext context)
  {
    return Positioned(
        top: 10,
        width: MediaQuery.of(context).size.width*0.99,
        child: AppBar(
          elevation: 0,
          title: Text(this.widget.name),
          backgroundColor: Colors.transparent,
          
          
          actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                iconSize: 30,
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
                    child: Text(_count,
                      style: TextStyle(color:Colors.white),
                    ),
                  ),
                )
              ]
            ),


              // IconButton(
              //   icon: Icon(Icons.add_shopping_cart),
              //   iconSize: 30,
              //   color: Colors.white,
              //   onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
              //     )));
              //   },                
              //   // onPressed: (){},
              // ),


              IconButton(
                icon: Icon(Icons.more_vert),
                iconSize: 30,
                color: Colors.white,
                onPressed: (){},
              )                            
          ],
        ),
      );
  }
}



