import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/common/commonFunction.dart';
import 'package:shopping_junction/models/userModel.dart';
import 'package:shopping_junction/screens/accounts/addressEditForm.dart';
import 'package:shopping_junction/screens/cart/payment_screen.dart';
enum SingingCharacter { lafayette, jefferson }
class Addresses extends StatefulWidget{
  @override
  List<Address> address;
  Addresses( { this.address=null });
  _Addresses createState() => _Addresses();
}

class _Addresses extends State<Addresses>
{

  fillAddress() async{
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getAddress),
        variables:{
          "userId":1,
          }
      )
    );

    if(result.loading)
    {

      isLoading=true;
    }
    if(!result.hasException)
    {
      var data = result.data["user"]["addressSet"]["edges"];
      List<Address> adds = [];

      for(int j=0;j<data.length;j++)
      {
        adds.add(Address(
           data[j]["node"]["id"],
          data[j]["node"]["houseNo"],
          data[j]["node"]["colony"],
          data[j]["node"]["personName"],
          data[j]["node"]["landmark"],
          data[j]["node"]["city"],
          data[j]["node"]["state"],
          data[j]["node"]["phoneNumber"].toString(),
          data[j]["node"]["alternateNumber"].toString()
          ));
      }

      setState(() {
        isLoading=false;
        this.widget.address = adds;
      });

    }

    



  }

  @override
  var isLoading = false;
  String userId;
  bool isDeleting;
  bool isAfterCart = false;
  var  _character;
  var total;

  void initState(){
  super.initState();
  getUserId().then((c){
      setState(() {
      userId = c;
      });
    });  
    if(this.widget.address==null)
    {
      isLoading = true;
      isAfterCart = true;
      _character =0;
      getTotal().then((c){
        setState(() {
          total = c;
        });
      });
    
    }
    isDeleting = false;
    fillAddress();
  }

    void _addNewAddress() async{
      final add = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressForm(this.widget.address[0],true)));
      if(add!=null)
      {
      setState(() {
        this.widget.address.add(
          Address(
            add["id"], 
            add["houseNo"], 
            add["colony"], 
            add["personName"], 
            add["landmark"], 
            add["city"], 
            add["state"], 
            add["phoneNumber"], 
            add["alternateNumber"]
            )
        );
      });
      }

    }


    _updateAddress(address,index)
    async{
    final add = await     Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddressForm(address,false)
    ));
    if(add!=null)
    {
      setState(() {
          this.widget.address[index].id = add["id"];
          this.widget.address[index].houseNo = add["houseNo"];
          this.widget.address[index].colony = add["colony"];
          this.widget.address[index].landmark = add["landmark"];
          this.widget.address[index].city = add["city"];
          this.widget.address[index].state = add["state"];
          this.widget.address[index].personName = add["personName"];
          this.widget.address[index].phoneNumber = add["phoneNumber"];
          this.widget.address[index].alternateNumber = add["alternateNumber"];
        });
      }
    }



  void _deleteAddress(id,index) async{
      
      setState(() {
        isDeleting = true;
      });
      GraphQLClient _client = clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
        documentNode: gql(deleteAddressQuery),
        variables:{
          "id":id,
          }
        )
      );

      if(!result.hasException)
      {
        setState(() {
          isDeleting = false;
        });        
        if(result.data["deleteAddress"]["success"]==true)
        {
          Navigator.of(context).pop();
          setState(() {
            this.widget.address.removeAt(index);
          });
        }
      }

  }

  void _showDialog(id,index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title:Text("Delete?"),
          content: 
          isDeleting?
          Container(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          ):
          
          
          Text("Do you want to delete this address?"),

          actions: <Widget>[
            !isDeleting?
            FlatButton(
              onPressed: (){
                  _deleteAddress(id,index);
              },
              child: Text("Delete",style: TextStyle(color: Colors.red),)
              ):SizedBox(width:1),


            !isDeleting?FlatButton(
              // onPressed: null,
              onPressed: ()=>Navigator.of(context).pop(),
              child: Text("Cancel",style: TextStyle(color: Colors.grey),)
              ):SizedBox(width: 1,)
          ],

        );
      }
    );
  }


  // SingingCharacter _character = SingingCharacter.lafayette;
