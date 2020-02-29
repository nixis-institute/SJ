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
final String createUser = """

mutation create(\$user:String!,\$email:String!,\$password:String!){
  createUser(username:\$user,email:\$email,password:\$password){
    user{
      id
      username
    }
  }
}


""";

final String isUserExisted = """
query existed(\$username:String!)
{
  isUserExisted(username:\$username)
  {
    id
    username
  }  
}
""";

final String updateUser ="""
mutation xbv(\$id:ID!,\$firstName:String!,\$lname:String!,\$phone:String!,\$gender:String!,\$email:String!)
{
  updateUser(firstName:\$firstName,lastName:\$lname,phone:\$phone,gender:\$gender,email:\$email,id:\$id)
  {
    user{
    id
    username
    firstName
    lastName
    email
    profile{
      gender
      phoneNumber
    }
    addressSet{
      edges{
        node{
          id
          houseNo
          colony
          personName
          landmark
          city
          state
          personName
          phoneNumber
          alternateNumber
        }
      }
    }     
    }
  }
}


""";

final String changeUserPassword = """
mutation abc(\$id:ID!,\$old:String!,\$new:String!){
  changePassword(id:\$id,newPassword:\$new,oldPassword:\$old)
  {
    user{
      id
      username
    }
  }
}
""";


final String searchCategoryQuery = """
query xyz(\$match:String!){
	searchCategory(match:\$match){
    id
    name
    subCategory{
      id
      name
      mainCategory{
        id
        name
      }
    }
  }
}

""";


final String searchProductQuery = """
query xyz(\$match:String!){
  searchResult(match:\$match)
  {
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

""";

final String getUser = """
query GetUser(\$id:Int!){
  user(userId:\$id)
  {
    id
    username
    firstName
    lastName
    email
    profile{
      gender
      phoneNumber
    }
    addressSet{
      edges{
        node{
          id
          houseNo
          colony
          personName
          landmark
          city
          state
          personName
          phoneNumber
          alternateNumber
        }
      }
    }
  }
}
""";


final String GetSubListById = """
query xyz(\$Id:ID!,\$after:String!)
{
  sublistById(id:\$Id)
  {
    id
    name
    productSet(first:10,after:\$after){
      pageInfo{
        endCursor
      }
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

""";

final String GetSubListAndProductBySubCateogryIdAfter = """ 
query GetSubList(\$SubCateogryId:ID!,\$after:String!){
  sublistBySubcategoryId(subCategoryId:\$SubCateogryId)
  {
  pageInfo{
      endCursor
    }    
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
  pageInfo{
      endCursor
    }
    edges{
      node
      {
        id
        name
        productSet(first:5){
          pageInfo{
            endCursor
          }
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
query xyz(\$SubListId:ID!){
productBySublistId(sublistId:\$SubListId)
  {
    edges{
      node
      {
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
""";

