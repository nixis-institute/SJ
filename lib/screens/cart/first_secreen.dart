import 'package:flutter/material.dart';
import 'package:shopping_junction/models/cart.dart';

class CartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("CART"),
        actions: <Widget>[
          Row(
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("Step:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              
              SizedBox(width: 5,),
              Text("1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              )
            ],
          ),
          // Icon(Icons.access_alarm),
          // Icon(Icons.access_alarm)
        ],
      ),
      body: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.products.length,
                itemBuilder: (BuildContext context,int index){
                  return 
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      ),
                      // child: Text(cart.products[index].product.name),
                      child: Column(

                        // crossAxisAlignment: CrossAxisAlignment.center,
                        
                        children: <Widget>[
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green)
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: <Widget>[
                                // Text("sdf"),
                                Image.asset(cart.products[index].product.imageUrl),
                                Padding(
                                  padding: const EdgeInsets.only(top:30),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(cart.products[index].product.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),),
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
                                            Text("Size:"),
                                            SizedBox(width: 5,),
                                            Text("M")
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
                                        )

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],


                      ),
                    
                    );  
                  // Text(cart.products[index].product.name);
                
                },

              ),
            )
          ],
        ),
      ),
    );
  }
}