//  var  _character =1;

  Widget build(BuildContext context)
  {
    
    return Scaffold(
      appBar: AppBar(
        title: 
        isAfterCart?Text("ADDRESS"):
        Text("Your Address"),


        actions: 
        isAfterCart?
        <Widget>[
          Row(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("Step:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              
              SizedBox(width: 5,),
              Text("2",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text("/3",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
              ),
              SizedBox(width: 15,)
            ],
          ),
        ]:null,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        
        // onPressed: _incrementCounter,
        onPressed: (){
            _addNewAddress();
        },
        tooltip: 'Add New Address',
        child:Icon(
          Icons.add,
          color: Colors.white,
          ),
      ), 
          bottomNavigationBar: isAfterCart? InkWell(
            onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>PaymentScreen(
            ))),
            child: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Place Order",
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
          ):null,

      body: isLoading?Center(child: CircularProgressIndicator(),):
      
      
      Column(
        children: <Widget>[
          // Container(
          //   height:50,
          //   color:Colors.white,
          //   child: Text("You have 5 Address ",style: TextStyle(fontSize:25,fontWeight:FontWeight.w300),),
          // ),

          Expanded(
              child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
              height: 1,
              ),
              shrinkWrap: true,
              itemCount: this.widget.address.length,
              
              itemBuilder: (contxt,index){
                
                // return ListTile(
                //   title: Text(this.widget.address[index].houseNo),
                // );

              return Container(
                color:Colors.white,
                padding: const EdgeInsets.only(left:15),
                child: InkWell(
                  onTap: (){
                      setState(() {
                      _character = index;
                      });
                      setAddress(this.widget.address[index].houseNo +" "+ this.widget.address[index].colony + " "+ this.widget.address[index].city +" "+ this.widget.address[index].state,
                       this.widget.address[index].phoneNumber + ", "+ this.widget.address[index].alternateNumber,
                       this.widget.address[index].id,
                       this.widget.address[index].personName
                       );
                      
                      },


                      child: Container(
                      
                      color: 
                      !isAfterCart?Colors.white:
                      _character ==index?Colors.green:Colors.white,
                      
                      
                      // elevation: 1,
                      // borderOnForeground: false,
                      child: Container(
                      
                      // width: MediaQuery.of(context).size.width*.8,
                      // padding: EdgeInsets.all(1),
                      child: Row(
                        children: <Widget>[
                          isAfterCart?
                          Container(
                            width: 30,
                            child: Radio(
                            groupValue: _character,
                            value:index,
                            
                            onChanged: (val){
                              setState(() {
                                _character = val;
                              });
                            },
                          ),
                        ):SizedBox(height: 0.01,),

                          Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                            margin: EdgeInsets.all(5),
                            // padding:EdgeInsets.all(10),                 
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        this.widget.address[index].personName,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w300
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(height:5),

                                      Text(
                                        this.widget.address[index].houseNo +" "+ this.widget.address[index].colony + " "+ this.widget.address[index].city +" "+ this.widget.address[index].state,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54
                                        ),
                                      ),
                                      SizedBox(height:10),
                                      Text(
                                        this.widget.address[index].phoneNumber + ", "+ this.widget.address[index].alternateNumber,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // isAfterCart?SizedBox():Divider(),
                                
                                isAfterCart?SizedBox():
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                      onTap: (){
                                        _updateAddress(this.widget.address[index],index);
                                      },                           
                                          child: Container(
                                          padding: EdgeInsets.all(10),
                                          // child: Icon(Icons.edit),
                                          child: Icon(Icons.edit,size: 20,color:Colors.grey),
                                          // child: Text("Edit",textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                                          
                                          // color: Colors.grey,
                                          ),
                                      )
                                      ),
                                    Expanded(
                                      child: InkWell(
                                          onTap: (){
                                            _showDialog(this.widget.address[index].id,index);
                                          },
                                          child: Container(
                                          padding: EdgeInsets.all(10),
                                          // color: Colors.red,
                                            child: Icon(Icons.delete_outline,size: 20,color:Colors.grey),
                                          // child: Text("Remove",textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                                          ),
                                      )
                                      )

                                  ],
                                )

                              ],
                            ),
                          ),

                        isAfterCart?
                        
                        IconButton(
                          icon:Icon(Icons.edit,color:Colors.black),
                          onPressed: (){
                            _updateAddress(this.widget.address[index],index);
                          },
                          
                          ):
                        
                        SizedBox()





                        ],
                      ),
                    ),
                  ),
                ),
              );
              }
              
              ),
          ),

        // Text("sldkjfl"),
        isAfterCart?
        Container(
          // height: 100,
          // color: Colors.red,
          child: Column(
            children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Payable ",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w300),),
                        Text("\u20B9 "+total, style: TextStyle(color: Colors.grey[700],fontSize: 21,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),  
            ],
          ),
        ):SizedBox()

        ],
      ),


    );
  }
}