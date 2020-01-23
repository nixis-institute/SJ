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

