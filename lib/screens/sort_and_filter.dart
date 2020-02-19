import 'package:flutter/material.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/models/filter_model.dart';
import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/subcategory_model.dart';
import 'package:shopping_junction/screens/listpage_screen%20copy.dart';

class SortAndFilter extends StatefulWidget{
  @override
  _SortAndFilterState createState() => _SortAndFilterState();
}

class _ListItem {
  _ListItem(this.value,this.checked);
  final String value;
  bool checked;
}

class _MapItem{
  final String filter;
  var items;
  _MapItem({this.filter,this.items});
}

class _SortAndFilterState extends State<SortAndFilter>
{
    var selectedString;
    var filters =["Brand","Colors","Size","Price"];

    var items = {};
    // var its={};
    
    @override
    void initState()
    {
      super.initState();
      selectedString = filters[0];

      // its = filter_models.prd.map((string,list)=>_MapItem(string,list));

        // filter_models.prd.map((string,list)=>{

        //    its.update(string,list)

        // });


      // items = filter_models.prd[selectedString];
      // items = filter_models.prd.map((f)=>_ListItem(f,false))

      // items = filter_models.prd[selectedString].map((item)=>_ListItem(item,false)).toList();
      filter_models.prd.forEach((x,y){
//         m[x] = {"value":y,"selected":false};
      items[x] = y.map((item)=>_ListItem(item,false)).toList();
    }
    );      
    }
    

    Widget build(BuildContext context)
    {
      print("--------------------------------------");
      items[selectedString].forEach((i)
      {
        if(i.checked==true)
          print(i.value);
          }
      
      );
      // print(items[selectedString][0].value);
      print("--------------------------------------");
      // items.map((f)=>print(f.value));

      return Scaffold(
      
        // backgroundColor: Colors.white.withOpacity(0.5),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Filters"),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Text("Clear All Filter",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                SizedBox(width: 15,)
              ],
            )
          ],  


        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filters.length,

                    itemBuilder: (context,index){
                      return Container(
                        color:filters[index] == selectedString?
                        Colors.grey[100]:Colors.white,
                        child: ListTile(
                          title:Text(
                            filters[index],
                            style: TextStyle(
                              color:filters[index] == selectedString?
                              Colors.blue:Colors.black,
                              ),
                            ),
// items = filter_models.prd[selectedString].map((item)=>_ListItem(item,false)).toList();

                          // onTap: () =>setState(()=> selectedString = filters[index]) 
                            onTap: (){
                              setState(() {
                                selectedString = filters[index];
                                
                                // items = filter_models.prd[selectedString].map((item)=>_ListItem(item,false)).toList();

                              });
                            },

                          )
                        );
                    },
                  ),
                ),
              
              // print("object"),


                Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  child:ListView.builder(

                    // itemCount: items[selectedString].length,
                    itemCount: items[selectedString].length,

                    
                    // itemCount: items.length,
                    itemBuilder: (context,i)
                    {

                        return CheckboxListTile(
                          value: items[selectedString][i].checked??false,
                          key: Key(items[selectedString][i].value),                          
                          title: Text(items[selectedString][i].value ),
                          onChanged: (bool value){
                              setState(()=>items[selectedString][i].checked = value);
                          },
                        );
                    },

                  )
                  
                  //  Column(
                  //   children: <Widget>[
                  //     ListTile(title:Text("title"),),
                  //     ListTile(title:Text("title"),)
                  //   ],
                  // ),

                ),                
              // Text("data"),
              // Text("data"),

            // Column(
            //   children: <Widget>[
            //     ListTile(title: Text("Brand"),),
            //     ListTile(title: Text("Colors"),),
            //     ListTile(title: Text("Size"),)
            //   ],
            // ),

            // Column(
            //   children: <Widget>[
            //     ListTile(title: Text("Brand"),),
            //     ListTile(title: Text("Colors"),),
            //     ListTile(title: Text("Size"),)
            //   ],           
            // )

            ],
          ),
        ),

          bottomNavigationBar: BottomAppBar(
            child: InkWell(
                onTap: (){
                  
                  Navigator.pop(context,sort_list[0]);                  
                  // Navigator.pop(context,MaterialPageRoute(
                  //   builder:(context)=>ListPage(
                  //     // product: products,
                  //     list: sort_list[0],
                  //   )
                  //  ));


                  },
                child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.sort,
                    // color: Colors.white,
                    // size: 22,
                    // ),
                    // SizedBox(width: 10,),
                    Text("Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                    )
                  ],
                ),
              ),
            ),
            color: Colors.green,
            
          )



        // body: ListView(
          
        //   children: <Widget>[
            
        //     Column(
        //       children: <Widget>[
        //         ListTile(title: Text("Brand"),),
        //         ListTile(title: Text("Colors"),),
        //         ListTile(title: Text("Size"),)
        //       ],
        //     ),
        //     Column(
        //       children: <Widget>[
        //         ListTile(title: Text("Brand"),),
        //         ListTile(title: Text("Colors"),),
        //         ListTile(title: Text("Size"),)
        //       ],           
        //     )
        //   ],
        // )
        // Text("Sort And Filter"),
      );
    }
    selectString(string) {
    setState(() {
      selectedString = string;
    });
  }
}