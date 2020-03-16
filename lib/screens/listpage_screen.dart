import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/filter_model.dart';
import 'package:shopping_junction/models/productAndCat.dart';
// import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/subcategory.dart';
import 'package:shopping_junction/models/subcategory_model.dart';
import 'package:shopping_junction/screens/cart/first_secreen.dart';
import 'package:shopping_junction/screens/sort_and_filter.dart';
import 'package:shopping_junction/widgets/product_grid.dart';
import 'package:shopping_junction/widgets/side_drawer.dart';

class ListPage extends StatefulWidget{
  @override
  // final List<Product> product;
  // final SubList list;
  final ProductSubCategory subCategory;
  ListPage({this.subCategory});
  // final FilterModel flter;
  _ListPageState createState() => _ListPageState();
}
 



class _ListPageState extends State<ListPage> with SingleTickerProviderStateMixin
{
List<TypeAndProduct> product = List<TypeAndProduct>();
// List<Product> 


void fillMoreProduct() async{
    GraphQLClient _client = clientToQuery();
    print(id);
    print(endCursor);

    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getMoreProductBySubListId),
        variables:{
          "sublistId":id,
          "after":endCursor
          }
      )
    );
    if(result.loading)
    {
      // print("loading..");
      setState(() {
        isLoading = true;
      });
    }

    if(!result.hasException)
    {
      var data = result.data["sublistById"]["productSet"];
      setState(() {
        isLoading = false;
          endCursor = data["pageInfo"]["endCursor"];
          hasNextPage =  data["pageInfo"]["hasNextPage"];
          // endCursor = result.data["sublistBySubcategoryId"]["pageInfo"]["endCursor"];
      });
      
      
      for(var i=0;i<data["edges"].length;i++)
        {
          // List prd = result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["edges"];
          // List prd = data["edges"][i]["node"]["productSet"]["edges"];


          List<Product> prdList = [];
          List im = data["edges"][i]["node"]["productimagesSet"]["edges"];
          List<ProductImage> imgList = [];


          for(var k = 0;k<im.length;k++){
            imgList.add(
              ProductImage(im[k]["node"]["id"], im[k]["node"]["image"])
            );
          }

          prdList.add(
            Product(data["edges"][i]["node"]["id"], 
            data["edges"][i]["node"]["name"], 
            data["edges"][i]["node"]["listPrice"],
            data["edges"][i]["node"]["mrp"],
            imgList,
            data["edges"][i]["node"]["sizes"].split(","),
            data["edges"][i]["node"]["imageLink"].split(","),
            )
          );

        product[_currentIndex].product.addAll(prdList);
          

          // setState(() {
          //     if(prdList.length >0)
          //     {
          //       product.add(
          //         TypeAndProduct(
          //             result.data["sublistBySubcategoryId"]["edges"][i]["node"]["id"],
          //             result.data["sublistBySubcategoryId"]["edges"][i]["node"]["name"],
          //             prdList,
          //             result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["pageInfo"]["endCursor"],
          //         )
          //       );
          //     }
          // });


        }
    }    
}

