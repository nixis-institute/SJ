import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/cart.dart';

class CartProductWidget extends StatefulWidget{
  @override
  final List<CartProductModel> listCart;
  Function(double) callback;
  double total;
  CartProductWidget(this.listCart,this.callback,this.total);
  
  _CartProductState createState() => _CartProductState(); 

}

class _CartProductState extends State<CartProductWidget>{
  // _removeItem(item){

  // }

  void AddToCart(id,index) async{
    
    SharedPreferences preferences = await SharedPreferences.getInstance();    
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(UpdateInCart),
        variables:{
          "prdID":id,
          "userId":userID,
          'isNew':false,
          'qty':3,
          'size':4,
          }
      )
    );

    setState(() {
      cloading = true;
    });
    // if(result.loading)
    // {
    //   setState(() {
    //     cloading = true;
    //   });
    // }
    if(!result.hasException)
    {
      var data = result.data["updateCart"];
      if(data["success"] == true)
      {
        setState(() {
        cloading = false;
        // isInCart = true;  
        // _count += ;
        _count = (int.parse(_count)-1).toString(); 
        // product.removeAt(index);
        });
        // await preferences.setString("key", value)
        preferences.setString("cartCount", _count);
        // preferences.setString("cartCount", (int.parse(_count)).toString());
      }
    }

  }


  var qty = 1;
  var cloading=true;
  String userID;
  var _count = "";
  List<CartProductModel>  product;
  @override
  void initState(){
    super.initState();
    product = this.widget.listCart;
    getUserId().then((c){
      setState(() {
      userID = c;
      });
    });

    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });
  }


  Widget build(BuildContext context){
    return
    Container(
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      // child:AnimatedList(
      physics:ClampingScrollPhysics(),
      shrinkWrap: true,
      // initialItemCount: product.length,
      itemCount: product.length,
      itemBuilder: (BuildContext context,int index){
        // var begin = Offset(0.0, 1.0);
        // var end = Offset.zero;
        // var tween = Tween(begin: begin, end: end);
        return  
            Container(
            margin: EdgeInsets.only(top:10,right:10,left:10),
            // decoration: BoxDecoration(
            //   color:Colors.white,
            // // border: Border.all(color: Colors.green)
            // ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
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
                            imageUrl: 
                            
                            server_url+"/media/"+product[index].img,
                            
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                          ),
                      ),                  
                    // Text("sdflksdlkfjklsdjfkl")
                    
                    
                    ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right:10,top:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: new EdgeInsets.only(right: 2),
                            child: Text(
                            product[index].name,
                            // overflow: TextOverflow.,
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,
                            ),
                            ),
                          ),



                      SizedBox(height: 15,),
                      Row(
                        children: <Widget>[
                          // Text(cart.products[index].product.name),
                              Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                              Text((product[index].listPrice*product[index].qty).toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                              SizedBox(width: 10,),
                              Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
                              Text((product[index].mrp*product[index].qty).toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
                              SizedBox(width: 6,),
                              
                              // double d = cart.products[index].product.mrp;
                              Text(
                                  "("+
                                ((product[index].mrp - product[index].listPrice)*100 / product[index].mrp ).toInt().toString()
                                  +"% off)",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                  ),
                              )
                        ],
                      ),

                          // SizedBox(height: 5,),
                          Row(
                            children: <Widget>[
                              Text("Size:",style: TextStyle(color: Colors.black54, fontSize: 17),),
                              SizedBox(width: 5,),
                              Text(
                                product[index].selectedSize,
                                // "M",
                              
                              style: TextStyle(color: Colors.blue,fontSize: 19),),
                              SizedBox(width:40),
                              
                              // cloading?CircularProgressIndicator():
                              IconButton(
                                icon:Icon(Icons.delete_forever),
                                color:Colors.black54,
                                onPressed: (){

                            setState(() {
                              // product[index].qty-=1;
                              AddToCart(product[index].id,index);
                              this.widget.callback(
                                this.widget.total - product[index].listPrice
                              );
                              product.removeAt(index);

                            });

                                },
                              )

                              // IconButton(
                              //   Icons.delete,
                              //   color: Colors.black54,
                              //   onPressed: (){
                              //   product.removeAt(index)
                              //   //   // AnimatedList.of(context).removeItem(index, builder)
                              //   //   // _removeItem()
                              //   // },
                              //   ),

                            ],
                          ),

                        ],
                      ),
                    ),        
                  ),



                  Container(
                    
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.,
                      children: <Widget>[
                        
                      InkWell(
                          onTap: (){
                            if(product[index].qty>1){
                              setState(() {
                                  product[index].qty-=1;
                              });
                              this.widget.callback(this.widget.total- product[index].listPrice);
                              }
                          },
                          child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200]
                          ),
                          child: Icon(Icons.remove,color: Colors.grey, )
                          ),
                        ),
                        
                        
                        SizedBox(height: 20,),

                        Center(
                          child: Text(product[index].qty.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // textBaseline: TextBaseline.alphabetic
                          ),
                          ),
                        ),
                        
                        SizedBox(height: 20,),
                        
                        InkWell(
                          onTap: (){
                          if(product[index].qty>0)
                          {
                            setState(() {
                                product[index].qty+=1; 
                              // this.widget.callback(this.widget.total+ product[index].listPrice);
                            });
                            }
                          this.widget.callback(this.widget.total+ product[index].listPrice);
                          
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
                  //           product[index].qty-=1;
                  //         },
                  //         child: Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey[200]
                  //         ),
                  //         child: Icon(Icons.remove,color: Colors.grey, )
                  //         ),
                  //     ),

                  //     SizedBox(width: 15,),
                  //     Text(product[index].qty.toString(),
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