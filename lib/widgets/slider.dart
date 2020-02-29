import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping_junction/models/slider_images.dart';
class TopSlider extends StatefulWidget{
  @override
  _TopSliderState createState() => _TopSliderState();

}






class _TopSliderState extends State<TopSlider>
{
  @override
  var _current;

  void initState()
  {
    setState(() {
      _current = 1;
    });
  }

  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        CarouselSlider(
            height: 200,
            aspectRatio: 16/9,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index){
              setState(() {
                _current = index;
              });
            },
            
            
            items : slider_images.map((f){
              return new Builder(
                builder : (BuildContext context){
                  return new Container(
                    width: MediaQuery.of(context).size.width,
                    // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    // margin: new EdgeInsets.symmetric(horizontal: 5.0),
          
                    decoration: new BoxDecoration(
                      color: Colors.black,
                                       
                      image: DecorationImage(
                        image: AssetImage(f.imageUrl),
                        fit: BoxFit.cover
                        
                      )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.green.withOpacity(0.0),
                            Colors.green.withOpacity(0.0),
                          ]
                        )
                      ),

                      // child: Padding(
                      //   padding: const EdgeInsets.only(top:100.0,left:10.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       Text(
                      //         f.name,style: TextStyle(fontSize: 29,fontWeight: FontWeight.w800,color: Colors.white,shadows:[Shadow(color: Colors.black,offset: Offset(1, 2),blurRadius:7)] ),
                      //         ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top:50.0),
                      //         child: Row(
                      //           children: <Widget>[
                      //             Text('Shop it',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,color: Colors.white,shadows:[Shadow(color: Colors.black,offset: Offset(1, 2),blurRadius:7)]),),
                      //             SizedBox(width: 5,),
                      //             Icon(Icons.arrow_forward,color: Colors.white,size: 14,)
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  );
                }
              );
            }).toList()
        ),

      // SizedBox(height: 10,),

      Container(
        height: 30,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 10),
          itemCount: slider_images.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index)
          {
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.2)),
            );


          }
          ),
      )


      // Row(
      //   children: <Widget>[
      //     Container(
      //       width: 8,
      //       height: 8,
      //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      //       decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: _current == 1
      //           ? Color.fromRGBO(0, 0, 0, 0.9)
      //           : Color.fromRGBO(0, 0, 0, 0.4)),
      //       ),
      //   ],
      // )






      // ListView.builder(
      //   shrinkWrap: true,
      //   scrollDirection: Axis.horizontal,
      //   itemCount: slider_images.length,
      //   itemBuilder: (BuildContext context, int index){
      //     return Container(
      //       width: 8,
      //       height: 8,
      //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      //       decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: _current == index
      //           ? Color.fromRGBO(0, 0, 0, 0.9)
      //           : Color.fromRGBO(0, 0, 0, 0.4)),              
      //       );
      //   }
      // ),

      ],
    );
  }
}