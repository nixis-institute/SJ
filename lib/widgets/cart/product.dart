import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_junction/models/cart.dart';

class CartProductWidget extends StatefulWidget{
  @override
  final List<CartProductModel> listCart;
  CartProductWidget({this.listCart});
  
  _CartProductState createState() => _CartProductState(); 

}

class _CartProductState extends State<CartProductWidget>{
  var qty = 1;
  @override
  Widget build(BuildContext context){
    return
    Container(
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      physics:ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: this.widget.listCart.length,
      itemBuilder: (BuildContext context,int index){
        return  

            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.green)
              ),
              child: Container(           
              padding: EdgeInsets.only(right:10),
              decoration: BoxDecoration(
              ),


              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: 
                          Container(
                          padding: EdgeInsets.all(5),
                          width: 90,
                          height: 120,
                          child:CachedNetworkImage(
                            imageUrl: this.widget.listCart[index].img,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                          ),
                      ),                  
                    // Text("sdflksdlkfjklsdjfkl")
                    
                    
                    ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: new EdgeInsets.only(right: 2),
                            child: Text(
                            this.widget.listCart[index].name,
                            // overflow: TextOverflow.,
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300,
                            ),
                            ),
                          ),



                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          // Text(cart.products[index].product.name),
                              Text("\u20B9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              Text(this.widget.listCart[index].listPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              SizedBox(width: 10,),
                              Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
                              Text(this.widget.listCart[index].mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
                              SizedBox(width: 6,),
                              
                              // double d = cart.products[index].product.mrp;
                              Text(
                                  "("+
                                ((this.widget.listCart[index].mrp - this.widget.listCart[index].listPrice)*100 / this.widget.listCart[index].mrp ).toInt().toString()
                                  +"% off)",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                  ),
                              )
                        ],
                      ),

                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Text("Size:",style: TextStyle(color: Colors.black54, fontSize: 17),),
                              SizedBox(width: 5,),
                              Text("M",style: TextStyle(color: Colors.blue,fontSize: 19),)

                            ],
                          ),

                        ],
                      ),
                    ),        
                  ),



                  Container(
                    
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        
                      InkWell(
                          onTap: (){
                            setState(() {
                              this.widget.listCart[index].qty-=1;
                            });
                          },
                          child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200]
                          ),
                          child: Icon(Icons.remove,color: Colors.grey, )
                          ),
                      ),
                        SizedBox(height: 20,),

                        Text(this.widget.listCart[index].qty.toString()),
                        
                        SizedBox(height: 20,),
                        
                        InkWell(
                          onTap: (){
                            setState(() {
                              this.widget.listCart[index].qty+=1;
                            });

                          },
                          child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200]
                          ),
                          child: Icon(Icons.add,color: Colors.grey, )
                          ),
                      ),


                      ],
                    ),

                  // child: Column(
                  //   children: <Widget>[
                  //     InkWell(
                  //         onTap: (){
                  //           this.widget.listCart[index].qty-=1;
                  //         },
                  //         child: Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey[200]
                  //         ),
                  //         child: Icon(Icons.remove,color: Colors.grey, )
                  //         ),
                  //     ),

                  //     SizedBox(width: 15,),
                  //     Text(this.widget.listCart[index].qty.toString(),
                  //     // Text("sdf",
                  //     style: TextStyle(fontSize: 20),),
                  //     SizedBox(width: 15,),

                  //     InkWell(
                  //       onTap: (){
                  //         this.widget.listCart[index].qty+=1;
                  //       },
                  //       child: Container(
                  //       decoration: BoxDecoration(
                  //       color: Colors.grey[200]
                  //       ),
                  //         child: Icon(Icons.add,color: Colors.grey,)
                  //         ),
                  //     ),
                  //   ],
                  // ),
                  )
                ],
              ),
          
              // child: Text(cart.products[index].product.name),
              // child: Column(
              //   // crossAxisAlignment: CrossAxisAlignment.center,
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              //   children: <Widget>[
              //     Container(
              //       height: 120,
              //       width: MediaQuery.of(context).size.width,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.green)
              //       ),

              //       child: Row(
              //         children: <Widget>[
              //             Container(
              //             padding: EdgeInsets.all(5),
              //             width: 90,
              //             child:CachedNetworkImage(
              //               imageUrl: this.widget.listCart[index].img,
              //               fit: BoxFit.cover,
              //               alignment: Alignment.topCenter,
              //               placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
              //             ),
              //         ),


              //           Container(
              //             width: MediaQuery.of(context).size.width - 120,
              //             // color: Colors.red,
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               // crossAxisAlignment: CrossAxisAlignment.center,
              //               children: <Widget>[

              //                 Container(
              //                   // color: Colors.red,
              //                   padding: const EdgeInsets.only(top:10,left: 10),
              //                   child: Container(
              //                     // color: Colors.black,


              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: <Widget>[

              //                         Flexible(
              //                             child: Container(
              //                               padding: new EdgeInsets.only(right: 2),

              //                               child: Text(
              //                               this.widget.listCart[index].name,
              //                               overflow: TextOverflow.ellipsis,
              //                               style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300,
              //                               ),
              //                               ),
              //                             ),
              //                         ),

              //                         SizedBox(height: 5,),
              //                         Row(
              //                           children: <Widget>[
              //                             // Text(cart.products[index].product.name),
              //                                 Text("\u20B9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              //                                 Text(this.widget.listCart[index].listPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              //                                 SizedBox(width: 10,),
              //                                 Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
              //                                 Text(this.widget.listCart[index].mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
              //                                 SizedBox(width: 6,),
                                              
              //                                 // double d = cart.products[index].product.mrp;
              //                                 Text(
              //                                     "("+
              //                                   ((this.widget.listCart[index].mrp - this.widget.listCart[index].listPrice)*100 / this.widget.listCart[index].mrp ).toInt().toString()
              //                                     +"% off)",
              //                                     style: TextStyle(
              //                                       color: Colors.red,
              //                                       fontWeight: FontWeight.w400,
              //                                       fontSize: 12
              //                                     ),
              //                                 )
              //                           ],
              //                         ),
              //                         SizedBox(height: 10,),
              //                         Row(
              //                           children: <Widget>[
              //                             Text("Size:",style: TextStyle(color: Colors.black54, fontSize: 17),),
              //                             SizedBox(width: 5,),
              //                             Text("M",style: TextStyle(color: Colors.blue,fontSize: 19),)

              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
                            
              //               // Text("Sdf"),

              //               Container(
              //                 // alignment: Alignment.centerRight,
              //                 padding: const EdgeInsets.all(8.0),

              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: <Widget>[
              //                     InkWell(
              //                         onTap: (){
              //                           // AddQty();
              //                           // RemoveQty();
              //                           this.widget.listCart[index].qty-=1;
              //                         },

              //                         child: Container(
              //                         decoration: BoxDecoration(
              //                           color: Colors.grey[200]
              //                         ),
              //                         child: Icon(Icons.remove,color: Colors.grey, )
              //                         ),
              //                     ),

              //                     SizedBox(width: 15,),
              //                     Text(this.widget.listCart[index].qty.toString(),
              //                     style: TextStyle(fontSize: 20),),
              //                     SizedBox(width: 15,),

              //                     InkWell(
                                    
              //                       onTap: (){
              //                         // cart.products[index].qty+=1;
              //                         this.widget.listCart[index].qty+=1;
              //                       },

              //                       child: Container(
              //                       decoration: BoxDecoration(
              //                       color: Colors.grey[200]
              //                       ),
              //                         child: Icon(Icons.add,color: Colors.grey,)
              //                         ),
              //                     ),
              //                   ],
              //                 ),
              //               )


              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     )
              //   ],


              // ),
          
          ),
            );  
        // Text(cart.products[index].product.name);
      
      },

    ),
  );
  }
    RemoveQty() {
    setState(() {
      qty>1?
      qty--:
      qty
      ;
    });
  }
    AddQty() {
    setState(() {
      qty++;
    });
  }

}