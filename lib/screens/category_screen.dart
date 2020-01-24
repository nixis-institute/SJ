import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction/GraphQL/Queries.dart';
import 'package:shopping_junction/GraphQL/services.dart';
import 'package:shopping_junction/models/category_model.dart';
import 'package:shopping_junction/models/slide_content.dart';
import 'package:shopping_junction/models/subcategory_model.dart';
import 'package:shopping_junction/screens/listpage_screen.dart';
import 'package:shopping_junction/widgets/App_bar_custom.dart';
import 'package:shopping_junction/widgets/men_slider.dart';
// import 'package:shopping_junction/widgets/category.dart';

class CategoryScreen extends StatefulWidget{
  // final category_model category;
  final ProductCategory category;
  final List<SlideContent> slider;
  CategoryScreen({this.category,this.slider});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
{
  List<ProductSubCategory> subcategory = List<ProductSubCategory>();
  
  // List<SlideContent> sl = if(widget.category.name == "Men")

void fillSubCategory() async{
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(GetSubCategoryByCategoryId),
        variables:{"CateogryId":id}
      )
    );
    // if(result.loading)
    if(!result.hasException)
    {
      print("__data__");
      for(var i=0;i<result.data["subcateogryByCategoryId"]["edges"].length;i++)
        {
          print(result.data["subcateogryByCategoryId"]["edges"][i]["id"]);
          setState(() {
            subcategory.add(
              ProductSubCategory(
                result.data["subcateogryByCategoryId"]["edges"][i]["node"]["id"],
                result.data["subcateogryByCategoryId"]["edges"][i]["node"]["name"],
                // result.data["allCategory"]["edges"][i]["node"]["image"],
              ),
            );
          });
        }
    }    
}


  var id ="";
  @override
  void initState()
  {
    super.initState();
    setState(() {
      id = this.widget.category.id;
    });
    fillSubCategory();
  }


  Widget build(BuildContext context)
  {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.light,      
            statusBarBrightness:Brightness.dark           
        ),
        
        child: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                // color: Colors.blue
              ),

              // height: this.widget.category.list.length*60.1+300,
              height: this.subcategory.length*60.1+300,
              width: MediaQuery.of(context).size.width,
                child: Stack(
                overflow: Overflow.visible,
                children:<Widget>[
                  MainSlider(content: this.widget.slider),
                  CustomAppBar(name: this.widget.category.name),
                  Positioned(
                    top: 260,
                    // right: 0,
                    
                    // bottom: 2,

                    width: MediaQuery.of(context).size.width,

                    // height: MediaQuery.of(context).size.height,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(left: 12,right: 12),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: this.subcategory.length,
                        itemBuilder: (BuildContext context,int index){
                          return Center(
                            child: Card(
                                elevation: 0,
                                shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5
                                  )
                                ) ,
                                
                                child: InkWell(
                                
                                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ListPage(
                                  // product: this.widget.category.list[index].products,
                                  subCategory: this.subcategory[index]

                                ))),

                                    child: Container(
                                      // height: 70,
                                      child: ListTile(
                                      title: Text(this.subcategory[index].name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      trailing: Icon(Icons.keyboard_arrow_right,size:30,),
                                ),
                                    ),
                              ),
                            ),
                          );

                        },
                      ),
                    )
                    
                    //   ListView.builder(
                    //   itemCount: this.widget.category.list.length,
                    //   itemBuilder: (BuildContext build,int index){
                    //     return ListTile(
                    //       title: Text(this.widget.category.list[index].name),
                    //     );
                    //   },
                    // ),
                  )
                  // CustomAppBar(),                
                  // Positioned(
                  //   top: 240,
                  //   width: MediaQuery.of(context).size.width*1,
                  //   child: Category()
                  // )

                ],
              ),
            ),

            // SizedBox(height:this.widget.category.list.length*60.1),
            // Text("sdf"),
            // Text("sdf"),
            // Text("sdf"),
            // Text("sdf"),
            // Text("sdf"),
            // Text("sdf"),


          ],
        ),
      ),
    );
  }
}



