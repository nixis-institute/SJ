import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/orders_product.dart';
import 'package:shopping_junction/models/userModel.dart';

class OrdersRepository{
  GraphQLClient _client = clientToQuery();    
  

  Future<Address> getOrder(String id) async{
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getOrderQuery),
        variables: {
          "orderId":id
        }
      )
    );
    if(!result.hasException){
      var data = result.data["getOrder"]["address"];
      Address add = Address(
        data["id"], 
        data["houseNo"], 
        data["colony"], 
        data["personName"], 
        data["landmark"], 
        data["city"], 
        data["state"], 
        data["phoneNumber"], 
        data["alternateNumber"]
        );
      return add;
    }
  }

  Future<List<Orders>> getAllOrders() async{
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(getOrdersQuery),

        )
      );     

      if(!result.hasException)
      {
        var data = result.data["orders"]["edges"];
        // print(data);
        List<Orders> orders =[];

        for(int i=0;i<data.length;i++)
        {
          orders.add(
            Orders(
              data[i]["node"]["id"], 
              data[i]["node"]["status"], 
              data[i]["node"]["product"]["id"],
              data[i]["node"]["product"]["parent"]["name"],
              data[i]["node"]["date"],
              data[i]["node"]["qty"],
              data[i]["node"]["size"],
              data[i]["node"]["color"],
              data[i]["node"]["mrp"],
              data[i]["node"]["price"],
              data[i]["node"]["discount"],
              data[i]["node"]["coupon"],
              data[i]["node"]["paymentMode"],
              // productimagesSet
              data[i]["node"]["product"]["productimagesSet"]["edges"].isNotEmpty
              ?data[i]["node"]["product"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
              // data[i]["node"]["product"]["parent"]["imageLink"].split(",")[0],

              data[i]["node"]["product"]["parent"]["seller"]["username"],
              )
          );
        }

      return orders;
      }
  }
}