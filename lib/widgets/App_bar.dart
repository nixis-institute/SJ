import 'package:flutter/material.dart';
import 'package:shopping_junction/screens/cart/first_secreen.dart';


class CustomAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Positioned(
        top: 10,
        width: MediaQuery.of(context).size.width*0.99,
        child: AppBar(
          elevation: 0,
          title: Text("Home"),
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
                    child: Text("3"),
                  ),
                )
              ]
            ),



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