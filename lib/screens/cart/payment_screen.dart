import 'package:flutter/material.dart';
import 'package:shopping_junction/common/commonFunction.dart';

import '../home_screen.dart';
import 'final_screen.dart';
class PaymentScreen extends StatefulWidget{
  String addressID;
  PaymentScreen({this.addressID});
  @override

  _PaymentScreen createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen>
{
  @override
  var _character = 1;
  String total;
  void initState()
  {
    setPaymentMode("Cash on Delivery");
    super.initState();
      getTotal().then((c){
        setState(() {
          total = c;
        });
      });

  }


  Widget build(BuildContext)
  {

    return Scaffold(
      bottomNavigationBar: InkWell(
            
            onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>FinalScreen(
            ))),




            child: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("PAY \u20B9 "+total,
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
      ),

      appBar: AppBar(
        title: Text("PAYMENT"),
        actions: <Widget>[
          Row(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("Step:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              
              SizedBox(width: 5,),
              Text("3",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              SizedBox(width: 15,)
            ],
          ),
        ],
      ),


      body: Container(
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: (){
                setState(() {
                  _character = 1;
                });
                setPaymentMode("Cash on delivery");
              },
              child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    child: Radio(
                    groupValue: _character,
                    value:1,
                    
                    onChanged: (val){
                      setState(() {
                        _character = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(title:Text("Cash On Delivery"))
                )
                ],
              ),
                ),
            ),
            SizedBox(height:4),

            InkWell(
              onTap: (){
                setState(() {
                  _character = 2;
                });
              setPaymentMode("Credit Card");
              },



              child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    child: Radio(
                    groupValue: _character,
                    value:2,
                    onChanged: (val){
                      setState(() {
                        _character = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(title:Text("Credit Card"))
                )
                ],
              ),
                ),
            ),




          ],
        ),
      ),


    );
  }
}