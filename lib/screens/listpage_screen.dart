import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/bloc/products_bloc/products_bloc.dart';
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
  var ordering = "-id";

  void initState()
  {
    super.initState();
  
    id = this.widget.subCategory.id;
    // fillProductAndCateogry();
    BlocProvider.of<ProductsBloc>(context).add(
      FetchProductAndType(
        id: id,
        brand: brand,
        size: size,
        color: color,
        ordering: ordering
      )
    );

    // tabController = TabController(vsync:this, length: 3);

    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });

  } 
  callback(isNewData){
    // print("....");
    // print(hasNextPage);
  // print("....");
    if(hasNextPage){
      // print("hasnextPAge");
      setState(() {
        loadMore = true;
      });
      // fillMoreProduct();
      BlocProvider.of<ProductsBloc>(context).add(
        FetchMoreProductAndType(
          id: id,
          after: endCursor,
          brand: brand,
          size: size,
          color: color,
          ordering: ordering
        )
      );
      // print(id);
      // print(endCursor);
    }
    // print("Not has next page");
  }

  Widget build(BuildContext context)
  {
    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.light,      
            statusBarBrightness:Brightness.dark  
      ),
          child: BlocListener<ProductsBloc,ProductsState>(
            listener: (context, state) {
              if(state is LoadProductAndType){
                // print("call tabcontroller.. ");
                tabController = TabController(vsync:this, length: state.product.length);
                product = state.product;
                // print(product.length);
                // _currentIndex = tabController.index;
                tabController.animateTo(_currentIndex);
                setState(() {
                  _currentIndex = tabController.index;
                  endCursor = product[_currentIndex].endCursor;
                  hasNextPage = product[_currentIndex].hasNextPage;
                  id = product[_currentIndex].id;
                  loadMore = false;
              });

              }
            },
            child: BlocBuilder<ProductsBloc,ProductsState>(
              builder: (context, state) {
                if(state is Loading)
                {
                  return Scaffold(body: Center(child: CircularProgressIndicator(),),);
                }
                if(state is LoadProductAndType){
                  product = state.product;
                  if(tabController!=null){
                    return Scaffold(
                    appBar: AppBar(
                      title: Text(this.widget.subCategory.name),
                      actions: <Widget>[
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

                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Stack(
                                children:<Widget>[
                                  IconButton(
                                  icon: Icon(Icons.add_shopping_cart),
                                  // iconSize: 30,
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
                          ),
                      ],

                      bottom:
                      // isLoading?null: 
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


                    body: 
                    // isLoading
                    // ?Center(child: CircularProgressIndicator())
                    // :


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
                                customkey: product[index].id,
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
                              Container(height: 30, child: VerticalDivider(color: Colors.white,width: 1,thickness: 1, )),
                              // Divider(height: 2,color: Colors.white,),
                              Expanded(
                                  child: InkWell(
                                      onTap: (){
                                        _showSheet(context);
                                      },
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
                                  ),
                              )                    
                            ],
                          ),
                        ),
                      ),
                      color: Colors.green,
                      
                    ),
                  );
                
                  }else{
                    return Scaffold(body: Center(child:CircularProgressIndicator()),);
                  }
                }
                else{
                  return Scaffold(body: Center(child:Text("Error")),);
                }

              },
            ),
          )

    );
  }


  _navigateAndDisplay(BuildContext context) async
  {
      final product = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => items.length>0?SortAndFilter(items: items,list:filter_list,id: this.widget.subCategory.id,):SortAndFilter(id: this.widget.subCategory.id)
      ));
        if(product!=null)
        {
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

              // print("more");
              BlocProvider.of<ProductsBloc>(context).add(
              FetchProductAndType(
                id: id,
                brand: brand,
                size: size,
                color: color,
                ordering: ordering
              )
            );
          }
          else
          {
            // print(product["filter"]["color"]);
            setState(() {
              items = product["items"];
              brand = product["filter"]["brands"]??"";
              size = product["filter"]["size"]??"";
              color = product["filter"]["color"]??"";
              filter_list = product["filter"]["filter_list"];
              isLoading = true;              
              id = this.widget.subCategory.id;
            });

            BlocProvider.of<ProductsBloc>(context).add(
              FetchProductAndType(
                id: id,
                brand: brand,
                size: size,
                color: color,
                ordering: ordering
              )
            );
          
          }
        }
  }

calltobloc(){

// print(id);
// print(brand);
// print(size);
// print(color);
// print(ordering);


  BlocProvider.of<ProductsBloc>(context).add(
    FetchProductAndType(
      id: this.widget.subCategory.id,
      brand: brand,
      size: size,
      color: color,
      ordering: ordering
    )
  );
}

_showSheet(context){

showModalBottomSheet(
  context:context,
  builder: (BuildContext context){
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            onTap: (){
              ordering = "-id";
              _currentIndex = tabController.index;
              calltobloc();
              Navigator.pop(context);
            },
            title: Text("Relevant",style: TextStyle(fontWeight: FontWeight.bold), ),
            leading: Icon(Icons.calendar_view_day),
            trailing: ordering=="-id"?Icon(Icons.check_circle,color: Colors.green,):null,
          ),



          ListTile(            
            onTap: (){
              // print(tabController.index);
              ordering = "list_price";
              _currentIndex = tabController.index;
              calltobloc();
              Navigator.pop(context);
            },
            title: Text("Price low to high",style: TextStyle(fontWeight: FontWeight.bold), ),
            leading: Icon(Icons.attach_money),
            trailing: ordering=="list_price"?Icon(Icons.check_circle,color: Colors.green,):null,


          ),
          ListTile(
            onTap: (){
              ordering = "-list_price";
              _currentIndex = tabController.index;
              calltobloc();
              Navigator.pop(context);
            },


            title: Text("Price high to low",style: TextStyle(fontWeight: FontWeight.bold),),
            leading: Icon(Icons.attach_money),
            trailing: ordering=="-list_price"?Icon(Icons.check_circle,color: Colors.green,):null,
          ),
          ListTile(
            onTap: (){
              ordering = "name";
              _currentIndex = tabController.index;
              calltobloc();
              Navigator.pop(context);
            },

            title: Text("Name A-Z",style: TextStyle(fontWeight: FontWeight.bold),),
            leading: Icon(Icons.text_rotate_vertical),
            trailing: ordering=="name"?Icon(Icons.check_circle,color: Colors.green,):null,
          
          ),
          ListTile(
            onTap: (){
              ordering = "-name";
              _currentIndex = tabController.index;
              calltobloc();
              Navigator.pop(context);
            },
            title: Text("Name Z-A",style: TextStyle(fontWeight: FontWeight.bold),),
            leading: Icon(Icons.sort_by_alpha),
            trailing: ordering=="-name"?Icon(Icons.check_circle,color: Colors.green,):null,
          ),

          // ListTile(
          //   title: Text("Color"),
          //   leading: Icon(Icons.attach_money),
          // ),
          // ListTile(
          //   title: Text("Size"),
          //   leading: Icon(Icons.attach_money),
          // )
        ],
      )
    );
  }
);

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