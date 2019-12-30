import 'package:flutter/material.dart';


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
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                iconSize: 30,
                color: Colors.white,
                onPressed: (){},
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