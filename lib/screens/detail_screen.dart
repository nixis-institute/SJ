import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:color/color.dart';
// import 'package:complimentary_colors/complimentary_colors.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/productAndCat.dart';
import 'package:shopping_junction/widgets/App_bar.dart';

import 'cart/first_secreen.dart';

class DetailPage extends StatefulWidget{
  @override
  // final Product product;
  final String pId,pName;
  DetailPage(this.pId,this.pName);

  _DetailPageState createState() => _DetailPageState();
}



class _DetailPageState extends State<DetailPage>
{
  dynamic sizes ={};
  dynamic colors ={};
  List<SubProduct> subproduct=[];
  void getSubProduct() async{
    // print(this.widget.pId);
    // cproduct = this.widget.product; 
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getProductByParentId),
        variables:{
          "id":this.widget.pId,
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

      setState(() {

        subproduct = l;
        // cproduct = subproduct[0];
        cproduct = Product(subproduct[0].id, this.widget.pName, subproduct[0].listPrice, subproduct[0].mrp, subproduct[0].images, [subproduct[0].size], subproduct[0].images);
        // cproduct = Product(id, name, listPrice, mrp, images, sizes, imageLink,)
        loading = false;
        // cproduct.id = subproduct[0].id;
        // print(subproduct[0].color);
        prdId = subproduct[0].id;
        cproduct.images = subproduct[0].images;
        cproduct.isInCart = subproduct[0].isInCart;
        selectedSize = subproduct[0].size;
        selectedColor = subproduct[0].color;
        _id = cproduct.id;
      });

      // print(sizes);
      // print(colors);

      // print("is in cart..."+cproduct.isInCart.toString());

    }

  }
  void AddToCart1() async{
    print(prdId);
    print(qty);
    print(selectedSize);
    print(selectedColor);


  } 
  void AddToCart() async{
    // print("addtocart");
  // print(this.widget.product.id);
    setState(() {
      cloading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();    
    GraphQLClient _client = clientToQuery();
    // print(prdId);
    // print(qty);
    // print(selectedSize);
    // print(userID);

    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(UpdateInCart),
        variables:{
          "prdID":prdId,
          "qty":qty,
          "size":selectedSize,
          "color":selectedColor,
          // "userId":userID,
          'isNew':true
          }
      )
    );


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
          cproduct.isInCart=true;
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

  // void mapData(){
  //   cproduct.id = this.widget.product.id;
  //   cproduct.mrp = this.widget.product.mrp;
  //   cproduct.listPrice = this.widget.product.listPrice;
  //   cproduct.images = this.widget.product.images;
  //   cproduct.isInCart = this.widget.product.isInCart;
  // }

  var selectedSize = "";
  var size_index =0;
  bool isLoading = true;
  bool loading = true;
  var selectedColor;
  var qty = 1;
  var picheight = 300.0;  
  var _count = "";
  var cloading = false;
  String _id;
  String userID;
  String prdId;
  
  
  @override
  bool isInCart = false; 
  Product cproduct;

  void initState()
  {
    // this.widget.product.id="";
    super.initState();
    // mapData();
    // print("prdId..."+this.widget.pId);
    // cproduct.id = this.widget.pId??"";
    // cproduct.name = this.widget.pName??"";

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
    
    // print(this.widget.pId);
    getSubProduct();
    // XX();
  }

  // selectSize(widget.product.sizes[0]);

  Widget build(BuildContext context)
  {
  // print(this.widget.product.listPrice);
  // getCartCount().then((c){
  //   setState(() {
  //     _count = c;
  //     });
  //   });

    // print(_count);
    // print(isInCart);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarBrightness:Brightness.dark
      ),
          child: Scaffold(
        // appBar: AppBar(backgroundColor: Colors.white,),

        bottomNavigationBar: 
        !loading?
        BottomAppBar(
          child: 
          
          
          InkWell(
            onTap: ()=> cloading?this.Empty():!cproduct.isInCart?this.AddToCart():this.Empty(),
            // isInCart?
              // onTap: (){
              //   isInCart?
              //   this.AddToCart():

              //   ;
              // },


              child: Container(
              height: 50,
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  // isInCart==true?Text("Carted"):
                  
                  cloading?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)):
                  Text(

                    // isInCart
                    cproduct.isInCart
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
          color: cproduct.isInCart|cloading==true?Colors.grey:
          Colors.green,
          
        ):null,
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
        
        
        body: 
        loading?
        Center(child: CircularProgressIndicator()):
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
                  // height: picheight,
                  child: 
                  cproduct.images.isEmpty
                  ?Container(
                    height:400,
                    alignment: Alignment.center,
                    child: Text("Image Not Upload",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:Colors.grey,
                        fontSize: 18
                      ),
                      ),
                    )
                  :
                  CarouselSlider(
                    // enlargeCenterPage: true,
                    height: 400,
                    aspectRatio: 16/9,
                    autoPlay: false,
                    viewportFraction: 1.0,
                    items : cproduct.images.map((f){
                      return 
                      // CachedNetworkImage(
                      //   height:230,
                      //   imageUrl: server_url+"/media/"+f.normalImage.toString(),
                      //     fit: BoxFit.fitWidth,
                      //     alignment: Alignment.topCenter,
                      //     placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                      // );

                        Container(
                          color:Colors.red,
                          child: CachedNetworkImage(
                          // height: 100,
                          imageUrl: 
                          server_url+"/media/"+f.normalImage.toString(),
                          // widget.product.imageLink[0].toString(),
                          
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                      ),
                        );                        
                      
                    }).toList()
                  )

                  // :CachedNetworkImage(
                  //   height: 230,
                  //   imageUrl: 
                  //   server_url+"/media/"+cproduct.images[0].normalImage.toString(),
                  //   // widget.product.imageLink[0].toString(),
                    
                  //   fit: BoxFit.cover,
                  //   alignment: Alignment.topCenter,
                  //   placeholder: (context, url) =>Center(child: CircularProgressIndicator()),
                  // ),


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
                                      cproduct.name,
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
                                            Text(cproduct.listPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            SizedBox(width: 10,),
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
                                            Text(cproduct.mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
                                            SizedBox(width: 6,),
                                            
                                            // double d = cproduct.mrp;
                                            Text(
                                                "("+
                                              ((cproduct.mrp - cproduct.listPrice)*100 / cproduct.mrp ).toInt().toString()
                                                +"% off)",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                                ),
                                            )
                                            // Text("("+cproduct[index].discount.toInt().toString()+"% off)",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.red),)
                                          
                                        

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
                    
                    // loading?Center(child: CircularProgressIndicator(),):
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text("Select a Size",textAlign: TextAlign.left,style: TextStyle(fontWeight:FontWeight.w700),),
                            SizedBox(height: 10,),
                            loading?Center(child: CircularProgressIndicator(),):
                            Container(
                              // width: 300,
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              // color: Colors.black,
                              
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: sizes.length,

                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,int index){                                
                                    return Padding(
                                      padding: const EdgeInsets.only(right:10),
                                      child: _size(
                                        sizes.keys.toList()[index],index
                                        ),
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
                          loading?Center(child: CircularProgressIndicator(),):
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: <Widget>[
                          //       _color("0xffb74093", false),
                          //       SizedBox(width: 10,),
                          //       _color("0xffaabbcc", true),
                          //       SizedBox(width: 10,),
                          //       _color("0xffa26676", false),
                          //       SizedBox(width: 10,)                                                            
                          //   ],
                          // )
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            // color:Colors.red,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: sizes[selectedSize].length,
                              itemBuilder:(context,index){
                                // return Text("S");
                                return Container(
                                  margin: EdgeInsets.only(right:10),
                                  child: _color(
                                    sizes[selectedSize][index].replaceAll("#","0xff"), false)
                                    // colors.keys.toList()[index].replaceAll("#","0xff"), false)
                                  
                                );
                              }
                              ),
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






  Widget _size(String size,int index){
    return InkWell(
          onTap: (){
              selectedSize = size;
              size_index = index;
              // cproduct.listPrice =  product.listPrice;
              // cproduct.mrp =  product.mrp;
              // cproduct.isInCart = product.isInCart;
              // cproduct.images = product.images;
              // prdId = product.id;

            // setState(() {
            //   // this.cproduct.sizes[0] = product.size;
            //   // this.cproduct.colors[0] = product.color;

            //   // this.cproduct = product.color;
              
            //   // print(product.isInCart);
            //   // this.widget.product;
            //   size_index = index;
            //   cproduct.listPrice =  product.listPrice;
            //   cproduct.mrp =  product.mrp;
            //   cproduct.isInCart = product.isInCart;
            //   cproduct.images = product.images;
            //   prdId = product.id;
            // });
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
      // var givenHexColor = HexColor('FF0000');

      // CalculateComplimentaryColor.fromHex(colors);
      // print(colors+"--");

      // print(selectedColor);
      return InkWell(
          onTap: (){
            selectColor(colors.replaceAll("0xff", "#"));
          },
            child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color:Color(int.parse(colors)),
              // color:Colors.black,
              border: Border.all(
                color: Colors.black,
                width: selectedColor == colors.replaceAll("0xff", "#")
                ?0.2
                :0.2
                )
            ),
            child: selectedColor == colors.replaceAll("0xff", "#")?Icon(
              Icons.check_circle,
              color: Colors.white,
              ):null,
          ),
      );
  }



  selectColor(color){
    // List<SubProduct> p = subproduct.where((e) => e.color == color && e.size == selectedSize: e).toList();
    SubProduct p;
    
    setState(() {      
      selectedColor = color;
    });
    // print(selectedColor);
    // print(selectedSize);

      subproduct.forEach((product) {
        // print(product.color);
        if(product.size == selectedSize && product.color == selectedColor.replaceAll("0xff", "#")){
          p = product;
        }
     });
    //  print(p.listPrice);
    //  print(p.mrp);
    //  print(p.isInCart);
    //  print(p.images);
    setState(() {
        cproduct.listPrice =  p.listPrice;
        cproduct.mrp =  p.mrp;
        cproduct.isInCart = p.isInCart;
        cproduct.images = p.images;
        prdId = p.id;
    });
    //  print(p);
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