import 'package:flutter/material.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/screens/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductGrid extends StatefulWidget{
  @override
  final List<Product> product;

  ProductGrid({this.product});
  _ProductGridState  createState() => _ProductGridState();
} 

class _ProductGridState extends State<ProductGrid>
{
  // ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context)
  {
    // print("product....");
    // print(widget.product[0].imageLink[0] );

    return GridView.count(
      // controller: _scrollController,
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      childAspectRatio: 2/3,
      children: List.generate(widget.product.length, (index){
        return Container(
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
    );
  }
}