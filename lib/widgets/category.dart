import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/screens/category_screen.dart';
import 'package:shopping_junction/models/slide_content.dart';
class Category extends StatefulWidget{
  @override
  _CategoryState createState() => _CategoryState();
}
class _CategoryState extends State<Category>{
  List<ProductCategory> listCategory = List<ProductCategory>();
  void fillList() async {
     GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(Categories)
      )
    );
    if(result.loading)
      print("sdfkj");
    if(!result.hasException)
    {
      print("__data__");
      for(var i=0;i<result.data["allCategory"]["edges"].length;i++)
        {
          print(result.data["allCategory"]["edges"][i]["id"]);
          setState(() {
            listCategory.add(
              ProductCategory(
                result.data["allCategory"]["edges"][i]["node"]["id"],
                result.data["allCategory"]["edges"][i]["node"]["name"],
                result.data["allCategory"]["edges"][i]["node"]["image"],
              ),
            );
          });
        }
    }
  }

  @override
  void initState()
  {
    super.initState();
    fillList();
  }


  Widget build(BuildContext context){
    // print("sdlfjlksdjf");
    // print(listCategory);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),

      margin: EdgeInsets.only(left:10,right:10),
      height: 120,


      child: ListView.builder(
          padding: EdgeInsets.only(left: 10),
          shrinkWrap: true,
          // itemCount: category_model.length,
          itemCount: listCategory.length,
          // scrollDirection: Axis.horizontal,
          scrollDirection: Axis.horizontal,
          
          itemBuilder: (BuildContext context, int index){

            dynamic prd = listCategory[index];
            return GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>CategoryScreen(
                  // category:category_model[index],
                  category: listCategory[index],
                  slider: category_model[index].slider,
                ))),


                child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(server_url+"/media/"+listCategory[index].imageUrl),
                      // backgroundImage: AssetImage(category_model[index].imageUrl),
                      // backgroundImage: NetworkImage("http://10.0.2.2:8000/media/"+prd["node"]["image"]),
                    ),

                    SizedBox(height: 6),
                    Text(
                      listCategory[index].name,
                      // prd["node"]["name"],
                      // category_model[index].name,
                    style: 
                    TextStyle(color: Colors.blueGrey),
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


