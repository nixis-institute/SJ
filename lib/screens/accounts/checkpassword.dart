import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';

class ChangePasswordScreen extends StatefulWidget{
  @override
  final String id;
  ChangePasswordScreen({this.id});
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen>
{

  bool isSubmit = false;
  bool isPasswordMatch = true;
  bool isPasswordVisible = false;
  bool isPasswordWrong = false;
  final _Old = TextEditingController();
  final _New = TextEditingController();  
  final _New2 = TextEditingController();
  @override
  void initState(){
    super.initState();
  }
  
  Widget build(BuildContext context)
  {

    _changePassword(id,old_password,new_password)
    async{
      setState(() {
        isSubmit = true;
      });
      GraphQLClient _client = clientToQuery();

    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(changeUserPassword),
        variables:{
          "id":id,
          "old":old_password,
          "new":new_password
          }
      )
    );
    if(!result.hasException)
    {
      if(result.data["changePassword"]["user"]==null)
      {
        setState(() {
          isPasswordWrong = true;
          isSubmit = false;
        });
      }
      else{
        Navigator.pop(context);
      }
    }
      
    }


    return Scaffold(
      appBar: AppBar(title: Text("Change Your Password"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Old Password",
                hintText: "Old Password"
      
              ),
              onTap: (){
                setState(() {
                  isPasswordWrong = false;
                });
              },
              controller: _Old,
            ),
            SizedBox(height: 5,),
            isPasswordWrong?
            Text("Old password is wrong",style: TextStyle(color: Colors.red),):SizedBox(height: 0,),

            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "New Password",
                hintText: "New Password",
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVisible?Icons.visibility:Icons.visibility_off),
                  onPressed: (){
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),                
              ),
              controller: _New,
              obscureText: !isPasswordVisible,
            ),
          SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: isPasswordMatch?"Repeat Password":"Password is not match",
                hintText: "Repeat Password",
                labelStyle: TextStyle(
                  color: isPasswordMatch?Colors.grey:Colors.red
                ),
                suffix: Container(
                  height: 20,
                  width: 20,
                  child:isPasswordMatch
                  ?Text(""):
                  Icon(Icons.info_outline,color: Colors.red,)                                  
                  )  
              ),

              onChanged: (text){
                if(_New.text!=text)
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

              controller: _New2,
              obscureText: !isPasswordVisible,
            ),  
            SizedBox(height: 20,),



            InkWell(
                  onTap: (){
                    if(_New2.text!=_New.text)
                    {
                      setState(() {
                        isPasswordMatch = false;
                      });
                    }
                    else{
                      _changePassword(this.widget.id,_Old.text,_New.text);
                    }
                    
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
                  :Text("Change Password",style: TextStyle(color: Colors.white,fontSize: 19),),
                ),
            ),          

          ],
        ),
      ),
    );
  }
}