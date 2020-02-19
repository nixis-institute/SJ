import 'package:shopping_junction/models/products.dart';
import 'package:shopping_junction/models/products.dart' as prefix0;


class ProductSubCategory{
  String id;
  String name;
  ProductSubCategory(this.id,this.name);
}

class SubCategory{
  String name;
  List<Product> products;
  

  SubCategory(
    {this.name,
    this.products,
    });
}

final List<SubCategory> top_wear_subcategory=[
  SubCategory(name: "T-Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
];


final List<SubCategory> sorted_categories=[
  SubCategory(name: "T-Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
  // SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
  // SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
];


final List<SubCategory> bottom_wear_subcategory=[
  SubCategory(name: "T-Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
  SubCategory(name: "Casual Shirts",products: prefix0.tshirts),
];