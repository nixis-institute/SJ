import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction/bloc/login_bloc/login_bloc.dart';
import 'package:shopping_junction/bloc/login_bloc/login_repository.dart';
import 'package:shopping_junction/common/functions/requestLogin.dart';
import 'package:shopping_junction/screens/accounts/registration.dart';
import 'package:shopping_junction/screens/home_screen.dart';

class LoginScreen extends StatelessWidget{
  @override
  LoginRepostory loginRepostory = LoginRepostory();
  Widget build(BuildContext context){
    return BlocProvider(
      create: (context)=>LoginBloc(
        repository: loginRepostory,
        authenticateBloc: BlocProvider.of<AuthenticateBloc>(context)
        ),
      child: LoginScreen1()
      );
  }
}



class LoginScreen1 extends StatefulWidget{
  @override
  _LoginScreenState1 createState() => _LoginScreenState1();
}

class _LoginScreenState1 extends State<LoginScreen1>
{
  final _User = TextEditingController();
  final _Pass = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isSubmit = false;
  bool isWrong = false;

  @override
  void initState(){
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();
  }

  Widget build(BuildContext context)
  {
    _sendToServer(context,username,password)
      async {
        var x = await requestLoginApi(context,username,password);
        if(x==null){
          setState(() {
            isWrong = true;
            isSubmit = false;
          });
        }
        else{
            if(Navigator.canPop(context))
            {
              Navigator.pop(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
            }
            else{
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            }
        }

      }      
    
    return Scaffold(
      body: BlocListener<LoginBloc,LoginState>(
          listener: (context,state){
            if (state is LoginFailure){
              Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],                    
                  ),
                  backgroundColor: Colors.red,
                )
              );  
            }
            if(state is LoginSuccess){
              if(Navigator.canPop(context))
              {
                Navigator.pop(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
              }
              else{
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
              }              
              // Navigator.pop(context);
              // Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            }
          },
          child: BlocBuilder<LoginBloc,LoginState>(
            builder: (context,state){
            return Container(
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
                      if(Navigator.canPop(context))
                      {
                        Navigator.pop(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      }
                      else{
                        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                        
                        // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)

                        // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                        // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      // Navigator.pop(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
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
                              isWrong?
                              Text('Wrong username or password',style: TextStyle(color: Colors.red),):
                              SizedBox(height: 1,),
                              TextFormField(
                                controller: _User,
                                decoration: InputDecoration(
                                  // border: InputBord
                                  hintText: 'Mail-id / Phone Number',
                                  labelText: 'Mail-id / Phone Number'
                                ),
                                onTap: (){
                                  setState(() {
                                    isWrong = false;
                                  });
                                },                            
                              ),
                              SizedBox(height: 40,),
                              TextFormField(
                                autofocus: false,
                                controller: _Pass,
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
                              SizedBox(height: 30,),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text("Forget Password"),
                              ),
                              
                              SizedBox(height: 30,),

                              InkWell(
                                onTap: (){
                                    setState(() {
                                      isSubmit = true;
                                    });
                                  // print(BlocProvider.of<LoginBloc>(context));
                                  // _sendToServer(context,_User.text,_Pass.text);
                                  BlocProvider.of<LoginBloc>(context).add(
                                    OnLogin(
                                      username: _User.text,
                                      password:_Pass.text,
                                    ),
                                  );
                                },
                                  child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    
                                    color: Colors.green
                                  ),
                                  child: state is LoginLoading
                                  ?Container(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(strokeWidth: 3,valueColor: AlwaysStoppedAnimation(Colors.white),),)
                                  :Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 19),),
                                ),
                              ),

                                SizedBox(height: 30,),
                                Row(
                                  children: <Widget>[
                                      Expanded(
                                          child: Divider()
                                      ),       

                                      Text("OR"),        

                                      Expanded(
                                          child: Divider()
                                      ),
                                  ]
                              ),

                            SizedBox(height:30,),

                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.green
                                ),
                                child: Text("Login Using Google",style: TextStyle(color: Colors.white,fontSize: 19),),
                              ),
                              SizedBox(height: 30,),
                              Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>RegistrationScreen()));
                                  },
                                  child: Text("Create an account",style: TextStyle(fontSize: 17,),)),
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
        );
            }
        ),
      ),
    );
  }
}