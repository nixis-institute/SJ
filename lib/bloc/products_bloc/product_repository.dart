import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/productAndCat.dart';

class ProductRepository{
  GraphQLClient _client = clientToQuery();
  

  fetchProductAfterCursor(id,after,brand,sizes,colors,ordering) async{
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getProductBySublistIdQuery),
        variables: {
          "sublistId":id,
          "after":after,
          "brand":brand,
          "ordering":ordering,
          "color":colors,
          "sizes":sizes
        },
        fetchPolicy: FetchPolicy.networkOnly
      )
      
    );
    if(!result.hasException){
      List data = result.data["sublistById"]["productSet"]["edges"];
      TypeAndProduct tprd;
      List<Product> prd = [];

      data.forEach((product) {
        List<ProductImage> img=[];
          product["node"]["productimagesSet"]["edges"].forEach((im){
            img.add(
              ProductImage(
                im["node"]["id"], 
                im["node"]["largeImage"], 
                im["node"]["normalImage"], 
                im["node"]["thumbnailImage"]
                )
            );
          });

        prd.add(
          Product(
            product["node"]["id"], 
            product["node"]["name"], 
            product["node"]["listPrice"], 
            product["node"]["mrp"], 
            img, 
            [], 
            []
          )
        );
      });

      tprd = TypeAndProduct(
        result.data["sublistById"]["id"], 
        result.data["sublistById"]["name"], 
        prd, 
        result.data["sublistById"]["productSet"]["pageInfo"]["endCursor"], 
        result.data["sublistById"]["productSet"]["pageInfo"]["hasNextPage"]
      );
      return tprd;
    }
  }

  getSubListAndProductBySubCateogryId(id,brand,sizes,colors,ordering) async
  {
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getSubListAndProductBySubCateogryIdQuery),
        variables:{
          "SubCateogryId":id,
          "brand":brand??"",
          "sizes":sizes??"",
          "color":colors??"",
          "ordering":ordering
          },
          // fetchPolicy: FetchPolicy.networkOnly
      )
    );
    // print(result.exception.toString());

      if(!result.hasException)
      {
        // print("--99--");
        List<TypeAndProduct> _prd = [];
        List<Product> product = [];
        List data = result.data["sublistBySubcategoryId"]["edges"];
        
        data.forEach((category) {
          if(category["node"]["productSet"]["edges"].isNotEmpty)
          {
            var cat  = category["node"]["productSet"]["edges"];
            cat.forEach((prd){
              List<ProductImage> img=[];
              prd["node"]["productimagesSet"]["edges"].forEach((im){
                img.add(
                  ProductImage(
                    im["node"]["id"], 
                    im["node"]["largeImage"], 
                    im["node"]["normalImage"], 
                    im["node"]["thumbnailImage"]
                    )
                );
              });
              

              product.add(
                Product(
                  prd["node"]["id"], 
                  prd["node"]["name"], 
                  prd["node"]["listPrice"], 
                  prd["node"]["mrp"], 
                  img ,
                  [], 
                  []
                )
              );
            });

            _prd.add(
              TypeAndProduct(
                category["node"]["id"], 
                category["node"]["name"], 
                product, 
                category["node"]["productSet"]["pageInfo"]["endCursor"], 
                category["node"]["productSet"]["pageInfo"]["hasNextPage"]
                )
            );
            product = [];
          }
        });
        return _prd;
      }
  }
}