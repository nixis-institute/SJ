import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/userModel.dart';


class AddressForm extends StatefulWidget{
  @override
  Address address;
  bool isNew;
  AddressForm(this.address,this.isNew);
  _AddressForm createState() => _AddressForm();
}

class _AddressForm extends State<AddressForm>
{
  final _houseNo = TextEditingController();
  final _colony = TextEditingController();  
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _landmark = TextEditingController();
  final _personName = TextEditingController();
  final _phone = TextEditingController();  
  final _alternate = TextEditingController();  
  
  bool _hn =  false;
  bool _col = false;
  bool _ct =  false;
  bool _st =  false;
  bool _pn =  false;
  bool _ph =  false;
  // final _formKey = GlobalKey<FormState>();
  
  @override

  bool isloading=false;
  bool isSubmit = false;
  var userId;
  void initState()
  {
    super.initState();

    // print(this.widget.isNew);
    if(this.widget.isNew==false)
    {
        _houseNo.text = this.widget.address.houseNo??"";
        _colony.text = this.widget.address.colony??"";
        _city.text = this.widget.address.city??"";
        _state.text = this.widget.address.state??"";
        _landmark.text = this.widget.address.landmark??"";
        _personName.text = this.widget.address.personName??"";
        _phone.text = this.widget.address.phoneNumber??"";
        _alternate.text = this.widget.address.alternateNumber??"";
    }
    getUserId().then((c){
      setState(() {
      userId = c;
      });
    });  

  }


  Widget build(BuildContext)
  {


    _updateAddress(house,colony,city,state,landmark,person,phone,alternate) async{
      setState(() {
        isSubmit = true;
      });

      // print(person);

      if(this.widget.isNew)
      {
        GraphQLClient _client = clientToQuery();
        QueryResult result = await _client.mutate(
          MutationOptions(
          documentNode: gql(addAddressQuery),
          variables:{
            // "id":this.widget.address.id,
            "user": userId,
            "house_no": house,
            "colony": colony,
            "landmark": landmark,
            "city": city,
            "state": state,
            "person_name": person,
            "phone_number": phone,
            "alternate_number": alternate
            }
          )
      );
      if(result.hasException)
      {
        print(result.exception.toString());
      }
      if(!result.hasException)
      {
        print(result.data["addAddress"]["success"]);
        if(result.data["addAddress"]["success"] == true)
        {
          Navigator.pop(context,result.data["addAddress"]["address"]);
        }
      }      



      }
      else{
        GraphQLClient _client = clientToQuery();
        QueryResult result = await _client.mutate(
        MutationOptions(
        documentNode: gql(updateAddressQuery),
        variables:{
          "id":this.widget.address.id,
          // "user": 1,
          "house_no": house,
          "colony": colony,
          "landmark": landmark,
          "city": city,
          "state": state,
          "person_name": person,
          "phone_number": phone,
          "alternate_number": alternate
          }
        )
      );

      if(!result.hasException)
      {
        print(result.data["updateAddress"]["success"]);
        if(result.data["updateAddress"]["success"] == true)
        {
          Navigator.pop(context,result.data["updateAddress"]["address"]);
        }
      }

      }
    }


    return Scaffold(
      appBar: AppBar(
        title:this.widget.isNew
        ?Text("Add New Address")
        :Text("Edit Your Address")
        
        ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: ListView(
          // shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          
          children: <Widget>[
            Container(
              child: TextFormField(
                // key: _hn,
                keyboardType: TextInputType.text,
                onTap: (){
                  setState(() {
                    _hn = false;
                  });
                },
                decoration: InputDecoration(
                  labelText: "House No. Building Name",
                  hintText: "House No. Building Name",
                  errorText: _hn?"Please Enter House Number":null,

                ),
                controller: _houseNo,
              ),
            ),

            SizedBox(height:10),

            Container(
              child: TextFormField(
                // key: _col,
                keyboardType: TextInputType.text,
                onTap: (){
                  setState(() {
                    _col = false;
                  });
                },                
                decoration: InputDecoration(
                  labelText: "Road Name,Area, Colony *",
                  hintText: "Road Name,Area, Colony *",
                  errorText: _col?"Please Enter Colony":null,
                ),
                controller: _colony,
              ),
            ),
          SizedBox(height:10),
          
          Container(
            child: Row(
              children: <Widget>[
                  Expanded(
                      child: Container(
                      margin: EdgeInsets.only(right:5),
                      child: TextFormField(
                        
                        onTap: (){
                          setState(() {
                            _ct = false;
                          });
                        },                        
                        // key: _ct,
                        keyboardType: TextInputType.text,                        
                        decoration: InputDecoration(
                          labelText: "City*",
                          hintText: "City*",
                          errorText: _ct?"Please Enter City":null,
                        ),
                        controller: _city,
                      ),
                    ),
                  ),

                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left:5),
                      child: TextFormField(
                        // key: _st,
                        onTap: (){
                          setState(() {
                            _st = false;
                          });
                        },                        
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "State*",
                          hintText: "State*",
                          errorText: _st?"Please Enter State":null,
                        ),
                        controller: _state,
                      ),
                    ),
                  ),            

              ],
            ),
          ),
          SizedBox(height:10),


            Container(
              child: TextFormField(
                // key: _formKey,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Landmark (Optional)",
                  hintText: "Landmark (Optional)",
                ),
                controller: _landmark,
              ),
            ),

