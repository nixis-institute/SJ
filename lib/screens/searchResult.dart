import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/widgets/product_grid.dart';

import 'customSearchBar.dart';

class SearchResultScreen extends StatefulWidget{
  @override
  final String id;
  final String slug;
  SearchResultScreen({this.id,this.slug});
  _SearchResultScreenState createState() =>_SearchResultScreenState();
}
class _SearchResultScreenState extends State<SearchResultScreen>
{


  getProducts() async{
    print("called");
    GraphQLClient _client = clientToQuery();
    // print(endCursor);
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(GetProductBySubListId),
        variables:{
          "SubListId":id,
          // "after":endCursor
          }
      )
    );

    if(result.loading)
    {
      // print("load..in");
      setState(() {
        isLoading=true;
      });
    }


    if(!result.hasException)
    {
      // print("result.");
      List<Product> l=[];
      var data = result.data["productBySublistId"]["edges"];
      // print(data);
      for(int i=0;i<data.length;i++)
      {
        List<ProductImage> im =[];
        
        var img = data[i]["node"]["productimagesSet"]["edges"];
        
        for(var k = 0;k<img.length;k++){
          im.add(
            ProductImage(img[k]["node"]["id"], img[k]["node"]["image"])
          );
        }

        l.add(
          Product(data[i]["node"]["id"], 
          data[i]["node"]["name"], 
          data[i]["node"]["listPrice"],
          data[i]["node"]["mrp"],
          im,
          data[i]["node"]["sizes"].split(","),
          data[i]["node"]["imageLink"].split(","),
          ) 
        );
      }

      setState(() {
        product = l;
        isLoading = false;
      });
    
    }






  }

  @override
  String id;
  bool isLoading=true;
  List<Product> product;
  void initState()
  {
    super.initState();
    id = this.widget.id;
    getProducts();
    // fillProductAndCateogry();
    // nlist = widget.list;
  }  
  
  
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(this.widget.slug,style: TextStyle(color:Colors.white),),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          iconSize: 25,
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomSearchBar(
            // )))

            // FlappySearchBar()
            // showSearch(context: context, delegate:DataSearch());
          },
        ),          
        ],
      ),
      body:isLoading?Center(child: CircularProgressIndicator(),):
      ProductGrid(
        product: product,
      )
      // GridView.count(
      //   shrinkWrap: true,
      //   crossAxisCount: 2,
      //   physics: ClampingScrollPhysics(),
      //   scrollDirection: Axis.vertical,
      //   childAspectRatio: 2/3,
      //   children: List.generate(product.length, (index){
      //     ProductGrid(
      //       product: product[index],
      //     );
      //   }),
      // ),


      // ListView.builder(
      //   itemCount: product.length,
      //   itemBuilder: (context,index){
      //     return ListTile(title: Text(product[index].name),);
      //   }
        
      //   )





    );
  }
}