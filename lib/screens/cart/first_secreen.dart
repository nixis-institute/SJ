import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/cart.dart';
import 'package:shopping_junction/screens/accounts/addressScreen.dart';
import 'package:shopping_junction/screens/cart/second_screen.dart';
import 'package:shopping_junction/widgets/cart/product.dart';

class CartScreen extends StatefulWidget{
  @override
  _ChatScreenState createState() => _ChatScreenState();
}




class _ChatScreenState extends State<CartScreen>   {
  List<CartProductModel> cartList =[];
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
      // print("ddd");
      // print(result.data["cartProducts"]["edges"]);
      for(int i=0;i<data.length;i++)
      {
        
        var node = data[i]["node"];



        p+=node["cartProducts"]["listPrice"] * node["qty"];
        
        l.add(
          CartProductModel(
            node["cartProducts"]["id"],
            node["cartProducts"]["parent"]["name"], 
            node["cartProducts"]["productimagesSet"]["edges"].isEmpty?null:node["cartProducts"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"], 
            node["cartProducts"]["mrp"], 
            node["cartProducts"]["listPrice"], 
            node["size"], 
            node["qty"],
            node["cartProducts"]["parent"]["id"],
            node["color"]
            )
        );
      }
      // print(l);

      setState(() {
        totalPrice = p;
        cartList = l;
        isLoading = false;
      });
      setTotal(p.toString());
    }
  }
  

  callback(listCart,total) {
    setState(() {
    cartList = listCart;
    totalPrice = total;
    setTotal(total.toString());
    });

    // print(cartList.length);


    // updateSharePrefrence(total);
}



  @override
  bool isLoading = true;
  double totalPrice =0;
  void initState()
  {
    super.initState();
    fillCartProduct();
  }
  var qty=2;
 

  
  Widget build(BuildContext context)
  {
    // if(!isLoading)
    // {
    //   // cartList
    //   double total;
    //   for(int i=0;i<cartList.length;i++)
    //   {
    //     total += cartList[i].listPrice;
    //   }
    // }
    // else{
    //   double total=0;
    // }

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
      body: isLoading?Center(child: CircularProgressIndicator(),):
      Scaffold(
        body: 
        
        cartList.length!=0
        
        ?ListView(
          children: <Widget>[


            CartProductWidget(cartList,callback,totalPrice),
            
            
            
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
            ),

            // SizedBox(height: 100,)
          ],
        ):
        
        Center(
          child: Text("Your Cart is Empty",
            style: TextStyle(
              fontSize: 20
            ),

          ),
        )
        
        
        ,


          bottomNavigationBar: 
          
          cartList.length>0?
          InkWell(
            onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>Addresses(
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
        ):null,
      ),
    );
  }


}