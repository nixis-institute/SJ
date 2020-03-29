import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/models/filter_model.dart';
import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/subcategory_model.dart';
import 'package:shopping_junction/screens/listpage_screen%20copy.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';

class SortAndFilter extends StatefulWidget{
  @override
  var items ={};
  String id;
  final List<Filter_Model> list;
  SortAndFilter({this.items=null,this.list=null,this.id});
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
  void createFilterList(){
        filter_list.forEach((f)=>{
        items[f.type] = f.list.map((item)=>_ListItem(item,false)).toList()
      });
  }

  void getFilter() async{
    filter_list.clear();
    // print(this.widget.id);
     GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(getFilterQuery),
        variables:{
          "id":this.widget.id
        }
      )
    );
    if(result.loading)
    {
      setState(() {
        loading = true;
      });
    }

    if(!result.hasException){


      
      // List data = result.data["filtering"][0]["data"];
      // for(int i=0;i<data.length;i++){
      //   List<String> temp =[];
      //   for(int j=0;j<data[i]["value"].length;j++)
      //   {
      //     temp.add(data[i]["value"][j].toString());
      //   }
      //   filter_list.add(Filter_Model(data[i]["key"], temp));
      // }

      List data = result.data["filterById"];
      List<String> size =[];
      List<String> color =[];
      List<String> brand =[];

      for(int i=0;i<data.length;i++)
      {
          if(!brand.contains(data[i]["brand"]))
          brand.add(data[i]["brand"]);

          for(int j=0;j<data[i]["subproductSet"]["edges"].length;j++)
          {
            if(!size.contains(data[i]["subproductSet"]["edges"][j]["node"]["size"]))
            {size.add(data[i]["subproductSet"]["edges"][j]["node"]["size"]);}

            if(!color.contains(data[i]["subproductSet"]["edges"][j]["node"]["color"]))
            {color.add(data[i]["subproductSet"]["edges"][j]["node"]["color"]);}
          }
      }
      filter_list.add(Filter_Model("Brands", brand));
      filter_list.add(Filter_Model("Size", size));
      filter_list.add(Filter_Model("Color", color));
      // filter_list.add("Brands","")

      // size = size.toSet().toList();
      // size = size.toSet().toList();
      // size = size.toSet().toList();
      




      setState(() {
        filter_list.forEach((f)=>{
          items[f.type] = f.list.map((item)=>_ListItem(item,false)).toList()
        });
        selectedString = filter_list[0].type;
        loading=false;
      });
    }

    // print(items);

  }



    var selectedString;


    var items = {};
    // var its={};
    String brands="";
    String sizes="";
    bool isAllClear = true;
    bool loading = true;
    
    @override
    void initState()
    {
      super.initState();


    if(this.widget.items==null)
    {
      getFilter();
      createFilterList();
    }
    else{

      setState(() {
        loading = false;
        items = this.widget.items;
        filter_list = this.widget.list;
        selectedString = filter_list[0].type;
      });

    }


    }
    

    Widget build(BuildContext context)
    {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Filters"),
          actions: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    createFilterList();
                    isAllClear = true;
                    Navigator.pop(context,{"items":items,"isClearAll":isAllClear});
                  },
                  child: Text("Clear All Filter",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                SizedBox(width: 15,)
              ],
            )
          ],  


        ),
        body: loading?Center(child:CircularProgressIndicator()):
        Container(
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
                    itemCount: filter_list.length,

                    itemBuilder: (context,index){
                      return Container(
                        color:filter_list[index].type == selectedString?
                        Colors.grey[100]:Colors.white,
                        child: ListTile(
                          title:Text(
                            filter_list[index].type,
                            style: TextStyle(
                              color:filter_list[index].type == selectedString?
                              Colors.blue:Colors.black,
                              ),
                            ),
// items = filter_models.prd[selectedString].map((item)=>_ListItem(item,false)).toList();

                          // onTap: () =>setState(()=> selectedString = filters[index]) 
                            onTap: (){
                              setState(() {
                                selectedString = filter_list[index].type;

                                // filter_list[index].list[]
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
                    items.forEach((f,x)=>{
                      items[f].forEach((i){
                        if( f=="Brands" && i.checked==true)
                        {
                          brands+="${i.value},";
                        }
                        else if(f=="Size" && i.checked==true)
                        {
                          sizes+=i.value+",";
                        }
                      })
                    });


                    items.forEach((f,x)=>{
                      items[f].forEach((i){
                        if(i.checked)
                        {
                          isAllClear = false;
                          // break;
                        }

                      })
                    });
                  
                  // Navigator.pop(context,{items,filter_list}); 

                  Navigator.pop(context,{"items":items,"isClearAll":isAllClear,"filter":{"brands":brands,"size":sizes,"filter_list":filter_list}});

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