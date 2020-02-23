import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/userModel.dart';

class UserEditFormScreen extends StatefulWidget{
  @override
  UserModel user;
  UserEditFormScreen({this.user});
  _UserEditFormScreen createState() => _UserEditFormScreen();
}
class _UserEditFormScreen extends State<UserEditFormScreen>
{
  final _Fname = TextEditingController();
  final _Lname = TextEditingController();
  final _Email = TextEditingController();
  final _Phone = TextEditingController(); 
  final _Gender = TextEditingController();
  bool isSubmit = false;
  @override
  void initState(){
    super.initState();
   _Fname.text = this.widget.user.firstName??"";
   _Lname.text = this.widget.user.lastName??"";
   _Email.text = this.widget.user.email??"";
   _Phone.text = this.widget.user.phone??"";
   _Gender.text = this.widget.user.gender??"";  
  
  }
  Widget build(BuildContext context)
  {

    // _Fname.text = "sdfdsf";
  //  _Fname.text = this.widget.user.firstName??"";
  //  _Lname.text = this.widget.user.lastName??"";
  //  _Email.text = this.widget.user.email??"";
  //  _Phone.text = this.widget.user.phone??"";
  //  _Gender.text = this.widget.user.gender??"";


    final fname = TextFormField(
      // initialValue: this.widget.user.firstName??" ",
      
      // initialValue: "sdf",

      decoration: InputDecoration(
          hintText: "First Name",
          labelText: "First Name",
      ),
      
      controller: _Fname,
    );


    final lname = TextFormField(
      decoration: InputDecoration(
          hintText: "Last Name",
          labelText: "Last Name",
      ),
      controller: _Lname,
    );

    final email = TextFormField(
      decoration: InputDecoration(
          hintText: "Email",
          labelText: "Email",
      ),
      controller: _Email,
    );

    final phone = TextFormField(
      decoration: InputDecoration(
          hintText: "Phone Number",
          labelText: "Phone Number",
      ),
      controller: _Phone,
    );


    final gender = TextFormField(
      decoration: InputDecoration(
          hintText: "Gender",
          labelText: "Gender",
      ),
      controller: _Gender,
    );    

    _sendToServer(id,firstname,lastname,email,phone,gender)
    async{
      setState(() {
        isSubmit = true;
      });


      GraphQLClient _client = clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
        documentNode: gql(updateUser),
        variables:{
          "firstName":firstname,
          "id":id,
          "lname":lastname,
          "gender":gender,
          "phone":phone,
          "email":email
          }
        )
      );
      if(!result.hasException)
      {

        var d = result.data["updateUser"]["user"];
        var phone,gender = "";
        print(d["id"]);
        print(d["firstName"]);


        if(d["profile"]!= null)
        {
          phone = d["profile"]["phoneNumber"]??"";
          gender = d["profile"]["gender"]??"";
        }
        List<Address> adds = [];
        print(d["addressSet"]);


        if(d["addressSet"]!=null)
        {
        List t = d["addressSet"]["edges"];

          for(int j=0;j<t.length;j++)
          {
            adds.add(Address(t[j]["node"]["id"],
              t[j]["node"]["houseNo"],
              t[j]["node"]["colony"],
              t[j]["node"]["personName"],
              t[j]["node"]["landmark"],
              t[j]["node"]["city"],
              t[j]["node"]["state"],
              t[j]["node"]["phoneNumber"].toString(),
              t[j]["node"]["alternateNumber"].toString()
              ));
          }
        }



        setState(() {
          this.widget.user = UserModel(
            d["username"],
            d["id"],d["firstName"],
            d["lastName"],
            d['email'],
            phone,
            gender,
            adds,
            );
        });

        Navigator.pop(context,this.widget.user);

      }
    }


    
    return Scaffold(
      appBar: AppBar(title: Text("Edit Personal Information"),),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
            fname,
            SizedBox(height: 20,),
            lname,
            SizedBox(height: 20,),
            email,
            SizedBox(height: 20,),
            phone,
            SizedBox(height: 20,),
            gender,
            SizedBox(height: 20,),
            
            InkWell(
              onTap: (){
                  // setState(() {
                  //   isSubmit = true;
                  // });
                _sendToServer(this.widget.user.id,_Fname.text,_Lname.text,_Email.text,_Phone.text,_Gender.text);
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
                :Text("Update",style: TextStyle(color: Colors.white,fontSize: 19),),
              ),
            ),            
            SizedBox(height: 30,)
            ],
          )


        //   Column(
        //   children: <Widget>[
        //     fname,
        //     SizedBox(height: 20,),
        //     lname,
        //     SizedBox(height: 20,),
        //     email,
        //     SizedBox(height: 20,),
        //     phone,
        //     SizedBox(height: 20,),
        //     gender,
        //     SizedBox(height: 20,),                                                
        //   ],
        // ),



      ),
    );
  }
}