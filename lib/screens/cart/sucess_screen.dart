import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        appBar: AppBar(
          title: Text("order confirm"),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){ goToHome();   }),
        ),

        body: Container(
          alignment: Alignment.center,
          // color:Colors.red,
          padding: EdgeInsets.all(10),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,            
          //   children: <Widget>[
          //     Text("done")
          //   ],
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,               
            children: <Widget>[
              Icon(FontAwesomeIcons.checkCircle,size: 40,color: Colors.teal,),
              SizedBox(height:10),
              Text(
                "Your Orders has been confirmed !",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20
                  ),
                ),

              InkWell(
                    onTap: (){
                      goToHome();
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                    "Continue Shopping",
                    
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20
                    ),


                ),
                  ),
              )


            ],
          ),
        ),
      ),
    );
  }

}