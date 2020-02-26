import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';

class Post {
  final String title;
  final String description;
  Post(this.title, this.description);
}

class PRD {
  final String name;
  final String id;
  // final double mrp;
  // final double listprice;
  PRD(this.id,this.name);
}




class FlappySearchBar extends StatefulWidget{
  @override
  _FlappySearchBar createState() => _FlappySearchBar();
}

class _FlappySearchBar extends State<FlappySearchBar>
{


  fillMoreProduct() async
  {
    var data;    
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(searchProductQuery),
        variables:{
          "match":"shirt",
          }
      )
    );

    if(!result.hasException)
    {

      data = result.data["searchResult"];

      // print(data[0]["name"]);
    }
    else data=[];
    
    return data;
  }

  


  Future<List<PRD>> search(String search) async{

    print("sdlkjflksdjflkds");
    // await Future.delayed(Duration(seconds: 2));
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(searchProductQuery),
        variables:{
          "match":"shirt",
          }
      )
    );
    
    

    List<PRD> prd;
    print("before..");

    // if(result.loading){
    //   print("loading....");
    // }
    
    if(result.hasException){
      print("exception");
      print(result.exception.toString());
    }


    if(!result.hasException)
    {
      // print();
      print("no exception");
      var data = result.data["searchResult"];
      // print(data[0]["name"]);
      print(data.length);
      for(int i=0;i<data.length;i++)
      {
        print("$i");
        prd.add(PRD(
          data[i]["id"],
          data[i]["name"],
          // data[i]["listPrice"],
          // data[i]["mrp"],
        ));
      }
    }
    // print("sdfsdfdsf");
    print(prd[0]);
    return List.generate(prd.length, (int index) {
      return PRD(
          prd[index].id,
          prd[index].name,
          // prd[index].listprice,
          // prd[index].mrp,        
        // "Title : $search $index",
        // "Description :$search $index",
      );
    });

    // return prd;
    // return List.generate(search.length, (int index) {
    //   return Post(
    //     "Title : $search $index",
    //     "Description :$search $index",
    //   );
    // });
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar<PRD>(
              onSearch: search,
              // onError: ,
              // loader: Text("....."),
              onItemFound: (PRD post,int index)
              {
                return ListTile(
                  title: Text(post.name),
                  subtitle: Text(post.id),
                );
              },
              hintText: "Search product",
              ),

            )
        ),
    );
  }
}