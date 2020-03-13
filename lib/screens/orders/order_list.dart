import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/orders_product.dart';
class OrderList extends StatefulWidget{
  @override

  _OrderList createState() => _OrderList();
}

class _OrderList extends State<OrderList>
{
    void getOrders() async{  
      // print(userId);
      await getUserId().then((c){
        setState(() {
          userId = c;
        });
      });

      GraphQLClient _client = clientToQuery();    
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(getOrdersQuery),
          
          variables:{
            "userId":userId,
            }

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
        var data = result.data["orders"]["edges"];
        List<Orders> orders =[];

        for(int i=0;i<data.length;i++)
        {
          orders.add(
            Orders(
              data[i]["node"]["id"], 
              data[i]["node"]["product"]["id"],
              data[i]["node"]["product"]["name"],
              data[i]["node"]["date"],
              data[i]["node"]["qty"],
              data[i]["node"]["size"], 
              data[i]["node"]["price"],
              data[i]["node"]["paymentMode"],
              data[i]["node"]["product"]["imageLink"].split(",")[0],
              )
          );
        }

        setState(() {
          order = orders;
          isLoading = false;
        });


      }

    }


    @override
    bool isLoading=true;
    var userId;
    List<Orders> order;

    void initState()
    {
      super.initState();


      getOrders();
    }


    Widget build(BuildContext context)
    {
      return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          title: Text("My Orders"),
        ),

        // body: ,

        body: isLoading?Center(child: CircularProgressIndicator(),):
        
        
        Container(
          // padding: EdgeInsets.all(10),
          child:
          ListView.separated (
              separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
              height: 1,
              ),

            itemCount: order.length,
            itemBuilder:(context,index){
              return 
              
              // ListTile(
              //   title: Text(order[index].productName),
              // );
            
              Container(
                color:Colors.white,
                // color: Colors.grey[100],   
                // margin: EdgeInsets.only(bottom:10),  
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child:
                      CachedNetworkImage(
                          height: 100,
                          imageUrl: order[index].imgLink.toString(),
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>Center(child: CircularProgressIndicator()),

                          // placeholder: (context, url) => Container(height: 20,child:Container(child: CircularProgressIndicator(value: 0.2,))),
                          // errorWidget: (context, url, error) => Icon(Icons.error),
                        ),

                    
                    
                    ),
                    
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left:15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(order[index].productName,style: TextStyle(fontSize:18,fontWeight: FontWeight.w300),),
                            SizedBox(height:5),
                            Text(order[index].paymentMode,style: TextStyle(color:Colors.green),),
                            SizedBox(height:10),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("\u20B9 "+(order[index].price*order[index].qty).toString() ,style: TextStyle(fontWeight: FontWeight.w600),),
                                Text("Quantity:"+order[index].qty.toString(),style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            )

                          ],
                      ),
                        ),
                    ),
                  ],
                ),
              );
              

            
            } 
          )
        ),



      );
    }
}