final String Categories = """ 
{
  allCategory{
    edges{
      node{
        id
        name
        image
      }
    }
  }
}
""";




final String GetSubCategoryByCategoryId = """ 
query GetSubCateogry(\$CateogryId:ID!){
  subcateogryByCategoryId(mainCategoryId:\$CateogryId)
  {
    edges{
      node
      {
        id
        name
      }
    }
  }
}
""";


final String GetSubListAndProductBySubCateogryIdAfter = """ 
query GetSubList(\$SubCateogryId:ID!,\$after:String!){
  sublistBySubcategoryId(subCategoryId:\$SubCateogryId)
  {
    edges{
      node
      {
        id
        name
        productSet(first:5,after:\$after){
          edges{
            node{
              id
              name
            	listPrice
              mrp
              sizes
              colors
              imageLink
              productimagesSet{
                edges{
                  node{
                    id
                    image
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

""";


final String GetSubListAndProductBySubCateogryId = """ 
query GetSubList(\$SubCateogryId:ID!){
  sublistBySubcategoryId(subCategoryId:\$SubCateogryId)
  {
    edges{
      node
      {
        id
        name
        productSet(first:5){
          edges{
            node{
              id
              name
            	listPrice
              mrp
              sizes
              colors
              imageLink
              productimagesSet{
                edges{
                  node{
                    id
                    image
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

""";

final String GetSubListBySubCategoryId = """ 
query GetSubList(\$SubCateogryId:ID!){
  sublistBySubcategoryId(subCategoryId:\$SubCateogryId)
  {
    edges{
      node
      {
        id
        name
      }
    }
  }
}
""";

final String GetProductBySubListId = """ 
query GetSubList(\$SubListId:ID!){
  productBySublistId(sublistId:\$SubListId)
  {
    edges{
      node
      {
        id
        name
      }
    }
  }
}
""";

