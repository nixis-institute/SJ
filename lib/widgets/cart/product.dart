import 'package:flutter/material.dart';
import 'package:shopping_junction/models/cart.dart';

class CartProductWidget extends StatefulWidget{
  @override
  _CartProductState createState() => _CartProductState(); 

}

class _CartProductState extends State<CartProductWidget>{
  var qty = 1;
  @override
  Widget build(BuildContext context){
    return
    Container(
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      physics:ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: cart.products.length,
      itemBuilder: (BuildContext context,int index){
        return 
          Container(
            padding: EdgeInsets.only(top:10,left:10,right:10),
            decoration: BoxDecoration(
            ),
            // child: Text(cart.products[index].product.name),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green)
                  ),

                  child: Row(
                    children: <Widget>[
                        Container(
                        padding: EdgeInsets.all(5),
                        width: 90,
                        child: Image.asset(
                          cart.products[index].product.imageUrl,
                          fit:BoxFit.contain,alignment: Alignment.topCenter,)
                        ),


                      Container(
                        width: MediaQuery.of(context).size.width - 120,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Container(
                              // color: Colors.red,
                              padding: const EdgeInsets.only(top:10,left: 10),
                              child: Container(
                                // color: Colors.black,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(cart.products[index].product.name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w300,),),
                                    SizedBox(height: 5,),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        // Text(cart.products[index].product.name),
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            Text(cart.products[index].product.price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                            SizedBox(width: 10,),
                                            Text("\u20B9",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red),),
                                            Text(cart.products[index].product.mrp.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough),),
                                            SizedBox(width: 6,),
                                            
                                            // double d = cart.products[index].product.mrp;
                                            Text(
                                                "("+
                                              ((cart.products[index].product.mrp - cart.products[index].product.price)*100 / cart.products[index].product.mrp ).toInt().toString()
                                                +"% off)",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                                ),
                                            )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: <Widget>[
                                        Text("Size:",style: TextStyle(color: Colors.black54, fontSize: 17),),
                                        SizedBox(width: 5,),
                                        Text("M",style: TextStyle(color: Colors.blue,fontSize: 19),)

                                      // DropdownButton<String>(
                                      //   items: <String>['A', 'B', 'C', 'D'].map((String val) {
                                      //           return new DropdownMenuItem<String>(
                                      //                 value: val,
                                      //                 child: new Text(val),
                                      //                 );
                                      //             }).toList(),
                                      //   hint: Text("Please choose a location"),
                                      //   onChanged: (newVal) {
                                      //     _selectedLocation = newVal;
                                      //     this.setState(() {});
                                      //     }
                                      //     );

                                          // DropdownButton<String>(
                                          //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                          //     return new DropdownMenuItem<String>(
                                          //       value: value,
                                          //       child: new Text(value),
                                          //     );
                                          //   }).toList(),
                                          //   onChanged: (_) {},
                                          // )

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          
                          // Text("Sdf"),

                          Container(
                            // alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                    onTap: (){
                                      // AddQty();
                                      // RemoveQty();
                                      cart.products[index].qty-=1;
                                    },

                                    child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200]
                                    ),
                                    child: Icon(Icons.remove,color: Colors.grey, )
                                    ),
                                ),

                                SizedBox(width: 15,),
                                Text(cart.products[index].qty.toString(),
                                style: TextStyle(fontSize: 20),),
                                SizedBox(width: 15,),

                                InkWell(
                                  
                                  onTap: (){
                                    cart.products[index].qty+=1;
                                  },

                                  child: Container(
                                  decoration: BoxDecoration(
                                  color: Colors.grey[200]
                                  ),
                                    child: Icon(Icons.add,color: Colors.grey,)
                                    ),
                                ),
                              ],
                            ),
                          )


                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],


            ),
          
          );  
        // Text(cart.products[index].product.name);
      
      },

    ),
  );
  }
    RemoveQty() {
    setState(() {
      qty>1?
      qty--:
      qty
      ;
    });
  }
    AddQty() {
    setState(() {
      qty++;
    });
  }

}