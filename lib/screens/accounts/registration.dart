import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/screens/accounts/login.dart';
// import 'package:shopping_junction/screens/accounts/login%20copy.dart';
import 'package:shopping_junction/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget{
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
{
  final _User = TextEditingController();
  final _Email = TextEditingController();
  final _Pass1 = TextEditingController();
  final _Pass2 = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isSubmit = false;
  bool isWrong = false;
  bool isWork = false;  
  bool isSearch = false;  
  bool isPasswordMatch =true; 
  bool isAvailable = false;  


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
    _createUser(context,username,email,password)
    async {
    if(username.length==0)
    {
      
    }
    setState(() {
      isSubmit = true;
    });

    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(createUser),
        variables:{
          "user":username,
          "email":email,
          "password":password
          }
      )
    );
    if(result.loading)
    {
      setState(() {
        isSubmit = true;
      });
    }
    if(!result.hasException)
    {
      Navigator.pop(context);
    }
  }


  _isUserAvailable(username)
  async{
    setState(() {
      isWork = true;
      isSearch = true;
    });
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(isUserExisted),
        variables: {
          "username":username
        }
      )
    );
    
    if(result.loading)
    {
      setState(() {
        isSearch = true;        
      });
    }
    if(!result.hasException)
    {
      setState(() {
        isSearch = false;        
      });
      if(result.data["isUserExisted"]==null)
      {
        setState(() {
          isAvailable = false;          
        });
      }
      else{
        setState(() {
          isAvailable = true;          
        });
      }

    }
  }



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
                          
                          TextFormField(
                            autofocus: false,
                            controller: _User,
                            // onChanged: ,
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Username',
                              labelText: !isAvailable?'Username':"Username is not available",
                              labelStyle: TextStyle(
                                color: !isAvailable?Colors.grey:Colors.red
                              ),
                                suffix: 
                                Container(
                                  height: 20,
                                  width: 20,
                                  child:!isWork
                                  ?Text(""):
                                  isSearch?
                                  CircularProgressIndicator(strokeWidth: 2,valueColor: AlwaysStoppedAnimation(Colors.green),)
                                  :!isAvailable
                                  ?
                                  Icon(Icons.check_circle_outline,color: Colors.green,):
                                  Icon(Icons.info_outline,color: Colors.red,)
                                  
                                  )
                                  
                                  
                                  ,
                              ),
                            
                            onTap: (){
                              setState(() {
                                // isWork = false;
                                isWrong = false;
                              });

                            },
                            onChanged: (text){
                              // print(text);
                              if(text.length>3)
                              {
                              _isUserAvailable(text);
                              }
                              else{
                                // print("less than 2");
                                setState(() {
                                isWork = false;                                  
                                });

                                // isSearch = false;
                              }
                            },

                            // obscureText: !isPasswordVisible,
                          ),





                          SizedBox(height: 20,),
                          TextFormField(
                            autofocus: false,
                            controller: _Email,
                            // onChanged: ,
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Email',
                              labelText: 'Email',
                              
                            ),
                            onTap: (){
                              setState(() {
                                isWrong = false;
                              });
                            },

                          ),

                          SizedBox(height: 20,),

                          TextFormField(
                            autofocus: false,
                            controller: _Pass1,
                            // onChanged: ,
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Password',
                              labelText: 'Password',

                              suffixIcon: IconButton(
                                icon: Icon(isPasswordVisible?Icons.visibility:Icons.visibility_off),
                                onPressed: (){
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              
                            ),
                            onTap: (){
                              setState(() {
                                isWrong = false;
                              });
                            },
                            obscureText: !isPasswordVisible,
                          ),


                          SizedBox(height: 20,),
                          TextFormField(
                            autofocus: false,
                            controller: _Pass2,
                            // onChanged: ,
                            decoration: InputDecoration(
                              // border: InputBord
                              hintText: 'Confirm Password',
                              labelText: isPasswordMatch?'Confirm Password':"Password doesn't match",
                              labelStyle: TextStyle(
                                color: isPasswordMatch?Colors.grey:Colors.red
                              ),

                              suffix: 
                                Container(
                                  height: 20,
                                  width: 20,
                                  child:isPasswordMatch
                                  ?Text(""):
                                  Icon(Icons.info_outline,color: Colors.red,)                                  
                                  )                                            
                            ),
                            onTap: (){
                              setState(() {
                                isWrong = false;
                              });
                            },
                            onChanged: (text){
                              if(_Pass1.text!=text)
                              {
                                setState(() {
                                  isPasswordMatch = false;
                                });
                              }
                              else{
                                setState(() {
                                  isPasswordMatch = true;
                                });
                              }
                            },

                            obscureText: !isPasswordVisible,
                          ),



                          SizedBox(height: 20,),

                          InkWell(
                              onTap: (){
                                _createUser(context,_User.text,_Email.text,_Pass1.text);
                              },
                              child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.green
                              ),
                              child: isSubmit
                                ?Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(strokeWidth: 3,valueColor: AlwaysStoppedAnimation(Colors.white),),)
                                :Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 19),),
                            ),
                          ),

                          SizedBox(height: 20,),
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