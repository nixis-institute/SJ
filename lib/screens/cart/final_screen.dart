import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/cart.dart';

import 'sucess_screen.dart';

class FinalScreen extends StatefulWidget{
  
  @override

  _FinalScreen createState() => _FinalScreen();
}

class _FinalScreen extends State<FinalScreen>
{
    List<CartProductModel> cartList =[];

    void postOrder() async{
      setState(() {
        isOrdering = true;          
      });

      print(addressId);
      print(modeOfPayment);

      GraphQLClient _client = clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(updateOrdersQuery),
          variables: {
            "addressId":addressId,
            "mode":modeOfPayment
          }
        )
      );

      if(!result.hasException)
      {
        if(result.data["updateOrders"]["success"]==true)
        {
          // print("order complese");
          await Navigator.push(context, MaterialPageRoute(builder: (_)=>SuccessScreen(
          )));
        }
      }
    }


    void fillCartProduct() async{
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(CartProductsQuery)
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
      var data = result.data["cartProducts"]["edges"];
      double p = 0;
      List<CartProductModel> l=[];
      for(int i=0;i<data.length;i++)
      {
        
        var node = data[i]["node"];
        p+=node["cartProducts"]["listPrice"] * node["qty"];        
        l.add(
          CartProductModel(
            node["cartProducts"]["id"],

            node["cartProducts"]["parent"]["name"], 
            node["cartProducts"]["productimagesSet"]["edges"].isNotEmpty?node["cartProducts"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
            // node["cartProducts"]["parent"]["imageLink"].split(",")[0], 

            node["cartProducts"]["mrp"], 
            node["cartProducts"]["listPrice"], 
            node["size"], 
            node["qty"],
            node["cartProducts"]["parent"]["id"], 
            node["color"]
            )
        );
      }

      setState(() {
        totalPrice = p;
        cartList = l;
        isLoading = false;
      });

      // print("Cart.....");
      // print(cartList);
    }
  }

  @override
  var total="";
  bool isLoading = true;
  var modeOfPayment="";
  var address="";
  var addressId="";
  var phone="";
  var personName="";
  var userId="";
  bool isOrdering = false;
  
  void initState()
  {
    super.initState();
    fillCartProduct();
    getTotal().then((c){
      total = c;
    });

    getUserId().then((c){
      userId = c;
    });

    getPaymentMode().then((c){
      modeOfPayment = c;
    });

    get_Address().then((c){
      address = c;
    });

    getAddressId().then((c){
      addressId = c;
    });
    getPhone().then((c){
      phone = c;
    });

    getPersonName().then((c){
      personName = c;
    });

  }

  var totalPrice;
  
  Widget build(BuildContext context)
  {
    // print(cartList);
    // print(personName);
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmation"),
      ),

      bottomNavigationBar: InkWell(
            // onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>FinalScreen(
            // ))),

            // onTap: (){
            //   postOrder();
            // },
            onTap:()=> !isOrdering?postOrder():{},

            child: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  isOrdering?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)):
                  Text(
                    isOrdering?
                    "wait...."
                    :"Place Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                    ),
                  )
                ],
              ),
            ),
            color:isOrdering?Colors.grey:Colors.green,
        ),
      ),

    body: isLoading?Center(child:CircularProgressIndicator()):
    
    // Container(
    //   padding: EdgeInsets.all(1),
    //   child:ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: cartList.length,
    //     itemBuilder: (context,index)
    //     {
    //       return Container(
    //         color: Colors.white,
    //         child: ListTile(
    //           leading: cartList[index].img==null?Container(width: 55,alignment: Alignment.center, child: Text("No Preview"),):
    //             CachedNetworkImage(
    //               imageUrl: server_url+"/media/"+ cartList[index].img,
    //               fit: BoxFit.cover,
    //               alignment: Alignment.topCenter,
    //               placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
    //               errorWidget: (context, url,error) =>  Center(child:Text("No Preview")),
    //             ),
              
    //           title: Text(cartList[index].name),
    //           subtitle: Text("Quantity "+ cartList[index].qty.toString()),
    //           trailing: Text((cartList[index].listPrice*cartList[index].qty).toString() ),
    //         ),
    //       );
    //     }
    //   ),
    // ),


    // Container(
    //   color:Colors.grey[300],
    //   padding: EdgeInsets.only(left:15,top:10,bottom:10,right:10),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       Text("Total Payable",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold ),),
    //       Text(total,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold ),)
    //     ],
    //   ),
    // ),

    // Container(
    //   padding: EdgeInsets.only(left:15,top:10,right:10),
    //   child: Text("Address ",style: TextStyle(fontSize:20,fontWeight: FontWeight.w300))
    //   ),

    // SizedBox(height: 10,),
    // Container(
    //   padding: EdgeInsets.only(left:15,bottom:10,right:10),
    //   child: 
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Text(personName,style: TextStyle(fontSize:18) ),
    //       SizedBox(height:5),
    //       Text(address),
    //       SizedBox(height:5),
    //       Text(phone),
    //     ],
    //   )        
    // ),
      
    // Divider(),
    // Container(
    //   padding: EdgeInsets.only(left:15,top:10,right:10),
    //   child: Text("Payment Mode ",style: TextStyle(fontSize:20,fontWeight: FontWeight.w300))
    //   ),        
    // SizedBox(height:10),
    // Container(
    //   padding: EdgeInsets.only(left:15,bottom:10,right:10),
    //   child: Text(modeOfPayment,style: TextStyle(fontSize:18),),
    // ),

    ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          // color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cartList.length,
            // separatorBuilder: (context,index)=>Divider(thickness: 1,),
            // itemBuilder: null, 
            itemBuilder: (context,index){
              return Card(
                  elevation: 1,
                  child: Column(
                  children: <Widget>[
                    Container(
                      // color:Colors.white,
                      child: ListTile(
                        trailing: cartList[index].img ==null? Text("No Preview",style: TextStyle(color:Colors.grey),):
                        
                        CachedNetworkImage(
                        imageUrl: server_url+"/media/"+cartList[index].img,
                        fit: BoxFit.contain,
                        // errorWidget: (context,s,error) => Container(alignment: Alignment.centerRight, child: Text("Error",style: TextStyle(color: Colors.grey),)),
                        errorWidget: (context,url,error) => Container(margin: EdgeInsets.only(top:20), child: Text("No Preview",textAlign: TextAlign.center,style:TextStyle(color:Colors.grey),))
                        // errorWidget: (context,url,error) => Center(child: Text("Not Found",style: TextStyle(color:Colors.grey),),),
                        )
                        ,
                        isThreeLine: true,
                        title: 
                        // tag: this.widget.orders.productName.replaceAll(" ", "-")+this.widget.orders.orderId,
                        Text(cartList[index].name ,style: TextStyle(fontWeight: FontWeight.bold), ),
                        
                        subtitle: Text(
                          "\u20B9 "+
                          cartList[index].listPrice.toString(),style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        // trailing: Text(this.widget.orders.price.toString()),
                      ),
                    ),


                  Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text("Quantity"),
                              SizedBox(height:10),
                              Text(cartList[index].qty.toString(),style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                            ],
                          ),
                        ),

                        Container(height: 30, child: VerticalDivider(color: Colors.green)),
                        // VerticalDivider(color: Colors.black,thickness: 1, width: 10,),
                        // Divider(color:Colors.black),
                      
                      Expanded(
                        child: Column(
                            children: <Widget>[
                              Text("Color"),
                              SizedBox(height:10),
                              Container(
                                // color: Colors.blue,
                                width: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse(cartList[index].selectedColor.replaceAll("#","0xff"))),
                                        borderRadius: BorderRadius.circular(10)

                                      ),
                                      // child: ,
                                    ),
                                    // SizedBox(width:10),
                                    Text(colorsPicker[cartList[index].selectedColor],style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),

                        Container(height: 30, child: VerticalDivider(color: Colors.green)),
                        
                        Expanded(
                          // color: Colors.red,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Size"),
                              SizedBox(height:10),
                              Text(cartList[index].selectedSize, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                      ],
                    ),
                    // SizedBox(height: 15,),
                    // this.widget.orders.status=="Processing"?
                    // RaisedButton(onPressed:(){_showDialog();},child: Text("Cancel Order"),):SizedBox()
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(),
                    //     borderRadius: BorderRadius.circular(20)
                    //   ),
                    //   child: Text("Cancel"),
                      
                    //   )

                    // FlatButton(onPressed: null, textColor: Colors.red, child: Container(child: Text("Press"),),)
                  ],
                ),
                SizedBox(height:10)


                  ],
                ),
              );
            }, 
            
            
            ),
        ),
        SizedBox(height:10),
        // Divider(thickness: 1,),
        Container(
          
          padding: EdgeInsets.only(left:15,top:10,right:10),
          child: Text("Address ",style: TextStyle(fontSize:25,fontWeight: FontWeight.w600,color: Colors.grey))
          ),

          SizedBox(height:5),
          Card(
            child: Container(
                padding: EdgeInsets.only(left:10,bottom:10,top:10),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                  personName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                    // fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height:7),

                Text(
                  address,
                  // address.houseNo +" "+ address.colony + " "+ address.city +" "+ address.state,
                  
                  style: TextStyle(
                    fontSize: 15,
                    // color: Colors.black54
                  ),
                ),
                SizedBox(height:10),
                Text(
                  phone,
                  // address.phoneNumber + ", "+ address.alternateNumber,
                  style: TextStyle(
                    fontSize: 15,
                    // color: Colors.black54
                  ),
                ),                    
                ],
              ),
            ),
          ),
          SizedBox(height:20),
          Container(
          padding: EdgeInsets.only(left:15,top:10,right:10),
          child: Text("Billing Info ",style: TextStyle(fontSize:25,fontWeight: FontWeight.w600,color: Colors.grey))
          ),

          Card(
            child:
            Container(
              color: Colors.grey[200],
              margin: EdgeInsets.only(top:5),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Big Total ",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\u20B9"+
                          totalPrice.toString() ,
                          // total,
                          // "\$130",
                        
                        style: TextStyle(color: Colors.grey[700],fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Bag Discount",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("-\u20B90",style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sub Total ",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\u20B9"+totalPrice.toString(),style: TextStyle(color: Colors.grey[700],fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Coupon Discount ",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\u20B90",style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery ",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("Free",style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Payable ",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\u20B9"+totalPrice.toString(), style: TextStyle(color: Colors.grey[700],fontSize: 17,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),                                    


                ],
              ),
            )
          )


      ],
    ),

    );
  }
}

