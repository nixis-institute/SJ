import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';

class SubProductRepository{
  GraphQLClient _client = clientToQuery();  



  getSubProductByProductID(String id) async{
    dynamic sizes ={};
    dynamic colors ={};
    // print("V");
    // print(id);
    // List<SubProduct> subproduct=[];
    
      // GraphQLClient _client = clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(getProductByParentId),
          variables:{
            "id":id,
            },
            fetchPolicy: FetchPolicy.networkOnly
        )
      );

      // if(result.loading)
      // {
      //   loading = true;
      // }
      
      if(!result.hasException){

        List<SubProduct> l=[];

        var data = result.data["productByParentId"]["edges"];
        for(int i=0;i<data.length;i++)
        {
          List<ProductImage> im =[];
          
          for(int j=0;j<data[i]["node"]["productimagesSet"]["edges"].length;j++)
          {
            im.add(
              ProductImage(
              data[i]["node"]["productimagesSet"]["edges"][j]["node"]["id"],
              data[i]["node"]["productimagesSet"]["edges"][j]["node"]["largeImage"],
              data[i]["node"]["productimagesSet"]["edges"][j]["node"]["normalImage"],
              data[i]["node"]["productimagesSet"]["edges"][j]["node"]["thumbIimage"],
              )
            );
          }
          if(colors.length==0 && sizes.length==0){
            colors = { data[i]["node"]["color"]:[data[i]["node"]["size"]] };
            sizes ={ data[i]["node"]["size"] : [data[i]["node"]["color"]] };
          }
          else{
            colors.containsKey(data[i]["node"]["color"])
            ?colors[data[i]["node"]["color"]].add(data[i]["node"]["size"])
            :colors[data[i]["node"]["color"]] = [data[i]["node"]["size"]];

            // print(data[i]["node"]["size"]);
            // print(sizes);
            sizes.containsKey(data[i]["node"]["size"])
            ?sizes[data[i]["node"]["size"]].add(data[i]["node"]["color"])
            :sizes[data[i]["node"]["size"]] = [data[i]["node"]["color"]];
          }


          // colors.contains(data[i]["node"]["color"])?colors.add(data[i]["node"]["color"]):null;
          // sizes.contains(data[i]["node"]["size"])?colors.add(data[i]["node"]["size"]):null;

          l.add(
            SubProduct(data[i]["node"]["id"], 
            data[i]["node"]["listPrice"],
            data[i]["node"]["mrp"],
            data[i]["node"]["size"],
            data[i]["node"]["color"],
            data[i]["node"]["qty"],
            data[i]["node"]["cartProducts"]["edges"].length>0?true:false,
            im
            // isInCart: data[i]["node"]["cartProducts"]["edges"].length>0?true:false
            )
          );
        }
        return {"product":l,"size":sizes,"color":colors};
        // return l;

        // setState(() {

        //   subproduct = l;
        //   // cproduct = subproduct[0];
        //   cproduct = Product(subproduct[0].id, this.widget.pName, subproduct[0].listPrice, subproduct[0].mrp, subproduct[0].images, [subproduct[0].size], subproduct[0].images);
        //   // cproduct = Product(id, name, listPrice, mrp, images, sizes, imageLink,)
        //   loading = false;
        //   // cproduct.id = subproduct[0].id;
        //   // print(subproduct[0].color);
        //   prdId = subproduct[0].id;
        //   cproduct.images = subproduct[0].images;
        //   cproduct.isInCart = subproduct[0].isInCart;
        //   selectedSize = subproduct[0].size;
        //   selectedColor = subproduct[0].color;
        //   _id = cproduct.id;
        // });

        // print(sizes);
        // print(colors);

        // print("is in cart..."+cproduct.isInCart.toString());

      }
      
    }

  
  
}