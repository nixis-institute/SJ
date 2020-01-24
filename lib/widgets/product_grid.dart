import 'package:flutter/material.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/screens/detail_screen.dart';

class ProductGrid extends StatefulWidget{
  @override
  final List<Product> product;

  ProductGrid({this.product});
  _ProductGridState  createState() => _ProductGridState();
} 

class _ProductGridState extends State<ProductGrid>
{
  @override
  Widget build(BuildContext context)
  {
    print("product....");
    print(widget.product);
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      childAspectRatio: 2/3,
      children: List.generate(widget.product.length, (index){
        return Container(
          child: GestureDetector(
            onTap: (){},
              //   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailPage(
              //   // category:category_model[index],
              //   // slider: category_model[index].slider,
              //   product: widget.product[index],
              // ))),
                
                child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 230,
                      child: Image.network("http://10.0.2.2:8000/media/"+widget.product[index].images[0].imgUrl ,fit:BoxFit.fill),
                      // child:CircleAvatar(
                      //   radius: 0,
                      //   backgroundImage: NetworkImage("http://10.0.2.2:8000/media/"+widget.product[index].images[0].imgUrl),
                      // ) ,
                      // child: Image.asset("http://10.0.2.2:80"+widget.product[index].images[0].imgUrl ,fit:BoxFit.fill),
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
                            // Text(top_sellings[index].name),

                            SizedBox(height: 5,),
                            Padding(
                              // padding: const EdgeInsets.only(left: 10,right: 20),
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      // Text("("+widget.product[index].discount.toInt().toString()+"% off)",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.red),)
                                   
                                  

                                ],
                              ),
                            )
                            
                            // Text(widget.product[index].count.toString()+" items"),
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