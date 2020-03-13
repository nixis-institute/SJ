import 'package:flutter/material.dart';
import 'package:shopping_junction/common/commonFunction.dart';

import '../home_screen.dart';

class SuccessScreen extends StatefulWidget{
  @override
  _SuccessScreen createState() => _SuccessScreen();
}

class _SuccessScreen extends State<SuccessScreen>
{
  @override
 final PageRouteBuilder _homeRoute = new PageRouteBuilder(
  pageBuilder: (BuildContext context, _, __) {
    return HomeScreen();
    }
);

  Widget build(BuildContext context)
  {
    goToHome()
    {
      setCount("0");
      Navigator.pushAndRemoveUntil(context, _homeRoute, (Route<dynamic> r) => false);      
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("order confirm"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: goToHome()),
      ),

      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Your Orders has been confirmed !",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 30
                ),
              ),

            InkWell(
                  onTap: (){
                    goToHome();
                  },
                child: Text(
                "go To home",
                
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20
                ),


              ),
            )


          ],
        ),
      ),
    );
  }

}