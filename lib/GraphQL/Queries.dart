final String Categories = """ 
{
  allCategory{
    edges{
      node{
        id
        name
        image
        productsliderSet{
          edges{
            node{
              image
            }
          }
        }        
        subcategorySet{
          edges{
            node{
              id
              name
            }
          }
        }        
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

final updateOrdersQuery ="""
mutation x(\$addressId:ID!,\$mode:String!)
{
  updateOrders(addressId:\$addressId,paymentMode:\$mode)
  {
    success
  }
}

""";

final getOrderQuery = """
  query x(\$orderId:ID!)
  {
    getOrder(id:\$orderId){
      address{
        id
        houseNo
        colony
        landmark
        city
        state
        pinCode
        personName
        phoneNumber
        alternateNumber
      }
    }
  }
""";

final currentUserQuery ="""
query{
  user{
    id
    firstName
    lastName
    username
    cartSet{
      edges{
        node{
          id
        }
      }
    }
  }
}
""";

final getOrdersQuery ="""
query {
  orders
  {
    edges{
      node{
        id
        size
        price
        paymentMode				
        date
        qty
        color
        mrp
        discount
        coupon
        status
        product{
          id
          productimagesSet{
            edges{
              node{
                thumbnailImage
              }
            }
          }
          parent{
            name
            imageLink
            seller{
              id
              username
            }
          }
        } 
      }
    }
  }
}
""";


final getAddress ="""
query x{
  user{
    addressSet {
      edges {
        node {
          id
          houseNo
          colony
          city
          landmark
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

final addAddressQuery ="""
mutation ax(\$user:Int!,\$house_no:String!,\$colony:String!,\$landmark:String!,\$city:String!,\$state:String!,\$person_name:String!,\$phone_number:String!,\$alternate_number:String!)
{
 addAddress(
  user:\$user, 
  houseNo:\$house_no,
  alternateNumber:\$alternate_number,
  city:\$city,
  colony:\$colony,
  landmark:\$landmark,
  state:\$state,
  personName:\$person_name,
  phoneNumber:\$phone_number
  )
  {
  success 
  address{
    id
    houseNo
    colony
    landmark
    city
    state
    personName
    phoneNumber
    alternateNumber
  }  
  }

}
""";


final deleteAddressQuery = """
mutation x(\$id:ID!)
{
  deleteAddress(id:\$id)
  {
    success
  }
}

""";

final updateAddressQuery = """
mutation ax(\$id:ID!,\$house_no:String!,\$colony:String!,\$landmark:String!,\$city:String!,\$state:String!,\$person_name:String!,\$phone_number:String!,\$alternate_number:String!)
{
 updateAddress(
  id:\$id, 
  houseNo:\$house_no,
  alternateNumber:\$alternate_number,
  city:\$city,
  colony:\$colony,
  landmark:\$landmark,
  state:\$state,
  personName:\$person_name,
  phoneNumber:\$phone_number
  )
  {
  success 
  address{
    id
    houseNo
    colony
    landmark
    city
    state
    personName
    phoneNumber
    alternateNumber
  }  
  }
}
""";


// {
  // "user": 1,
  // "house_no": "l-453 Block j",
  // "colony": "Jahangir puri",
  // "landmark": "Hospital",
  // "city": "Delhi",
  // "state": "Delhi",
  // "person_name": "Amit",
  // "phone_number": "9898",
  // "alternate_number": "9384"
// }

final UpdateInCart = """
mutation(\$prdID:ID!,\$qty:Int!,\$size:String!,\$color:String!,\$isNew:Boolean!){
  updateCart(prdId:\$prdID,qty:\$qty,size:\$size,color:\$color,isNew:\$isNew)
  {
    success
  }
}
""";
final CartCartByID = """
query getP(\$id:ID!){
	cartProduct(id:\$id)
  {
    id
  }
}
""";

String getTokenQuery ="""
mutation x(\$username:String!,\$password:String!){
  tokenAuth(username:\$username,password:\$password){
    token
  }
}
""";

final CartProductsQuery ="""
query {
  cartProducts{
    edges{
      node{
        id
        size
        qty
        cartProducts{
          id
          parent{
            name
          }          
					productimagesSet{
            edges{
              node{
                thumbnailImage
              }
            }
          }
          mrp
          listPrice
        }
      }
    }
  }
}

""";

final String searchCategoryQuery = """
query xyz(\$match:String!){
	searchCategory(match:\$match){
    id
    name
    productSet{
      edges{
        node{
          id
        }
      }
    }    
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
query xyz(\$match: String!) {
  searchResult(match: \$match) {
    id
    name
    brand
    subproductSet {
      edges {
        node {
          id
          listPrice
          size
          mrp
          color
        }
      }
    }
    productimagesSet(first:1) {
      edges {
        node {
          id
          largeImage
          normalImage
          thumbnailImage
        }
      }
    }
  }
}

""";

final String getFilterQuery ="""
query x(\$id:ID!){
  filterById(id:\$id)
  {
    brand
    subproductSet{
      edges{
        node{
          size
          color
        }
      }
    }
  }
}
""";


final String getUser = """
query GetUser(){
  user
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
        hasNextPage
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
                largeImage
                normalImage
                thumbnailImage
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
        productSet(first:6,after:\$after){
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
                    largeImage
                    normalImage
                    thumbnailImage
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
query GetSubList(\$SubCateogryId:ID!,\$brand: String!, \$sizes: String!){
  sublistBySubcategoryId(subCategoryId:\$SubCateogryId)
  {
  pageInfo{
      endCursor
      hasNextPage
    }
    edges{
      node
      {
        id
        name
        productSet(first:6,brand_In: \$brand,){
          pageInfo{
            endCursor
            hasNextPage
          }
          edges{
            node{
              id
              name
              brand
              imageLink
              subproductSet(size_In:\$sizes){
                edges{
                  node{
                    id
                    listPrice
                    size
                    mrp
                    color
                  }
                }
              }
              productimagesSet{
                edges{
                  node{
                    id
                    largeImage
                    normalImage
                    thumbnailImage
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

final String getProductByParentId ="""
query x(\$id:ID!){
  productByParentId(id:\$id)
  {
    edges{
      node{
        id
        listPrice
        mrp
        size
        color
        qty
        productimagesSet{
          edges{
            node{
              id
              largeImage
              normalImage
              thumbnailImage
            }
          }
        }        
        cartProducts{
          edges{
            node{
              id
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

final String getMoreProductBySubListId="""
query x(\$sublistId: ID!, \$after: String!, \$brand: String!, \$sizes: String!) {
  sublistById(id: \$sublistId) {
    name
    productSet(first: 6, after: \$after, brand_In: \$brand) {
      pageInfo {
        endCursor
        hasNextPage
      }
      edges {
        node {
          id
          name
          brand
          imageLink
          subproductSet(size_In: \$sizes) {
            edges {
              node {
                id
                listPrice
                size
                mrp
                color
              }
            }
          }
          productimagesSet {
            edges {
              node {
                id
                largeImage
                normalImage
                thumbnailImage
              }
            }
          }
        }
      }
    }
  }
}

""";

final String GetProductBySubListId = """ 
query xyz(\$SubListId:ID!){
productBySublistId(sublistId:\$SubListId)
  {
      edges {
        node {
          id
          name
          brand
          imageLink
          subproductSet{
            edges {
              node {
                id
                listPrice
                size
                mrp
                color
              }
            }
          }
          productimagesSet {
            edges {
              node {
                id
                largeImage
                normalImage
                thumbnailImage
              }
            }
          }
        }
      }
  }
}
""";

