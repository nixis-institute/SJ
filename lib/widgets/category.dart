import 'package:flutter/material.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/screens/category_screen.dart';
import 'package:shopping_junction/models/slide_content.dart';
class Category extends StatefulWidget{
  @override
  _CategoryState createState() => _CategoryState();
}
class _CategoryState extends State<Category>{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),

      margin: EdgeInsets.only(left:10,right:10),
      height: 120,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10),
        shrinkWrap: true,
        itemCount: category_model.length,
        // scrollDirection: Axis.horizontal,
        scrollDirection: Axis.horizontal,
        
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
              
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>CategoryScreen(
                category:category_model[index],
                slider: category_model[index].slider,
              ))),


              child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(category_model[index].imageUrl),
                  ),
                  SizedBox(height: 6),
                  Text(category_model[index].name,style: 
                  TextStyle(color: Colors.blueGrey),
                  )
                ],
              ),
            ),
          );;
        },
      )

    // child: Row(children: <Widget>[Text("sdf")],),

    );
  }
}


