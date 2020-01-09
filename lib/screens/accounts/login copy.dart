import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        // width: ,
        alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.only(left: 50,right: 50),

        child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.topRight,
            child: Text("Skip Now")
            ),

            Center(
              child: Text("sdf"),
            )

          // Center(
          //   child: Container(
          //     // alignment: Alignment.center,
          //     padding: EdgeInsets.only(left: 50,right: 50),
          //     child: Column(
          //       children: <Widget>[
          //         Container(
          //             height: 200,
          //             child: Image.asset("assets/namelogo.png",fit: BoxFit.contain,),
          //           ),
          //           SizedBox(height: 20,),
          //           Container(
          //             child: Column(
          //               children: <Widget>[
          //                 TextField(
          //                   decoration: InputDecoration(
          //                     // border: InputBord
          //                     hintText: 'Mail-id / Phone Number'
          //                   ),
          //                 ),
          //                 SizedBox(height: 40,),
          //                 TextField(
          //                   decoration: InputDecoration(
          //                     // border: InputBord
          //                     hintText: 'Password'
          //                   ),
          //                 ),
          //                 SizedBox(height: 30,),
          //                 Container(
          //                   alignment: Alignment.centerRight,
          //                   child: Text("Forget Password"),
          //                 ),
                          
          //                 SizedBox(height: 30,),

          //                 Container(
          //                   height: 50,
          //                   alignment: Alignment.center,
          //                   width: MediaQuery.of(context).size.width,
          //                   decoration: BoxDecoration(
          //                     color: Colors.green
          //                   ),
          //                   child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 19),),
          //                 ),

          //                   SizedBox(height: 30,),
          //                   Row(
          //                     children: <Widget>[
          //                         Expanded(
          //                             child: Divider()
          //                         ),       

          //                         Text("OR"),        

          //                         Expanded(
          //                             child: Divider()
          //                         ),
          //                     ]
          //                 ),

          //               SizedBox(height:30,),

          //                 Container(
          //                   height: 50,
          //                   alignment: Alignment.center,
          //                   width: MediaQuery.of(context).size.width,
          //                   decoration: BoxDecoration(
          //                     color: Colors.green
          //                   ),
          //                   child: Text("Login Using Google",style: TextStyle(color: Colors.white,fontSize: 19),),
          //                 ),
          //                 SizedBox(height: 30,),
          //                 Container(
          //                   alignment: Alignment.center,
          //                   child: Text("Create an account",style: TextStyle(fontSize: 17,),),
          //                 )

          //               ],
          //             ),
          //           )
          //       ],
          //     ),
          //   ),
          // )


        ],
          ),
      ),
    );
  }
}