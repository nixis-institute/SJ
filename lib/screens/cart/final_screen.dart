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
      GraphQLClient _client = clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(updateOrdersQuery),
          variables: {
            "id":userId,
            "mode":modeOfPayment
          }
        )
      );

      if(result.loading)
      {
        setState(() {
          isOrdering = true;          
        });

      }

      if(!result.hasException)
      {
        if(result.data["updateOrders"]["success"]==true)
        {
          print("order complese");
            Navigator.push(context, MaterialPageRoute(builder: (_)=>SuccessScreen(
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
            node["cartProducts"]["name"], 
            node["cartProducts"]["imageLink"].split(",")[0], 
            node["cartProducts"]["mrp"], 
            node["cartProducts"]["listPrice"], 
            node["size"], 
            node["qty"],
            )
        );
      }

      setState(() {
        totalPrice = p;
        cartList = l;
        isLoading = false;
      });

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
      phone =c;
    });

    getPersonName().then((c){
      personName = c;
    });

  }

  var totalPrice;
  
  Widget build(BuildContext context)
  {
    print(personName);
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmation"),
      ),

      bottomNavigationBar: InkWell(
            // onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>FinalScreen(
            // ))),

            onTap: (){
              postOrder();
            },

            child: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
            color: Colors.green,      
        ),
      ),

    body: ListView(
      children: <Widget>[
 
        Container(
          padding: EdgeInsets.only(left:15,top:10,bottom:10),
          child: Text("Your Products",style: TextStyle(fontSize:25,fontWeight: FontWeight.w300))
          ),
 
 
        isLoading?Center(child:CircularProgressIndicator()):
        
        Container(
          padding: EdgeInsets.all(1),
          child:ListView.builder(
            shrinkWrap: true,
            itemCount: cartList.length,
            itemBuilder: (context,index)
            {
              return ListTile(
                leading: 
                CachedNetworkImage(
                    imageUrl:  cartList[index].img,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                  ),
                
                title: Text(cartList[index].name),
                trailing: Text(cartList[index].listPrice.toString()),
              );
            }
          ),
        ),


        Container(
          color:Colors.grey[300],
          padding: EdgeInsets.only(left:15,top:10,bottom:10,right:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total Payable",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold ),),
              Text(total,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold ),)
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.only(left:15,top:10,right:10),
          child: Text("Address ",style: TextStyle(fontSize:25,fontWeight: FontWeight.w300))
          ),

        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.only(left:15,bottom:10,right:10),
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(personName,style: TextStyle(fontSize:18) ),
              SizedBox(height:5),
              Text(address),
              SizedBox(height:5),
              Text(phone),
            ],
          )        
        ),
      
        Divider(),
        Container(
          padding: EdgeInsets.only(left:15,top:10,right:10),
          child: Text("Payment Mode ",style: TextStyle(fontSize:25,fontWeight: FontWeight.w300))
          ),        
        SizedBox(height:10),
        Container(
          padding: EdgeInsets.only(left:15,bottom:10,right:10),
          child: Text(modeOfPayment,style: TextStyle(fontSize:18),),
        ),
      ],
    ),

    );
  }
}

