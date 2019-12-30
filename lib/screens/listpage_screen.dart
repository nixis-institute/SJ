import 'package:flutter/material.dart';
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
    return DefaultTabController(
        
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
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                iconSize: 25,
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
                  )));
                },
              ),
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
              )
             )

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
    );
  }
}