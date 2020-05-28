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

import 'customSearchBar.dart';

class ListPage extends StatefulWidget{
  @override
  final ProductSubCategory subCategory;
  ListPage({this.subCategory});
  _ListPageState createState() => _ListPageState();
}
 



class _ListPageState extends State<ListPage> with TickerProviderStateMixin
{
List<TypeAndProduct> product = List<TypeAndProduct>();

void fillMoreProduct() async{
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getMoreProductBySubListId),
        variables:{
          "sublistId":id,
          "after":endCursor,
          "sizes":size,
          "brand":brand
          }
      )
    );
    if(result.loading)
    {
      setState(() {
        loadMore = true;
      });
    }

    if(!result.hasException)
    {
      var data = result.data["sublistById"]["productSet"];
      setState(() {
        loadMore = false;
          endCursor = data["pageInfo"]["endCursor"];
          hasNextPage =  data["pageInfo"]["hasNextPage"];
      });

      // List<String> brands=[];
      // List<String> sizes =[];
      // List<String> colors;
      // List< 
      
      
      for(var i=0;i<data["edges"].length;i++)
        {

          List<Product> prdList = [];
          List im = data["edges"][i]["node"]["productimagesSet"]["edges"];
          List<ProductImage> imgList = [];


          for(var k = 0;k<im.length;k++){
            imgList.add(
              ProductImage(
                // im[k]["node"]["id"], im[k]["node"]["image"]
                  im[k]["node"]["id"],
                  im[k]["node"]["largeImage"], 
                  im[k]["node"]["normalImage"],
                  im[k]["node"]["thumbnailImage"]                
                )
            );
          }

          // filter_list.add(Filter_Model("Br",""));
          // brands.add(data["edges"][i]["node"]["brand"]);
          // sizes.add(data["edges"][i]["node"]["sizes"]);
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
        }
      // filter_list.add(Filter_Model("Brands",brands));
      // filter_list.add(Filter_Model("Sizes",sizes));
      tabController.addListener(() {
        setState(() {
          _currentIndex = tabController.index;
          endCursor = product[_currentIndex].endCursor;
          hasNextPage = product[_currentIndex].hasNextPage;
          id = product[_currentIndex].id;
        });
      });


    }    
}