void fillProductAndCateogry() async{
    GraphQLClient _client = clientToQuery();
    // print("cursor");
    // print(endCursor);
    // print(id);
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(GetSubListAndProductBySubCateogryId),
        variables:{
          "SubCateogryId":id,
          }
      )
    );
    if(result.loading)
    {
      // print("loading..");
      setState(() {
        isLoading = true;
      });
    }

    if(!result.hasException)
    {

      setState(() {
        isLoading = false;
          endCursor = result.data["sublistBySubcategoryId"]["pageInfo"]["endCursor"];
          hasNextPage = result.data["sublistBySubcategoryId"]["pageInfo"]["hasNextPage"];
      });
      for(var i=0;i<result.data["sublistBySubcategoryId"]["edges"].length;i++)
        {
          List prd = result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["edges"];
          List<Product> prdList = [];


          for(var j = 0;j<prd.length;j++){
            
            // print(prd[j]["node"]["name"]);

            List im = prd[j]["node"]["productimagesSet"]["edges"];
            List<ProductImage> imgList = [];


            for(var k = 0;k<im.length;k++){
              imgList.add(
                ProductImage(im[k]["node"]["id"], im[k]["node"]["image"])
              );
            }

            prdList.add(
              Product(prd[j]["node"]["id"], 
              prd[j]["node"]["name"], 
              prd[j]["node"]["listPrice"],
              prd[j]["node"]["mrp"],
              imgList,
              prd[j]["node"]["sizes"].split(","),
              prd[j]["node"]["imageLink"].split(","),
              )
            );
          }

          setState(() {
              if(prdList.length >0)
              {
                product.add(
                  TypeAndProduct(
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["id"],
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["name"],
                      prdList,
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["pageInfo"]["endCursor"],                      
                  )
                );
              }
          });
        }
    }
    
    tabController = TabController(vsync:this, length: product.length)
     ..addListener(() {
        setState(() {
          _currentIndex = tabController.index;
        });
      });
}


  // ScrollController _scrollController = new ScrollController();
  TabController tabController;
  @override
  var nlist;
  var id;
  var isLoading = true;
  var endCursor = "";
  var _count ="";
  // DefaultTabController _tabController;
  // TabController _controller;
  int _currentIndex = 0;
  bool hasNextPage = false;
  void initState()
  {
    super.initState();

    id = widget.subCategory.id;
    fillProductAndCateogry();
    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });

    print(product.length);

    // tabController = TabController();


    // _controller = TabController(vsync: this, length: 2);
    // _controller.addListener(_handleTabSelection);    


    // nlist = widget.list;
  } 

    // _handleTabSelection() {
    //     setState(() {
    //       _currentIndex = _controller.index;
    //     });
    // }

  Widget build(BuildContext context)
  {

    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });

    // print(_controller);
    // if(product.length>0)
      // print(product[0].name);

  // print(endCursor);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.light,      
            statusBarBrightness:Brightness.dark  
      ),
          child: Scaffold(
          appBar: AppBar(
            title: Text(this.widget.subCategory.name),
            actions: <Widget>[



                // Builder(builder: (context){
                //   print(DefaultTabController.of(context).index);

                // }),

                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: (){
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  iconSize: 25,
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
            ],

            bottom:isLoading?null: 
            TabBar(
              
              
              isScrollable: true,
              controller: tabController,
              
              onTap: (i){
                // print("changed..");
              setState(() {
                id = product[i].id;
                _currentIndex = i;                
              });
              },
              
              

              // unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                
                // color: Colors.grey
              ),
              tabs: List.generate(product.length, (index)=>
                Tab(
                  child: Text(product[index].name),
                ),
               )
            ,
            // controller: tabController,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              indicatorColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              // unselectedLabelColor: ,
              
            
            ),
            
            ),
          

          // body: TabBarView(
          //   children: List.generate(product.length, (generator)=>
          //     ProductGrid(
          //       product: product[generator].product
          //     )
          //    )
          // ),


      floatingActionButton: FloatingActionButton(
        
        // onPressed: _incrementCounter,
        onPressed: (){
            fillMoreProduct();
            // _addNewAddress();


        },
        tooltip: 'Add New Address',
        child:Icon(
          Icons.add,
          color: Colors.white,
          ),
      ),


          body: isLoading
          ?Center(child: CircularProgressIndicator())
          :


           Column(
             children: <Widget>[
               Expanded(
                    child: TabBarView(
                  // controller:,
                  controller: tabController,
                  children: List.generate(product.length, (index){
                  // print(DefaultTabController.of(context).index); 
                  return  ProductGrid(
                      product: product[index].product

                    );
                    }
                  )
                ),
               ),

              //  Container(
              //   // height:50,
                
              //   // child: Text("loading..."),

              //  )


             ],
           )
          ,
          // body: Center(child: CircularProgressIndicator()),
          
          // ProductGrid(
          //   product: widget.product,
          // ),
          

          bottomNavigationBar: BottomAppBar(
            child: InkWell(
                onTap: (){

                // Navigator.push(context,MaterialPageRoute(
                //     builder:(context)=>SortAndFilter()
                //    ));
                // _navigateAndDisplay(context);
                  fillProductAndCateogry();

                  },
                child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.sort,
                    color: Colors.white,
                    size: 22,
                    ),
                    SizedBox(width: 10,),
                    Text("Sort & Filter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                    )
                  ],
                ),
              ),
            ),
            color: Colors.green,
            
          ),
        ),



    );
  }


  _navigateAndDisplay(BuildContext context) async
  {
      final product = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => SortAndFilter()
      ));
        if(product!=null)
        {
          setState(() {
              nlist = product;        
          });
        }

        // else if(product == false)
        // {
            
        // }

        // nlist = product;

  }


  _setting(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
       return Container(
        // color: Colors.transparent,
        decoration: BoxDecoration(
          
          color: Colors.white
        ),

        height: MediaQuery.of(context).size.height*2,
        child: Text("Works"),
       );
      }
    );
  }
}