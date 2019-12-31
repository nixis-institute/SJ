import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/subcategory.dart';
import 'package:shopping_junction/screens/cart/first_secreen.dart';
import 'package:shopping_junction/widgets/product_grid.dart';
import 'package:shopping_junction/widgets/side_drawer.dart';

class ListPage extends StatefulWidget{
  @override
  final List<Product> product;
  final SubList list;
  ListPage({this.product,this.list});

  _ListPageState createState() => _ListPageState();
}
 



class _ListPageState extends State<ListPage>
{
  @override
  Widget build(BuildContext context)
  {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.light,      
            statusBarBrightness:Brightness.dark  
      ),
          child: DefaultTabController(
          
          length: widget.list.subCateogry.length,
          child: Scaffold(
          appBar: AppBar(
            title: Text(widget.list.name),
                actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: (){
                    // showSearchPage(context, _searchDelegate);
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
                      child: Text("3"),
                    ),
                  )
                ]
              ),



                // IconButton(
                //   icon: Icon(Icons.add_shopping_cart),
                //   iconSize: 25,
                //   color: Colors.white,
                //   onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
                //     )));
                //   },
                // ),
                // IconButton(
                //   icon: Icon(Icons.more_vert),
                //   iconSize: 30,
                //   color: Colors.white,
                //   onPressed: (){},
                // )                            
            ],

            bottom: TabBar(
              isScrollable: true,
              // unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                // color: Colors.grey
              ),
              tabs: List.generate(widget.list.subCateogry.length, (index)=>
                Tab(
                  
                  child: Text(widget.list.subCateogry[index].name),
                ),
               )
            ,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              indicatorColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              // unselectedLabelColor: ,

            ),
            ),
          

          body: TabBarView(
            children: List.generate(widget.list.subCateogry.length, (generator)=>
              ProductGrid(
                product: widget.list.subCateogry[generator].products,
              )
             )
          ),
          
          // ProductGrid(
          //   product: widget.product,
          // ),
          

          bottomNavigationBar: BottomAppBar(
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
            color: Colors.green,
            
          ),
        ),
      ),
    );
  }
}