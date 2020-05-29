import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/bloc/orders_bloc/orders_bloc.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/orders_product.dart';
import 'package:shopping_junction/screens/orders/orders_details.dart';
class OrderList extends StatefulWidget{
  @override

  _OrderList createState() => _OrderList();
}

class _OrderList extends State<OrderList>
{
    // void getOrders() async{  
    //   // print(userId);
    //   await getUserId().then((c){
    //     setState(() {
    //       userId = c;
    //     });
    //   });

    //   GraphQLClient _client = clientToQuery();    
    //   QueryResult result = await _client.query(
    //     QueryOptions(
    //       documentNode: gql(getOrdersQuery),

    //     )
    //   );     

    //   if(result.loading)
    //   {
    //     setState(() {
    //       isLoading = true;
    //     });
    //   }

    //   if(!result.hasException)
    //   {
    //     var data = result.data["orders"]["edges"];
    //     // print(data);
    //     List<Orders> orders =[];

    //     for(int i=0;i<data.length;i++)
    //     {
    //       orders.add(
    //         Orders(
    //           data[i]["node"]["id"], 
    //           data[i]["node"]["status"], 
    //           data[i]["node"]["product"]["id"],
    //           data[i]["node"]["product"]["parent"]["name"],
    //           data[i]["node"]["date"],
    //           data[i]["node"]["qty"],
    //           data[i]["node"]["size"],
    //           data[i]["node"]["price"],
    //           data[i]["node"]["paymentMode"],
    //           data[i]["node"]["product"]["parent"]["imageLink"].split(",")[0],
    //           )
    //       );
    //     }

    //     setState(() {
    //       order = orders;
    //       isLoading = false;
    //     });


    //   }

    // }


    @override
    bool isLoading=true;
    var userId;
    List<Orders> order;

    void initState()
    {
      super.initState();

      BlocProvider.of<OrdersBloc>(context).add(
        FetchOrders()
      );
      // getOrders();
    }


    Widget build(BuildContext context)
    {
      return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back),
          title: Text("My Orders"),
        ),

        // body: ,
        body: BlocListener<OrdersBloc,OrdersState>(
          listener: (context,state){

          }, 
          
          child: BlocBuilder<OrdersBloc,OrdersState>(
            builder:(context,state) 
            {

            if(state is LoadOrders)
            {
            return Container(
              // padding: EdgeInsets.all(10),
              child:
              ListView.builder (
                  // separatorBuilder: (context, index) => Divider(
                  // color: Colors.grey,
                  // height: 1,
                  // ),

                itemCount: state.orders.length,
                itemBuilder:(context,index){
                  // var newFormat = DateFormat("yy-MM-dd");

                  // var newDt = DateFormat.yMMMEd().format(dt);

                  return 
                  
                  // ListTile(
                  //   title: Text(order[index].productName),
                  // );
                
                  Container(
                    margin:EdgeInsets.only(bottom:5,left:5,right:5),
                    child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (_)=>OrdersDetailScreen(orders: state.orders[index],))
                            );
                          },
                          child: Card(
                            elevation: 3,
                          
                          // elevation: 8,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10)
                          // ),
                          child: Container(
                          // color:Colors.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),




                          //.................radius and shadow.........
                          // decoration: BoxDecoration(
                          //   color:Colors.white,
                          //       boxShadow: [BoxShadow(
                          //       offset: const Offset(3, 5.0),
                          //       color: Colors.grey[400],
                          //       blurRadius: 10.0,
                                
                          //     ),],
                          //   borderRadius: BorderRadius.circular(20)
                          // ),


                          // color: Colors.grey[100],   
                          // margin: EdgeInsets.only(bottom:10),  
                          padding: EdgeInsets.all(10),
                          // margin:EdgeInsets.all(2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                alignment: Alignment.center,
                                child:state.orders[index].imgLink==null?Text("No Preview",style: TextStyle(color:Colors.grey,fontSize: 16),):
                                Hero(
                                  tag: state.orders[index].orderId,
                                      child: CachedNetworkImage(
                                      height: 100,
                                      imageUrl: server_url+"/media/"+ state.orders[index].imgLink.toString(),
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) =>Center(child: CircularProgressIndicator()),

                                      // placeholder: (context, url) => Container(height: 20,child:Container(child: CircularProgressIndicator(value: 0.2,))),
                                      errorWidget: (context, url, error) => Text("No Preview",style: TextStyle(color:Colors.grey,fontSize: 16),) //Icon(Icons.error,color: Colors.grey,),
                                    ),
                                ),

                              
                              
                              ),
                              
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left:10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // tag:state.orders[index].productName.replaceAll(" ", "-")+state.orders[index].orderId,
                                      Text(state.orders[index].productName,style: 
                                      TextStyle(fontSize:17,fontWeight: FontWeight.normal,color:
                                      state.orders[index].status=="Cancelled"?Colors.grey:Colors.black,
                                      ),),
                                      
                                      
                                      SizedBox(height:10),

                                      
                                      // Text(state.orders[index].date),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("\u20B9 "+(state.orders[index].price * state.orders[index].qty - state.orders[index].coupon).toInt().toString(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),),
                                          // SizedBox(width:40),
                                          Text(DateTime.parse(
                                            state.orders[index].date).day.toString()+"-"+
                                            DateTime.parse(state.orders[index].date).month.toString()   +"-"+
                                            DateTime.parse(state.orders[index].date).year.toString(),
                                            style: TextStyle(color:Colors.grey),
                                           ),
                                        ],
                                      ),
                                      // Text(timeago.format(DateTime.parse(mytimestring))

                                      SizedBox(height:10),
                                      Text(state.orders[index].status,style: 
                                      TextStyle(
                                      color:
                                      state.orders[index].status=="Delivered"?Colors.green:
                                      state.orders[index].status=="Cancelled"?Colors.red
                                      :Colors.blue,                                        
                                        // color:state.orders[index].status=="Delivered"?Colors.green:
                                        // state.orders[index].status=="Cancel"?Colors.red:Colors.black,


                                        fontWeight: FontWeight.w600),
                                        ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: <Widget>[
                                      //     Text("\u20B9 "+(order[index].price*order[index].qty).toString() ,style: TextStyle(fontWeight: FontWeight.w600),),
                                      //     Text("Items:"+order[index].qty.toString(),style: TextStyle(fontWeight: FontWeight.w300),)
                                      //   ],
                                      // )

                                    ],
                                ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } 
              )
            );
            }
            else{
              return Center(child: Text("loading.."),);
            }
          }
          ),
        ),



      );
    }
}