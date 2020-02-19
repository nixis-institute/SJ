import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_junction/models/cart.dart';
import 'package:shopping_junction/screens/cart/second_screen.dart';
import 'package:shopping_junction/widgets/cart/product.dart';

class CartScreen extends StatefulWidget{
  @override
  _ChatScreenState createState() => _ChatScreenState();
}




class _ChatScreenState extends State<CartScreen>   {
  @override
  var qty=2;
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("CART"),

        actions: <Widget>[
          Row(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("Step:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              
              SizedBox(width: 5,),
              Text("1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              SizedBox(width: 15,)
            ],
          ),
        ],
      ),
      body: Scaffold(
        body: ListView(
          children: <Widget>[


            CartProductWidget(),
            Container(
              margin: EdgeInsets.only(top:50),
              // padding: EdgeInsets.only(top:50),

              color: Colors.grey[200],



              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Apply Coupon",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w300),),
                    Text("Enter Promo Code",style: TextStyle(color: Colors.grey[500],fontSize: 15,fontWeight: FontWeight.w300),)
                  ],
                ),
              ),
            ),

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
                        Text("\$130",style: TextStyle(color: Colors.grey[700],fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Bag Discount",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("-\$30",style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sub Total ",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\$100",style: TextStyle(color: Colors.grey[700],fontSize: 17,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Coupon Discount ",style: TextStyle(color: Colors.grey[500],fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\$0",style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.w300),)
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
                        Text("\$130",style: TextStyle(color: Colors.grey[700],fontSize: 17,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),                                    


                ],
              ),
            ),

            // SizedBox(height: 100,)
          ],
        ),
          bottomNavigationBar: InkWell(
            onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>AddressScreen(
            ))),
            child: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Place Order",
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