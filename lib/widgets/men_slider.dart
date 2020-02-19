import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping_junction/models/slide_content.dart';
// import 'package:shopping_junction/models/slider_images.dart';

class MainSlider extends StatefulWidget{
  final List<SlideContent> content;
  @override
  
  MainSlider({this.content});
  _MainSliderState createState() => _MainSliderState();

}


class _MainSliderState extends State<MainSlider>
{
  @override
  Widget build(BuildContext context){
    // print(this.widget.content);
    return CarouselSlider(
        height: 300,
        aspectRatio: 16/9,
        autoPlay: true,
        viewportFraction: 1.0,
        items : this.widget.content.map((f){
          return new Builder(
            builder : (BuildContext context){
              return new Container(
                width: MediaQuery.of(context).size.width,
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
                        Colors.green.withOpacity(0.5),
                        Colors.green.withOpacity(0.5),
                      ]
                    )
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(top:100.0,left:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(f.name,style: TextStyle(fontSize: 29,fontWeight: FontWeight.w800,color: Colors.white),),
                        Padding(
                          padding: const EdgeInsets.only(top:50.0),
                          child: Row(
                            children: <Widget>[
                              Text('Shop it',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,color: Colors.white),),

                              SizedBox(width: 5,),

                              Icon(Icons.arrow_forward,color: Colors.white,size: 14,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }).toList()
    );
  }
}