import 'dart:ffi';

class ProductImage{
  String id;
  String imgUrl;
  ProductImage(this.id,this.imgUrl);
}

class SubProduct{
  String id;
  String name;
  double listPrice;
  double mrp;
  List sizes;
  List imageLink;
  List<ProductImage> images;
  SubProduct(this.id,this.name,this.listPrice,this.mrp,this.images,this.sizes,this.imageLink);  
}

class Product{
  String id;
  String name;
  double listPrice;
  double mrp;
  List sizes;
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