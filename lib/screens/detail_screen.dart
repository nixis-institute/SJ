import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/widgets/App_bar.dart';

import 'cart/first_secreen.dart';

class DetailPage extends StatefulWidget{
  @override
  Product product;
  DetailPage({this.product});
  _DetailPageState createState() => _DetailPageState();

}
// class DetailProduct{
//   String id;
//   String name;
//   double listPrice;
//   double mrp;
//   List sizes;
//   bool isInCart;
//   List imageLink;
//   // bool isInCart;
//   List<ProductImage> images;
//   DetailProduct(this.id,this.name,this.listPrice,this.mrp,this.images,this.sizes,this.imageLink);
// }

class SubProduct{
  String id;
  double listPrice;
  double mrp;
  int qty;
  String size,color;
  bool isInCart;
  List<ProductImage> images;
  SubProduct(this.id,this.listPrice,this.mrp,this.size,this.color,this.qty,this.isInCart,this.images);

}

class _DetailPageState extends State<DetailPage>
{
  List<SubProduct> subproduct=[];
  void getSubProduct() async{
    print(this.widget.product.id);
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getProductByParentId),
        variables:{
          "id":this.widget.product.id,

          }
      )
    );

    if(result.loading)
    {
      loading = true;
    }
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

      setState(() {

        subproduct = l;
        loading = false;
        this.widget.product.id = subproduct[0].id;
        prdId = subproduct[0].id;
        this.widget.product.isInCart = subproduct[0].isInCart;
        // this.widget.product = subproduct[0];
        selectedSize = subproduct[0].size;
        _id = this.widget.product.id;
      });

    }

  }
  void AddToCart() async{
    // print("addtocart");
  // print(this.widget.product.id);

    SharedPreferences preferences = await SharedPreferences.getInstance();    
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(UpdateInCart),
        variables:{
          "prdID":prdId,
          "qty":qty,
          "size":selectedSize,
          "userId":userID,
          'isNew':true
          }
      )
    );
    setState(() {
      cloading = true;
    });

    // if(result.loading)
    // {
    //   print("loading...");
    //   setState(() {
    //     cloading = true;
    //   });
    // }
    
    if(!result.hasException)
    {
      var data = result.data["updateCart"];
      if(data["success"] == true)
      {
        setState(() {
        cloading = false;
        isInCart = true;  
        // _count += ;
          this.widget.product.isInCart=true;
          // size_index
          subproduct[size_index].isInCart = true;
        _count = (int.parse(_count)+1).toString(); 
        });
        // await preferences.setString("key", value)
        preferences.setString("cartCount", _count);
        // preferences.setString("cartCount", (int.parse(_count)).toString());
      }
    }

  }
  
  void Empty()
  {

  }
  void XX() async
  {
    // print("print__");
    // print(_id);
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(CartCartByID),
        variables:{
          "id":_id
          }
      )
    );
    if(result.loading)
    {
      setState(() {
        isLoading = true;
      });
    }
    // print("sdlkfjkdlsf");
    // print(result.hasException.toString());

    if(!result.hasException)
    {
      // print(result.data["cartProduct"]);
      if(result.data["cartProduct"] !=null)
      {
        setState(() {
          isInCart = true;
        });
      }else{
        setState(() {
          isInCart = false;
        });        
      }
    }

  }



  var selectedSize = "";
  var size_index =0;
  bool isLoading = true;
  bool loading = true;
  var selectedColor = '0xffb74093';
  var qty = 1;
  var picheight = 300.0;  
  var _count = "";
  var cloading = false;
  String _id;
  String userID;
  String prdId;

  
  @override
  bool isInCart = false; 
  void initState()
  {
    super.initState();

    getCartCount().then((c){
      setState(() {
      _count = c;
      });
    });

    getUserId().then((c){
      setState(() {
      userID = c;
      });
    });
    
    getSubProduct();
    // XX();
  }

  // selectSize(widget.product.sizes[0]);

  Widget build(BuildContext context)
  {
  getCartCount().then((c){
    setState(() {
      _count = c;
      });
    });

    // print(_count);
    // print(isInCart);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,      
            statusBarBrightness:Brightness.dark  
      ),
          child: Scaffold(
        // appBar: AppBar(backgroundColor: Colors.white,),

        bottomNavigationBar: BottomAppBar(
          child: 
          
          
          InkWell(
            onTap: ()=> cloading?this.Empty():!this.widget.product.isInCart?this.AddToCart():this.Empty(),
            // isInCart?
              // onTap: (){
              //   isInCart?
              //   this.AddToCart():

              //   ;
              // },


              child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  // isInCart==true?Text("Carted"):
                  
                  cloading?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)):
                  Text(

                    // isInCart
                    this.widget.product.isInCart
                    ==true?"Check in Cart":
                    
                    "ADD TO CART",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ),
          color: this.widget.product.isInCart|cloading==true?Colors.grey:
          Colors.green,
          
        ),
        // appBar: AppBar(title: Text("Details"),),
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // textTheme: TextTheme(color:Colors.black),
          iconTheme: IconThemeData(color:Colors.black),
          // title: Text(this.widget.product.name,style: TextStyle(color:Colors.black),),
          // backgroundColor: Colors.green,
          
          
          actions: <Widget>[
              // IconButton(
              //   icon: Icon(Icons.notifications),
              //   iconSize: 30,
              //   // color: Colors.white,
              //   onPressed: (){},
              // ),

              Stack(
                  children:<Widget>[
                    IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    iconSize: 30,
                    // color: Colors.white,
                    
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
                      )));
                    },
                ),
                Positioned(
                  top: 1,
                  left: 20,
                  child: Container(
                    height: 20,
                    width: 20,
                    // color: Colors.red,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(_count,
                    style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]
            ),



              // IconButton(
              //   icon: Icon(Icons.more_vert),
              //   iconSize: 30,
              //   // color: Colors.white,
              //   onPressed: (){},
              // )
          ],
        ),
        
        
        body: loading?Center(child: CircularProgressIndicator(),):
        ListView(
            children: <Widget>[
              // CustomAppBar(name: this.widget.category.name),
              // CustomAppBar(name:"Detail"),
              GestureDetector(
                  onTap: (){
                    ChangeHeight();
                  },
                  child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: picheight,
                  child: CachedNetworkImage(
                    height: 230,
                    imageUrl: 
                    server_url+"/media/"+widget.product.images[0].normalImage.toString(),
                    // widget.product.imageLink[0].toString(),
                    
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                    // placeholder: (context, url) => Container(height: 20,child:Container(child: CircularProgressIndicator(value: 0.2,))),
                    // errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // child: Image.network(
                  //   widget.product.imageLink[0]
                  // )
                  // Image.network(
                  //   server_url+"/media/"+widget.product.images[0].imgUrl,
                  //   fit:BoxFit.cover,
                  //   alignment: Alignment.topCenter,
                  //   )
                  // Image.asset(
                  //   widget.product.images[0].imgUrl,
                  //   fit:BoxFit.cover,
                  //   alignment: Alignment.topCenter,
                  //   )



                ),
              ),

              Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  children: <Widget>[


                    Padding(
                      padding: const EdgeInsets.only(top:20,bottom: 20),
                      // padding: const EdgeInsets.all(0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: Colors.green
                        ),
                        child: Row(
                          // spacing: ,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            
                            Expanded(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Text("sdfdsf",textAlign: ),
                                  Text(
                                      widget.product.name,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.left, 
                                      style: TextStyle(fontSize: 23,fontWeight: FontWeight.w800,),
                                    ),
                                  // Text("Exclusive Jacket"),
                                  SizedBox(height:10,),
                                  
                                  Padding(
                                    padding: const EdgeInsets.only(left:0),
                                    child: Row(
                                      children: <Widget>[
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            Text(widget.product.listPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            SizedBox(width: 10,),
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
                                            Text(widget.product.mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
                                            SizedBox(width: 6,),
                                            
                                            // double d = widget.product.mrp;
                                            Text(
                                                "("+
                                              ((widget.product.mrp - widget.product.listPrice)*100 / widget.product.mrp ).toInt().toString()
                                                +"% off)",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                                ),
                                            )
                                            // Text("("+widget.product[index].discount.toInt().toString()+"% off)",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.red),)
                                          
                                        

                                      ],
                                    ),
                                  )


                                ],
                              ),
                            ),
                            // Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: <Widget>[
                            //       Column(
                            //         children: <Widget>[
                            //           Icon(Icons.favorite,color: Colors.red,size: 30,),
                            //           Text("450 Likes",style:TextStyle(fontSize: 10,color: Colors.grey),)
                            //         ],
                            //       ),
                            //       SizedBox(width: 10,),
                            //       Icon(Icons.bookmark,color: Colors.black12,size: 30,)
                            //     ],
                            // )
        
                          ],
                        ),
                      ),
                    
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text("Select a Size",textAlign: TextAlign.left,style: TextStyle(fontWeight:FontWeight.w700),),
                            SizedBox(height: 10,),
                            Container(
                              // width: 300,
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              // color: Colors.black,
                              
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: subproduct.length,

                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,int index){                                
                                    return Padding(
                                      padding: const EdgeInsets.only(right:10),
                                      child: _size(subproduct[index].size, true,subproduct[index],index),
                                    );
                                },
                              ),
                            ),
                            
                          

                        ],
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top:10,bottom:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Color",style: TextStyle(fontWeight:FontWeight.w700)),
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                _color("0xffb74093", false),
                                SizedBox(width: 10,),
                                _color("0xffaabbcc", true),
                                SizedBox(width: 10,),
                                _color("0xffa26676", false),
                                SizedBox(width: 10,)                                                            
                            ],
                          )
                        ],
                      ),
                    ),

                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10,bottom:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Quantity",style:TextStyle(fontWeight:FontWeight.w700),),
                          Row(
                            children: <Widget>[
                              InkWell(
                                  onTap: (){
                                    // AddQty();
                                    RemoveQty();
                                  },
                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200]
                                  ),
                                  child: Icon(Icons.remove,color: Colors.grey, )
                                  ),
                              ),

                              SizedBox(width: 15,),
                              Text( "$qty",
                              style: TextStyle(fontSize: 20),),
                              
                              SizedBox(width: 15,),

                              InkWell(
                                onTap: (){
                                  AddQty();
                                },
                                child: Container(
                                decoration: BoxDecoration(
                                color: Colors.grey[200]
                                ),
                                  child: Icon(Icons.add,color: Colors.grey,)
                                  ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )




                  ],
                ),
              )

            ],
        ),
      ),
    );
  }






  Widget _size(String size,bool selected,SubProduct product,int index){
    return InkWell(
          onTap: (){
            setState(() {
              // this.widget.product.sizes[0] = product.size;
              // this.widget.product.colors[0] = product.color;

              // this.widget.product = product.color;
              
              // print(product.isInCart);
              size_index = index;
              this.widget.product.listPrice =  product.listPrice;
              this.widget.product.mrp =  product.mrp;
              this.widget.product.isInCart = product.isInCart;
              this.widget.product.images = product.images;
              prdId = product.id;
            });
            selectSize(size);
          },
          child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: 35,
          width: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color:selectedSize == size?
            Colors.blue:Colors.grey[300],
            border: Border.all(color: Colors.grey,width: 0.3,),
          ),
          child: Text(
            size,style: TextStyle(
              color: selectedSize == size
              ?Colors.white
              :Colors.grey
              ),),
        ),
    );
  }



  Widget _color(String colors,bool selected){
      return InkWell(
          onTap: (){
            selectColor(colors);
          },
            child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color:Color(int.parse(colors)),
              border: Border.all(
                color: Colors.grey[200],
                width: selectedColor == colors
                ?4
                :0.2
                )
            ),
          ),
      );
  }



  selectColor(color){
    setState(() {
      selectedColor = color;
    });
  }


  selectSize(size) {
    setState(() {
      selectedSize = size;
    });
  }

  AddQty() {
    setState(() {
      qty++;
    });
  }
  ChangeHeight() {
    setState(() {
      if (picheight>300)
        picheight = picheight - 300;
      else
      picheight = picheight + 300;
    });
  }

  RemoveQty() {
    setState(() {
      qty>1?
      qty--:
      qty
      ;
    });
  }
}



                          // _size("S",false),
                          // SizedBox(width:10),
                          // _size("M",false),
                          // SizedBox(width:10),
                          // _size("L",true),
                          // SizedBox(width:10),
                          // _size("XL",false),
                          // SizedBox(width:10),
                          // _size("XLL",false),
                          // SizedBox(width:10),
                          // _size("3XL",false),