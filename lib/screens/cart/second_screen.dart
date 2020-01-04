import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget{
  @override
  _AddressScreenState createState() => _AddressScreenState();
}



class _AddressScreenState extends State<AddressScreen>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADDRESSES"),
        actions: <Widget>[
          Row(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("Step:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              
              SizedBox(width: 5,),
              Text("2",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              SizedBox(width: 15,)
            ],
          ),
        ],        
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              alignment: Alignment.center,
              overflow:Overflow.visible,
              children: <Widget>[

                Column(
                  children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0,left: 50),
                          child: Text("You have 3 Address Saved",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w300 ),),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.grey,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(width: 30,color: Colors.white,)
                          // border: Border.all(color:Colors.white,style: BorderStyle.solid,)
                        ),
                        height: 300,
                      )
                  ],
                ),
                Positioned(
                  top: 50,
                  child: Padding(
                      padding: EdgeInsets.all(0),
                      // alignment: Alignment.center,
                      child: Container(
                      height: 290,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width-100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.grey[300],),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20,top:10,right: 10 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Kishan Pandev (Default)",style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w300,fontSize: 18),),
                                Icon(Icons.check_circle,color: Colors.green, )
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top:0),
                              child: Text("A-68 Avadhut nagar society near raman nager\nDhanmora Katargam\nkatagam\nSurat - 395004\nGujrat\n\nMobile 9737688470",style: TextStyle(color: Colors.grey,fontSize: 12),),
                            ),
                            // Text("Dhanmora Katargam"),
                            // Text("katagam"),
                            // Text("Surat - 395004"),
                            // Text("Gujrat\n\nmobile")
                            
                            Padding(
                              padding: const EdgeInsets.only(top:20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    // child: Text("Cash on Delivery Available"),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Text("Cash on Delivery Available",style: TextStyle(color: Colors.green,fontSize: 12),),
                                  )
                                ],
                              ),
                            ),
                            // Text(".",style: TextStyle(fontSize: 40),)

                          Container(
                            // alignment: Alignment.bottomCenter,
                            // height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Divider(height: 1,color: Colors.grey,),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        width: 130,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.red
                                        border: Border(right: BorderSide(color: Colors.grey[200]))
                                        ),
                                        child: Text("Edit",style: TextStyle(color: Colors.green),)
                                        ),

                                      Container(
                                        width: 140,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          // color: Colors.red
                                        ),
                                        child: Text("Add New Address",style:TextStyle(color: Colors.grey),)
                                        ),                                        

                                      // Text("Add New Address"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          
                          )

                          ],
                          
                        ),
                      ),
                      
                    ),
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );

  }
}