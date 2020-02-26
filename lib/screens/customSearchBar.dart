import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
// import 'package:shopping_junction/models/productAndCat.dart';

class Product {
  final String name;
  final String id;
  final double listprice;
  final double mrp;
  Product(this.id, this.name,this.listprice,this.mrp);
}

class CustomSearchBar extends StatefulWidget{
  @override
  _CustomSearchBar createState() => _CustomSearchBar();
}



class _CustomSearchBar extends State<CustomSearchBar>
{
  final _searchTerm = TextEditingController();

    _searching(text) async{
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(searchProductQuery),
        variables:{
          "match":text,
          }
      )
    );

    if(result.loading)
    {
      setState(() {
        isLoading = true;
      });
    }

    if(!result.hasException)
    {
      List<Product> l = [];
      var data = result.data["searchResult"];
      for(int i=0;i<data.length;i++)
      {
        l.add(
          Product(data[i]["id"],data[i]["name"],data[i]["listPrice"],data[i]["mrp"])
          );
      }

      setState(() {
        isLoading =false;
        if(l.length<1)
        isFound = true;
        plist = l;
      });

      // data = result.data["searchResult"];
    }      
    }




  @override
  var isLoading=false;
  var isFound = false;
  List<Product> plist=[];
  void initState()
  {
      super.initState();
      isLoading = false;
      plist = [];  
  }


  Widget build(BuildContext context)
  {




    return Scaffold(

        appBar: AppBar(
          title: TextFormField(
            controller: _searchTerm,
            decoration: InputDecoration(
              hintText: "search",
              border: InputBorder.none
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              // border:OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 5.0),)
              // border: InputBorder(borderSide:BorderSide(width: 1,color: Colors.green),)
              
            ),
            onChanged: (text){
              if(text.length>2)
              {
              _searching(text);
              }
              else if(text.length==0){
                setState(() {
                  isFound = false;
                  plist=[];
                });
              }
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: (){
                _searchTerm.clear();
              },
              ),
              
            SizedBox(width: 17,)
          ],
        ),


    body:isLoading?Center(child: CircularProgressIndicator(),): 
    isFound?Center(child: Text("not found"),)
    :ListView.builder(
      itemCount: plist.length>7?7:plist.length,
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.shopping_basket),
          title: Text(plist[index].name),
          subtitle: Text("price"+plist[index].mrp.toString()),
        );
        
      }
      
      
      )
      
      ,


    );
  }
}