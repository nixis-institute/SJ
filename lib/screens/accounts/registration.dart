import 'package:flutter/material.dart';
import 'package:shopping_junction/screens/accounts/login%20copy.dart';
import 'package:shopping_junction/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget{
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
{
  DateTime _date = DateTime.now();
  Future<Null> selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),

    );
    if(picked!=null && picked!=_date){
      print(_date.toString());

      setState(() {
        _date = picked;
      });

    }
  }
  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child:ListView(
          children: <Widget>[
            
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                },
                child: Text("Skip Now"))
                
                ),

            Container(
              padding: EdgeInsets.only(left: 50,right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 200,
                      child: Image.asset("assets/namelogo.png",fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Username'
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Email'
                            ),
                          ),

                          SizedBox(height: 30,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Date of Birth'
                            ),
                            // controller: ,
                            
                          ),

                          SizedBox(height: 30,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Password'
                            ),
                            obscureText: true,
                          ),


                          SizedBox(height: 30,),
                          TextField(
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Confirm Password'
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20,),

                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.green
                            ),
                            child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 19),),
                          ),

                          SizedBox(height: 30,),
                          Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                              },
                              child: Text("Already have account? Login",style: TextStyle(fontSize: 17,),)),
                          )

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