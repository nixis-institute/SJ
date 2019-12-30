import 'package:shopping_junction/models/products.dart';

class Cart{
  List<CartProduct> products;
  
  Cart({
    this.products
  });
}

Cart cart = 
  Cart(
    products: cart_product
  );




class CartProduct{
  Product product;
  String selectedSize;
  CartProduct({this.product,this.selectedSize});
}

List<CartProduct> cart_product = [
  CartProduct(
    selectedSize: 'S',
    product:Product(
      imageUrl:  'assets/products/men/topwear/3.jpg',
      name : 'Pink wear',
      price: 430,
      mrp: 630,
      sizes: ['S','M','L','XL','3XL']
    ),
  ),


    CartProduct(
    selectedSize: 'XL',
    product:Product(
    imageUrl:  'assets/products/men/topwear/4.jpg',
    name : 'Blue topwear',
    price: 490,
    mrp: 830,
    sizes: ['S','XL','XLL']
  )),

    CartProduct(
    selectedSize: 'L',
    product:Product(
    imageUrl:  'assets/products/men/topwear/5.jpg',
    name : 'Black and White',
    price: 590,
    mrp: 830,
    sizes: ['S','L','XL']
  )),

];



