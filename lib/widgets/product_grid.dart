import 'package:flutter/material.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/screens/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ProductGrid extends StatefulWidget{
  @override
  final List<Product> product;
  Function(bool) callback;

  ProductGrid(this.product,this.callback);
  _ProductGridState  createState() => _ProductGridState();
} 

class _ProductGridState extends State<ProductGrid>
{
  ScrollController _scrollController = new ScrollController();
  @override

  bool isLoading = false;
  
  void initState(){
  _scrollController.addListener((){
    // print(_scrollController.position.pixels);
    // print(_scrollController.position.maxScrollExtent);

    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // print("call");
        setState(() {
          // isLoading = true;
          this.widget.callback(true);
        });
    }
    
    // else{
    //     setState(() {
    //       isLoading=false;
    //     });
    // }

  });


  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  }
  Widget build(BuildContext context)
  {
    // setState(() {
    //   isLoading = false;
    // });
    // print("product....");
    // print(widget.product[0].imageLink[0] );

    return 
    
    Column(
      children: <Widget>[
        
        Expanded(
          child: GridView.count(
            controller: _scrollController,
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            childAspectRatio: 2/3,
            
            children: List.generate(widget.product.length, (index){
              // if(widget.product.length == index+1)
              // {
              //   // return CupertinoActivityIndicator();
              //   // print("match");
              //     setState(() {
              //       isLoading = true;
              //     });
              // }
              // else{
              //     setState(() {
              //       isLoading = false;
              //     });                
              // }

              //   // return CircularProgressIndicator();
              // }
              // else{
              //     setState(() {
              //       isLoading = false;
              //     });                
              // }

              return Container(

                // decoration: BoxDecoration(
                //   color:Colors.white,
                //       boxShadow: [BoxShadow(
                //       offset: const Offset(3, 5.0),
                //       color: Colors.grey[400],
                //       blurRadius: 10.0,
                //       // spreadRadius: 1.0,
                      
                //     ),],
                //   borderRadius: BorderRadius.circular(20)
                // ),

                child: GestureDetector(
                      onTap: ()=>Navigator.push(context, 
                      MaterialPageRoute(builder: (_)=>DetailPage(
                      product: widget.product[index],
                    ))),

                      child: Container(
                        // color:
                      decoration: BoxDecoration(
                        color:Colors.white,
                        border: Border.all(color:Colors.grey,width: 0.2)
                      ),
                      // color:Colors.white,
                // margin: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   color:Colors.white,
                //       boxShadow: [BoxShadow(
                //       offset: const Offset(3, 5.0),
                //       color: Colors.grey[400],
                //       blurRadius: 10.0,
                //       // spreadRadius: 1.0,
                      
                //     ),],
                //   borderRadius: BorderRadius.circular(20)
                // ),
                      // color:Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 230,
                              child: CachedNetworkImage(
                                height: 230,
                                imageUrl: widget.product[index].imageLink[0].toString(),
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                              ),
                          ),
                          Container(
                            child: Padding(
                              // padding: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.only(left: 10,right: 20),
                              child: Column(

                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      widget.product[index].name, 
                                      overflow: TextOverflow.ellipsis,
                                       style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                            Text(widget.product[index].listPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                            SizedBox(width: 10,),
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.red),),
                                            Text(widget.product[index].mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.red),),
                                            SizedBox(width: 6,),
                                            
                                            // double d = widget.product[index].mrp;
                                            Text(
                                                "("+
                                              ((widget.product[index].mrp - widget.product[index].listPrice)*100 / widget.product[index].mrp ).toInt().toString()
                                                +"% off)",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10
                                                ),
                                            )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                  ),
                ),
              );
            }),
          ),
        ),
        
        
        // Container(child: isLoading?
        // Text("loading.."):SizedBox(),
        
        // )


      ],
    );
  }
}