            SizedBox(height:10),



            Container(
              child: TextFormField(
                // key: _pn,
                keyboardType: TextInputType.text,
                onTap: (){
                  setState(() {
                    _pn = false;
                  });
                },                
                decoration: InputDecoration(
                  labelText: "Name*",
                  hintText: "Name*",
                  errorText: _pn?"Please Enter Name":null,
                ),
                controller: _personName,
              ),
            ),

            SizedBox(height:10),


            Container(
              child: TextFormField(
                // key: _ph,
                onTap: (){
                  setState(() {
                    _ph = false;
                  });
                },                
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Mobile Number*",
                  hintText: "Mobile Number*",
                  errorText: _ph?"Please Enter Phone Number":null,
                ),
                controller: _phone,
              ),
            ),

            SizedBox(height:10),

            Container(
              child: TextFormField(
                // key: _formKey,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Alternate number (Optional)",
                  hintText: "Alternate number (Optional)",
                ),
                controller: _alternate,
              ),
            ),   

            SizedBox(height:10),  

            InkWell(
                onTap: (){
                    if(_houseNo.text.isEmpty)
                    {
                        setState(() {
                        _hn = true;
                      });
                    }

                    else if(_colony.text.isEmpty)
                    {
                        setState(() {
                        _col = true;
                      });
                    }

                    else if(_city.text.isEmpty)
                    {
                        setState(() {
                        _ct = true;
                      });
                    }

                    else if(_state.text.isEmpty)
                    {
                        setState(() {
                        _st = true;
                      });
                    }


                    else if(_personName.text.isEmpty)
                    {
                        setState(() {
                        _pn = true;
                      });
                    }

                    else if(_phone.text.isEmpty)
                    {
                        setState(() {
                        _ph = true;
                      });
                    }

                    else{
                      _updateAddress(_houseNo.text, _colony.text, _city.text, _state.text, _landmark.text, _personName.text, _phone.text, _alternate.text);
                    }



                  // if(_hn.currentState.validate())
                  // {                   
                  //   _updateAddress(_houseNo.text, _colony.text, _city.text, _state.text, _landmark.text, _personName.text, _phone.text, _alternate.text);
                  // }
                  // else{
                  //   print("enpty");
                  // }
                },
                child: Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.green,
                child: isSubmit? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),):
                 Text(
                   this.widget.isNew?"Add":
                   "Update",
                 style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            )       


          ],
        ),
      ),
    );
  }
}