import 'package:flutter/material.dart';

import 'first_secreen.dart';

class  AddAddress extends StatefulWidget{
  @override

  _AddAddressState createState() =>  _AddAddressState();
}

class _AddAddressState extends State<AddAddress>
{
  @override

  Widget build(BuildContext context)
  {
    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          title: Text("Add new Address"),
          backgroundColor: Colors.green,
          
          
          actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                iconSize: 30,
                color: Colors.white,
                onPressed: (){},
              ),

              Stack(
                  children:<Widget>[
                    IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    iconSize: 30,
                    color: Colors.white,
                    
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
                    child: Text("3"),
                  ),
                )
              ]
            ),


              // IconButton(
              //   icon: Icon(Icons.add_shopping_cart),
              //   iconSize: 30,
              //   color: Colors.white,
              //   onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
              //     )));
              //   },                
              //   // onPressed: (){},
              // ),


              IconButton(
                icon: Icon(Icons.more_vert),
                iconSize: 30,
                color: Colors.white,
                onPressed: (){},
              )                            
          ],
        ),



      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child:ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    // Container(
                    //   child: Text("Add new address"),
                    // ),
                    SizedBox(height: 30,),
                    Container(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'House No. Building name*'
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Road Name, Area,Colony*'
                            ),
                          ),

                          SizedBox(height: 20,),

                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: TextField(
                                    decoration: InputDecoration(
                                      // border: InputBord
                                      hintText: 'City'
                                    ),
                                ),
                              ),
                              ),

                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: TextField(
                                    decoration: InputDecoration(
                                      // border: InputBord
                                      hintText: 'State'
                                    ),
                                    // controller: ,
                                ),
                                  ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Landmark (Optional)'
                            ),
                          ),

                          SizedBox(height: 40,),
                          Divider(height: 2,color: Colors.black87,),

                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Name*'
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20,),

                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: '10-digit mobile number*'
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Alternate Phone Number (Optional)*'
                            ),
                            obscureText: true,
                          ),


                          SizedBox(height: 30,),
                          Divider(height: 2.0,color: Colors.black,),
                      
                      Container(
                      padding: EdgeInsets.only(top:10,bottom: 10),
                      alignment: Alignment.centerLeft,  
                      child: Text("Address Type")),
                      
                      new Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[


                        Row(
                          children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: 0,
                          ),
                          new Text(
                            'Home',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Row(
                            children: <Widget>[
                            new Radio(
                              value: 0,
                              groupValue: 0,
                            ),
                            new Text(
                              'Work',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            ],
                          ),
                        ),

                        
                      ],
                    ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.green
                            ),
                            child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w800),),
                          ),
                          SizedBox(height: 50,)

                        ],
                      ),
                    )
                ],

              ),
            ),
          ],
        )



        // child: ListView(
        // children: <Widget>[
        //   Container(
        //     padding: EdgeInsets.only(right: 10),
        //     alignment: Alignment.topRight,
        //     child: Text("Skip Now")
        //     ),

        //     Center(
        //       child: Text("sdf"),
        //     )

        // ],
        //   ),
      ),

    );
  }

}