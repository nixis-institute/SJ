import 'package:flutter/material.dart';
import 'package:shopping_junction/models/products.dart';

class DetailPage extends StatefulWidget{
  @override
  final Product product;
  DetailPage({this.product});
  // this.product.sizes[0]
  _DetailPageState createState() => _DetailPageState();
}



  // selectCard(size) {
  //   setState(() {
  //     selectedSize = size;
  //   });
  // }

// Widget _size(String size,bool selected){
//     return InkWell(
//           onTap: (){
//             selectCard(size);
//           },
//           child: Container(
//           height: 35,
//           width: 35,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//             color: selected? Colors.blue:Colors.grey[300],
//             border: Border.all(color: Colors.grey,width: 0.2)
//           ),
//           child: Text(size,style: TextStyle(color: selected?Colors.white:Colors.grey),),
//         ),
//     );
// }

// Widget _color(String colors,bool selected){
//     return Container(
//         height: 35,
//         width: 35,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(30)),
//           // color: selected? Colors.blue:Colors.grey[300],
//           color:Color(int.parse(colors)),

//           border: Border.all(
//             color: Colors.grey[200],
//             width: selected?4:0.2
            
//             )
//         ),
//         // child: Text(size,style: TextStyle(color: selected?Colors.white:Colors.grey),),
//       );
// }




class _DetailPageState extends State<DetailPage>
{
  // var selectedSize = 'S';  //it works fine


  var selectedSize = "";
  

  var selectedColor = '0xffb74093';
  var qty = 1;
  var picheight = 300.0;  
  
  @override
  void initState()
  {
    super.initState();
    selectedSize = widget.product.sizes[0];
  }

  // selectSize(widget.product.sizes[0]);

  Widget build(BuildContext context)
  {
    
    return Scaffold(
      // appBar: AppBar(title: Text("Detail Page"),),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("ADD TO CART",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),
              )
            ],
          ),
        ),
        color: Colors.green,
        
      ),
      body: ListView(
          children: <Widget>[

            GestureDetector(
                onTap: (){
                  ChangeHeight();
                },
                child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: picheight,
                child: Image.asset(
                  widget.product.imageUrl,
                  fit:BoxFit.cover,
                  alignment: Alignment.topCenter,
                  )
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text("sdfdsf",textAlign: ),
                                  Text(widget.product.name, textAlign: TextAlign.left, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),),
                              // Text("Exclusive Jacket"),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(left:0),
                                child: Row(
                                  children: <Widget>[
                                        Text("\u20B9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        Text(widget.product.price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        SizedBox(width: 10,),
                                        Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
                                        Text(widget.product.mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
                                        SizedBox(width: 6,),
                                        
                                        // double d = widget.product.mrp;
                                        Text(
                                            "("+
                                          ((widget.product.mrp - widget.product.price)*100 / widget.product.mrp ).toInt().toString()
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
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.favorite,color: Colors.red,size: 30,),
                                    Text("450 Likes",style:TextStyle(fontSize: 10,color: Colors.grey),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Icon(Icons.bookmark,color: Colors.black12,size: 30,)
                              ],
                          )
      
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
                          Text("Size",textAlign: TextAlign.left,),
                          SizedBox(height: 4,),
                          Container(
                            // width: 300,
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            // color: Colors.black,
                            
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.product.sizes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context,int index){                                
                                  return Padding(
                                    padding: const EdgeInsets.only(right:10),
                                    child: _size(widget.product.sizes[index], true),
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
                        Text("Color"),
                        SizedBox(height: 4,),
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
                        Text("Quantity"),
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
    );
  }






  Widget _size(String size,bool selected){
    return InkWell(
          onTap: (){
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