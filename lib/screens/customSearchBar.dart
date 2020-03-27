import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/screens/searchResult.dart';

import 'detail_screen.dart';

// class Product {
//   final String name;
//   final String id;
//   final double listprice;
//   final double mrp;
//   Product(this.id, this.name,this.listprice,this.mrp);
// }

class CategoryName{
  final String name;
  final String id;
  CategoryName(this.id,this.name);
}

class CustomSearchBar extends StatefulWidget{
  @override
  _CustomSearchBar createState() => _CustomSearchBar();
}



class _CustomSearchBar extends State<CustomSearchBar>
{
  final _searchTerm = TextEditingController();

    _searching(text) async{

      setState(() {
        isLoading = true;
      });
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
        isFound = false;
        isLoading = true;
      });
    }
    QueryResult resultcat = await _client.query(
      QueryOptions(
        documentNode: gql(searchCategoryQuery),
        variables:{
          "match":text,
          }
      )
    );

    if(resultcat.loading)
    {
      setState(() {
        isLoading = true;
      });
    }

    if(!resultcat.hasException)
    {
      var data = resultcat.data["searchCategory"];
      List<CategoryName> catData=[];
      for(int i=0;i<data.length;i++)
      {
        catData.add(
          CategoryName(data[i]["id"], data[i]["name"]+" in "+data[i]["subCategory"]["mainCategory"]["name"])
        );

        // data[i]["name"]+" in "+data[i]["subCategory"]["mainCategory"]
        // data[i]["id"]
      }

      // setState(() {
      //   clist = catData;
      // });


    setState(() {
        isLoading =false;
        if(catData.length<1)
        isFound = false;
        clist = catData;
        
      });
      
    }




    if(!result.hasException)
    {
      List<Product> l = [];
      List<ProductImage> imgList = [];
      var data = result.data["searchResult"];
      for(int i=0;i<data.length;i++)
      {
          if(data[i]["parent"]==null)
          {
            l.add(
                  Product(
                  data[i]["id"], 
                  data[i]["name"], 
                  data[i]["listPrice"],
                  data[i]["mrp"],
                  imgList,
                  data[i]["sizes"].split(","),
                  data[i]["imageLink"].split(","),
                  )
              );
          }

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
  List<CategoryName> clist=[];
  void initState()
  {
      super.initState();
      // isLoading = false;
      isLoading= false;
      plist = [];  
  }


  Widget build(BuildContext context)
  {




    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: _searchTerm,
            decoration: InputDecoration(
              hintText: "Search",
              // helperStyle: TextStyle(color:Colors.white,fontWeight: FontWeight.w700 ),
              hintStyle: TextStyle(color:Colors.white,fontWeight: FontWeight.w400 ),
              border: InputBorder.none


              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              // border:OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 5.0),)
              // border: InputBorder(borderSide:BorderSide(width: 1,color: Colors.green),)

            ),
            style:  TextStyle(color:Colors.white,fontWeight: FontWeight.w700 ),
            onChanged: (text){
              if(text.length>2)
              {
                setState(() {
                  isFound = false;
                });
                // print(text);
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
    :ListView(
      children: <Widget>[
      Container(
          child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          height: 2,
          ),
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: clist.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(clist[index].name),
              subtitle: Text("Category"),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchResultScreen(
                  id:clist[index].id,
                  slug:clist[index].name

                )));
              },
              );
          }
          )        
      ),


      Container(
        child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
        color: Colors.black,
        height: 2,
        ),
        
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: plist.length>7?7:plist.length,
        itemBuilder: (context,index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.only(bottom:5),
            child: ListTile(
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailPage(
                  product:plist[index],
                )));
              },
              isThreeLine: false,
              trailing: Text("\$ "+plist[index].listPrice.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold )),
              leading: Icon(Icons.shopping_basket),

              title: Text(plist[index].name),
            ),
          );        
        }
        ),
      )

      ],
    )
    
    
    

      
      ,


    );
  }
}