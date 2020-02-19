import 'dart:ffi';

class ProductImage{
  String id;
  String imgUrl;
  ProductImage(this.id,this.imgUrl);
}


class Product{
  String id;
  String name;
  double listPrice;
  double mrp;
  List sizes;
  List imageLink;
  List<ProductImage> images;
  Product(this.id,this.name,this.listPrice,this.mrp,this.images,this.sizes,this.imageLink);
}

class TypeAndProduct{
  String id;
  String name;
  String endCursor;
  List<Product> product;
  TypeAndProduct(this.id,this.name,this.product,this.endCursor);

}