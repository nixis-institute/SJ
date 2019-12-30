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
                  color: Colors.amber,
                  image: DecorationImage(
                    image: AssetImage(f.imageUrl),
                    fit: BoxFit.cover
                  )
                ),
                child: Text(f.name),
              );
            }
          );
        }).toList()
    );
  }
}