
// import 'package:shopping_junction/models/products.dart' as prefix0;
import 'package:shopping_junction/models/slide_content.dart';
import 'package:shopping_junction/models/subcategory.dart';
import 'package:shopping_junction/models/subcategory_model.dart';

class Category {
  String imageUrl;
  String name;
  double discount;
  int price;
  List<SlideContent> slider;
  List<SubList> list;

  Category({
    this.imageUrl,
    this.name,
    this.discount,
    this.price,
    this.slider,
    this.list
  });
}


final List<Category> category_model = [
  Category(
    imageUrl: 'assets/category/1.jpg',
    name: 'Men',
    discount: 2,
    price: 175,
    slider: men_slider,
    list: sublist
  ),

  
  Category(
    imageUrl: 'assets/category/2.jpg',
    name: 'Women',
    discount: 5,
    price: 300,
    slider: women_slider,
    list: sublist
  ),
  Category(
    imageUrl: 'assets/category/3.jpg',
    name: 'Adult',
    price: 240,
    discount: 0,
    slider: women_slider,
    list: sublist
  ),
  Category(
    imageUrl: 'assets/category/4.jpg',
    name: 'Child',
    price: 100,
    discount: 1,
    slider: women_slider,
    list: sublist
  ),

];

final List<SlideContent> women_slider = [  
  SlideContent(
    imageUrl: 'assets/slider/1.JPG',
    name: 'Tranding',
    discount: 5,
    price: 300,
    
  ),
  SlideContent(
    imageUrl: 'assets/slider/2.JPG',
    name: 'Special Deals',
    price: 240,
    discount: 0
  ),
  SlideContent(
    imageUrl: 'assets/slider/3.JPG',
    name: 'Exclusive',
    price: 100,
    discount: 1
  ),
   SlideContent(
    imageUrl: 'assets/slider/4.JPG',
    name: 'Exclusive',
    price: 100,
    discount: 1
  ), 
];

final List<SlideContent> men_slider = [
  SlideContent(
    imageUrl: 'assets/slider/5.jpg',
    name: 'Tranding',
    discount: 5,
    price: 300,
  ),
  SlideContent(
    imageUrl: 'assets/slider/6.jpg',
    name: 'Special Deals',
    price: 240,
    discount: 0
  ),
  SlideContent(
    imageUrl: 'assets/slider/7.jpg',
    name: 'Exclusive',
    price: 100,
    discount: 1
  ),
];



final List<SubList> sublist = [
  SubList(
    name: "Topwear",
    subCateogry:  top_wear_subcategory, 
    ),
  SubList(name: "Bottomwear",
    subCateogry: bottom_wear_subcategory,
  ),

  SubList(name: "Sportwear",
  subCateogry: bottom_wear_subcategory
  ),
  SubList(name: "Festivalwear",
  subCateogry: bottom_wear_subcategory
  ),
  SubList(name: "Plus Size",
  subCateogry: bottom_wear_subcategory
  ),
  SubList(name: "FootWear",
  subCateogry: bottom_wear_subcategory
  ),
  SubList(name: "Watches",
  subCateogry: bottom_wear_subcategory),
  
  // Lst(name: "Topwear"),
];