void fillProductAndCateogry() async{
    print(id);
    List<TypeAndProduct> _product = List<TypeAndProduct>();
    // product.clear();
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(GetSubListAndProductBySubCateogryId),
        variables:{
          "SubCateogryId":id,
          "brand":brand,
          "sizes":size,
          "color":color,
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
      // filter_list.clear();

      setState(() {
        isLoading = false;
        endCursor = result.data["sublistBySubcategoryId"]["edges"][0]["node"]["productSet"]["pageInfo"]["endCursor"];
        hasNextPage = result.data["sublistBySubcategoryId"]["edges"][0]["node"]["productSet"]["pageInfo"]["hasNextPage"];
      });
      // product.clear();

      for(var i=0;i<result.data["sublistBySubcategoryId"]["edges"].length;i++)
        {
          List prd = result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["edges"];
          // print(prd);
          List<Product> prdList = [];
          for(var j = 0;j<prd.length;j++){
            List im = prd[j]["node"]["productimagesSet"]["edges"];
            List<ProductImage> imgList = [];
            for(var k = 0;k<im.length;k++){
              imgList.add(
                ProductImage(
                  im[k]["node"]["id"],
                  im[k]["node"]["largeImage"], 
                  im[k]["node"]["normalImage"],
                  im[k]["node"]["thumbnailImage"]
                  )
              );
            }

            if(prd[j]["node"]["subproductSet"]["edges"].length>0)
            {
              var subprd = prd[j]["node"]["subproductSet"]["edges"];
              prdList.add(
                Product(prd[j]["node"]["id"], 
                prd[j]["node"]["name"], 
                // prd[j]["node"]["listPrice"],
                subprd[0]["node"]["listPrice"],
                subprd[0]["node"]["mrp"],
                imgList,
                [],
                prd[j]["node"]["imageLink"].split(","),
                )
              );
            }

            
          }
      // filter_list.add(Filter_Model("Brands",brands));
      // filter_list.add(Filter_Model("Sizes",sizes));

          // print(prdList.length);
          // print(result.data["sublistBySubcategoryId"]["edges"][i]["node"]["name"]);
          setState(() {
              if(prdList.length >0)
              {
                _product.add(
                  TypeAndProduct(
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["id"],
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["name"],
                      prdList,
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["pageInfo"]["endCursor"],  
                      result.data["sublistBySubcategoryId"]["edges"][i]["node"]["productSet"]["pageInfo"]["hasNextPage"],
                  )
                );
              }
          });
        }

      // filter_list.add(Filter_Model("Brands",brands.toSet().toList()));
      // filter_list.add(Filter_Model("Sizes",sizes.toSet().toList()));        
        // print(brands.toSet().toList() );
        // print(sizes.toSet().toList());

    }
    // print(product[0]);
    
    // tabController
    // print(brand);

    
      // print("length........");
      // print(_product.length);
      product = _product;
      // print(product.length);
      tabController = TabController(vsync:this, length: product.length);

      // if(brand.length==0 && size.length==0){
      //   tabController = TabController(vsync:this, length: product.length);
      // }

      
    
    
    // tabController.

    setState(() {
      // print("index");
      // print(tabController.index);
      _currentIndex = tabController.index;
      endCursor = product[_currentIndex].endCursor;
      hasNextPage = product[_currentIndex].hasNextPage;
      id = product[_currentIndex].id;
    });
}


  TabController tabController;
  @override
  var nlist;
  var items = {};
  var id;
  var isLoading = true;
  var endCursor = "";
  var _count ="";
  int _currentIndex = 0;
  bool loadMore = false;
  bool hasNextPage = false;
  var brand="";
  var size="";
  var color="";

  void initState()
  {
    super.initState();
  
    id = this.widget.subCategory.id;
    fillProductAndCateogry();
    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });

  } 
  callback(isNewData){
    if(hasNextPage){
      setState(() {
        loadMore = true;
      });
      fillMoreProduct();
    }
  }

  Widget build(BuildContext context)
  {

    // getCartCount().then((c){
    //   setState(() {
    //   _count = c;
    //   });
    // });


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
                // IconButton(
                //   icon: Icon(Icons.search),
                //   iconSize: 25,
                //   color: Colors.white,
                //   onPressed: (){
                //   },
                // ),

                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomSearchBar(
                    )));
                    // FlappySearchBar()
                    // showSearch(context: context, delegate:DataSearch());
                  },
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
              setState(() {
                id = product[i].id;
                _currentIndex = i;                
              });
              },
              
              indicator: BoxDecoration(
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
            ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //       if(hasNextPage)
      //       {
      //         fillMoreProduct();
      //       }

      //   },
      //   tooltip: 'Add New Address',
      //   child:Icon(
      //     Icons.add,
      //     color: Colors.white,
      //     ),
      // ),


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
                      product[index].product,
                      callback,
                    );
                    }
                  )
                ),
               ),

              !loadMore?SizedBox():
               Container(
                height:50,
                
                // child: Text("Loading...",style:TextStyle(fontSize:20)),
                child:Center(
                  child: Container(
                    width: 20,
                    height:20,
                    child: CircularProgressIndicator(strokeWidth: 1,)),
                )

               )


             ],
           )
          ,
          // body: Center(child: CircularProgressIndicator()),
          
          // ProductGrid(
          //   product: widget.product,
          // ),
          

          bottomNavigationBar: BottomAppBar(
            child: GestureDetector(
                onTap: (){

                // Navigator.push(context,MaterialPageRoute(
                //     builder:(context)=>SortAndFilter()
                //    ));

                // _navigateAndDisplay(context);
                  // fillProductAndCateogry();

                  },
                child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.sort,
                    // color: Colors.white,
                    // size: 22,
                    // ),
                    // SizedBox(width: 10,),

                    Expanded(
                        child: InkWell(
                            onTap: (){
                               _navigateAndDisplay(context);
                            },
                            // _navigateAndDisplay(context)
                            child: Container(
                            // alignment: Alignment.center,
                            // color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.filter_list,color: Colors.white),
                                SizedBox(width: 5),
                                Text("Filter",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 17
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                    // Divider(height: 2,color: Colors.white,),
                    Expanded(
                        child: Container(
                          // alignment: Alignment.center,
                          // color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.sort,color: Colors.white),
                              SizedBox(width: 5),                              
                              Text("Sort",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 17
                              ),
                      ),
                            ],
                          ),
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
        builder: (context) => items.length>0?SortAndFilter(items: items,list:filter_list,id: this.widget.subCategory.id,):SortAndFilter(id: this.widget.subCategory.id)
      ));
        if(product!=null)
        {
          // print(product[""]);
          // print(product["isClearAll"]);

          // if(product["isClearAll"]==)
          if(product["isClearAll"]==true)
          {
            setState(() {
              brand="";
              size="";
              color="";
              items.clear();
              filter_list.clear();
              isLoading = true;
              id = this.widget.subCategory.id;
            });
            // print("clearAll...........");
              fillProductAndCateogry();
          }
          // else if(product["items"]!=null)
          else
          {
            print(product["filter"]["color"]);
            setState(() {
              items = product["items"];
              brand = product["filter"]["brands"]??"";
              size = product["filter"]["size"]??"";
              color = product["filter"]["color"]??"";
              filter_list = product["filter"]["filter_list"];
              isLoading = true;              

              id = this.widget.subCategory.id;
              // print(filter_list);
            });
              // print(size);
              // print(brand);

            fillProductAndCateogry();
            // setState(() {
              // brand = product["brands"];
              // size = product["sizes"];
            // });
            // print(product["filter"]);
          
          }
          // setState(() {
          //     nlist = product;        
          // });
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