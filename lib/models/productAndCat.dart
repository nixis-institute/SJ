import 'dart:ffi';

class ProductImage{
  String id;
  String largeImage;
  String normalImage;
  String thumImage;
  ProductImage(this.id,this.largeImage,this.normalImage,this.thumImage);
}

// class SubProduct{
//   String id;
//   String name;
//   double listPrice;
//   double mrp;
//   List sizes;
//   List imageLink;
//   List<ProductImage> images;
//   SubProduct(this.id,this.name,this.listPrice,this.mrp,this.images,this.sizes,this.imageLink);  
// }
class SubProduct{
  String id;
  double listPrice;
  double mrp;
  int qty;
  String size,color;
  bool isInCart;
  List<ProductImage> images;
  SubProduct(this.id,this.listPrice,this.mrp,this.size,this.color,this.qty,this.isInCart,this.images);

}

class SizeMapping{
  dynamic sizeToColor;
  SizeMapping({this.sizeToColor});
}

class ColorMapping{
  dynamic colorToSize;
  ColorMapping({this.colorToSize});
}

class Product{
  String id;
  String name;
  double listPrice;
  double mrp;
  List sizes;
  List colors;
  bool isInCart;
  List imageLink;
  List<ProductImage> images;
  Product(this.id,this.name,this.listPrice,this.mrp,this.images,this.sizes,this.imageLink,{this.isInCart=false});
}

class TypeAndProduct{
  String id;
  String name;
  String endCursor;
  bool hasNextPage;
  List<Product> product;
  TypeAndProduct(this.id,this.name,this.product,this.endCursor,this.hasNextPage);

}