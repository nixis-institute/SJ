// import 'package:shopping_junction/models/products.dart';

// import 'dart:ffi';

import 'package:shopping_junction/models/productAndCat.dart';
// class Cart{
//   List<CartProduct> products;
  
//   Cart({
//     this.products
//   });
// }

// Cart cart = 
//   Cart(
//     products: cart_product
//   );




class CartProductModel{
  // Product product;
  String id;
  String img;
  String name;
  double mrp;
  double listPrice;
  String selectedSize;
  int qty;
  CartProductModel(this.id,this.name,this.img,this.mrp,this.listPrice,this.selectedSize,this.qty);
}

// List<CartProduct> cart_product = [
//   CartProduct(
//     selectedSize: 'S',
//     qty:2 ,
//     product:Product(
//       imageUrl:  'assets/products/men/topwear/3.jpg',
//       name : 'Pink wear',
//       price: 430,
//       mrp: 630,
//       sizes: ['S','M','L','XL','3XL']
//     ),
//   ),


//     CartProduct(
//     selectedSize: 'XL',
//     qty:5 ,
//     product:Product(
//     imageUrl:  'assets/products/men/topwear/4.jpg',
//     name : 'Blue topwear',
//     price: 490,
//     mrp: 830,
//     sizes: ['S','XL','XLL']
//   )),

//     CartProduct(
//     selectedSize: 'L',
//     qty:1 ,
//     product:Product(
//     imageUrl:  'assets/products/men/topwear/5.jpg',
//     name : 'Black and White',
//     price: 590,
//     mrp: 830,
//     sizes: ['S','L','XL']
//   )),

// ];



