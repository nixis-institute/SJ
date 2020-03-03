import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/screens/category_screen.dart';
import 'package:shopping_junction/models/slide_content.dart';
class Category extends StatefulWidget{
  List<ProductCategory> productCategory;
  Category({this.productCategory});
  @override

  _CategoryState createState() => _CategoryState();
}
class _CategoryState extends State<Category>{
  List<ProductCategory> listCategory = List<ProductCategory>();

  @override
  var isLoading = false;
  var isError = false;
  var Error = "";
  void initState()
  {
    super.initState();
    // fillList();
  }


  Widget build(BuildContext context){
    // print("sdlfjlksdjf");
    // print(listCategory);
    return Container(
      
      decoration: BoxDecoration(
        // boxShadow: Shadow(),  
        color: Colors.white,
        // border: Border.all(color: Colors.grey[200]),
        // borderRadius: BorderRadius.all(Radius.circular(5)),
      ),

      // margin: EdgeInsets.only(left:10,right:10),
      height: 120,


      child: 
      isLoading
      ?Center(child: CircularProgressIndicator())
      :
      ListView.builder(
          padding: EdgeInsets.only(left: 10),
          shrinkWrap: true,
          // itemCount: category_model.length,
          itemCount: this.widget.productCategory.length,
          // scrollDirection: Axis.horizontal,
          scrollDirection: Axis.horizontal,
          
          itemBuilder: (BuildContext context, int index){

            dynamic prd = this.widget.productCategory[index];
            return GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>CategoryScreen(
                  // category:category_model[index],
                  category: this.widget.productCategory[index],
                  slider: category_model[index].slider,
                ))),


                child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(server_url+"/media/"+this.widget.productCategory[index].imageUrl),
                      // backgroundImage: AssetImage(category_model[index].imageUrl),
                      // backgroundImage: NetworkImage("http://10.0.2.2:8000/media/"+prd["node"]["image"]),
                    ),

                    SizedBox(height: 6),
                    Text(
                      this.widget.productCategory[index].name,
                      // prd["node"]["name"],
                      // category_model[index].name,
                    style: 
                    TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          },          
      )
    ); 
    // child: Row(children: <Widget>[Text("sdf")],),
  }
}


