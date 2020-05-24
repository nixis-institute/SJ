import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/bloc/orders_bloc/orders_repository.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/orders_product.dart';
import 'package:shopping_junction/models/userModel.dart';
class OrdersDetailScreen extends StatefulWidget{
  Orders orders;
  OrdersDetailScreen({this.orders});
  @override
  _OrdersDetailScreen createState() => _OrdersDetailScreen();
}

class _OrdersDetailScreen extends State<OrdersDetailScreen>{
  OrdersRepository repository = OrdersRepository();
  Address address;
  void getAddress() async{
    setState(() {
      addressLoad = true;
    });
    address = await repository.getOrder(this.widget.orders.orderId);
    // print(address);
    setState(() {
      addressLoad = false;
    });    
  }
  bool addressLoad=true;
  void initState()
  {
    super.initState();
    getAddress();  
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar:BottomAppBar(
        elevation: 5,
        child: Container(
          height:50,
          alignment: Alignment.center,
          child: 
            Text(this.widget.orders.status,
            style: TextStyle(
                fontSize: 18,
                color: this.widget.orders.status=="Delivered"?Colors.green:Colors.black,
                fontWeight: FontWeight.bold
                ),
              )
          ),
      ),
      appBar: AppBar(
        title: Text(this.widget.orders.productName),  
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Product Info",style: TextStyle(color:Colors.grey, fontSize: 20),)
              ),
            
            Column(
              children: <Widget>[
                Container(
                  color:Colors.white,
                  child: ListTile(
                    trailing: CachedNetworkImage(
                      imageUrl: server_url+"/media/"+this.widget.orders.imgLink
                      ),
                    title: Text(this.widget.orders.productName,style: TextStyle(fontWeight: FontWeight.bold), ),
                    subtitle: Text(
                      "\u20B9 "+
                      this.widget.orders.price.toString(),style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    // trailing: Text(this.widget.orders.price.toString()),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Seller"),
                            SizedBox(height:10),
                            Text(this.widget.orders.sellerName,style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
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
                            Text(colorsPicker[this.widget.orders.color],style: TextStyle(fontWeight: FontWeight.bold)),
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
                            Text(this.widget.orders.size,style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                    ],
                  )
                  
                  // Column(
                  //   children: <Widget>[
                  //     Row(
                  //       children: <Widget>[
                  //         Text("Seller",style: TextStyle(fontSize: 16),),
                  //         SizedBox(width:10),
                  //         Text(this.widget.orders.sellerName,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.green)),
                  //       ],
                  //     ),
                  //     Row(
                  //      children: <Widget>[
                  //        Text("Color",style: TextStyle(fontSize: 16),),
                  //        SizedBox(width:10),
                  //        Text(colorsPicker[this.widget.orders.color])
                  //       ],
                  //     ),
                  //     Row(
                  //      children: <Widget>[
                  //        Text("Size",style: TextStyle(fontSize: 16),),
                  //        SizedBox(width:10),
                  //        Text(this.widget.orders.size)
                  //       ],
                  //     )
                  //   ],
                  // ),
                  
                )
              ],
            ),
            
            SizedBox(height:20),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Address",style: TextStyle(color:Colors.grey, fontSize: 20),)
              ),
            
            Card(
              // color: Colors.white,
              elevation: 0,
                child: addressLoad==true? Container( child: Center(child: CircularProgressIndicator())):
                Container(
                    padding: EdgeInsets.only(left:10,bottom:10,top:10),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                      address.personName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height:7),

                    Text(
                      address.houseNo +" "+ address.colony + " "+ address.city +" "+ address.state,
                      style: TextStyle(
                        fontSize: 15,
                        // color: Colors.black54
                      ),
                    ),
                    SizedBox(height:10),
                    Text(
                      address.phoneNumber + ", "+ address.alternateNumber,
                      style: TextStyle(
                        fontSize: 15,
                        // color: Colors.black54
                      ),
                    ),                    
                    ],
                  ),
                ),              
              // title: this.widget.orders.,
            ),

            SizedBox(height:20),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Pricing Info",style: TextStyle(color:Colors.grey, fontSize: 20),)
              ),
            Card(
              color:Colors.white,
              // padding: EdgeInsets.all(10),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Product Price",style: TextStyle(fontSize: 17),),
                        Text("\u20B9 "+this.widget.orders.mrp.toString(),style: TextStyle(fontSize: 17),)
                      ],
                    ),
                    SizedBox(height:15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Selling Price",style: TextStyle(fontSize: 17),),
                        Text("\u20B9 "+this.widget.orders.price.toString(),style: TextStyle(fontSize: 17),)
                      ],
                    ),
                    SizedBox(height:15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Discount",style: TextStyle(fontSize: 17),),
                        Text("\u20B9 "+this.widget.orders.discount.toString(),style: TextStyle(fontSize: 17),)
                      ],
                    ),
                    SizedBox(height:15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Coupon",style: TextStyle(fontSize: 17),),
                        Text("\u20B9 "+this.widget.orders.coupon.toString(),style: TextStyle(fontSize: 17),)
                      ],
                    ),

                    SizedBox(height:15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Quantity",style: TextStyle(fontSize: 17),),
                        Text(this.widget.orders.qty.toString(),style: TextStyle(fontSize: 17),)
                      ],
                    ),

                    SizedBox(height:15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Bill",style: TextStyle(fontSize: 17),),
                        Text("\u20B9 "+( (this.widget.orders.price - this.widget.orders.discount - this.widget.orders.coupon)*this.widget.orders.qty   ).toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                      ],
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}