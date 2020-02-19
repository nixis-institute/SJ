class Product {
  String imageUrl;
  String name;
  double discount;
  int price;
  int mrp;
  List<String> sizes;

  Product({
    this.imageUrl,
    this.name,
    this.discount,
    this.price,
    this.mrp,
    this.sizes,
  });

  getImgUrl() => this.imageUrl;
  getName() => this.name;
  getDiscount() => this.discount;
  getPrice() => this.price;
  getMrp() =>this.price;
  getSizes() =>this.price;
}

final List<Product> men_bottomwear = [
  Product(
    imageUrl:  'assets/products/men/bottomwear/1.jpg',
    name : 'Blue topwear',
    price: 500,
    mrp: 760,
    sizes: ['S','L','XL']
  ),
  Product(
    imageUrl:  'assets/products/men/bottomwear/2.jpg',
    name : 'Exclusive Jacket',
    price: 1500,
    mrp: 1920,
    sizes: ['L','XL','XXL']
  ),
  Product(
    imageUrl:  'assets/products/men/bottomwear/3.jpg',
    name : 'Pink wear',
    price: 430,
    mrp: 630,
    sizes: ['L','XL','XLL']
  ),
  Product(
    imageUrl:  'assets/products/men/bottomwear/4.jpg',
    name : 'Blue bottomwear',
    price: 490,
    mrp: 830,
    sizes: ['S','M','L','XL','XLL','3XL']
  ),
  Product(
    imageUrl:  'assets/products/men/bottomwear/5.jpg',
    name : 'Black and White',
    price: 590,
    mrp: 830,
    sizes: ['XLL','3XL']
  ),
  Product(
    imageUrl:  'assets/products/men/bottomwear/6.jpg',
    name : 'Black bottomwear',
    price: 790,
    mrp: 820,
    sizes: ['M','XLL','3XL']
  ),  
];



final List<Product> tshirts = [
  Product(
    imageUrl:  'assets/products/men/topwear/1.jpg',
    name : 'Blue topwear',
    price: 500,
    mrp: 760,
    sizes: ['S','M','L','XL','XLL','3XL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/2.jpg',
    name : 'Exclusive Jacket',
    price: 1500,
    sizes: ['S','M','L','XL'],
    mrp: 1920,
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/3.jpg',
    name : 'Pink wear',
    price: 430,
    mrp: 630,
    sizes: ['S','M','L','XL','3XL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/4.jpg',
    name : 'Blue topwear',
    price: 490,
    mrp: 830,
    sizes: ['S','XL','XLL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/5.jpg',
    name : 'Black and White',
    price: 590,
    mrp: 830,
    sizes: ['S','L','XL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/6.jpg',
    name : 'Black topwear',
    price: 790,
    mrp: 820,
    sizes: ['L','XLL']
  ),  
];



final List<Product> casual_shirts = [
  Product(
    imageUrl:  'assets/products/men/topwear/1.jpg',
    name : 'Blue topwear',
    price: 500,
    mrp: 760,
    sizes: ['S','M','L','XL','XLL','3XL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/2.jpg',
    name : 'Exclusive Jacket',
    price: 1500,
    sizes: ['S','M','L','XL'],
    mrp: 1920,
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/3.jpg',
    name : 'Pink wear',
    price: 430,
    mrp: 630,
    sizes: ['S','M','L','XL','3XL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/4.jpg',
    name : 'Blue topwear',
    price: 490,
    mrp: 830,
    sizes: ['S','XL','XLL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/5.jpg',
    name : 'Black and White',
    price: 590,
    mrp: 830,
    sizes: ['S','L','XL']
  ),
  Product(
    imageUrl:  'assets/products/men/topwear/6.jpg',
    name : 'Black topwear',
    price: 790,
    mrp: 820,
    sizes: ['L','XLL']
  ),  
];


final List<Product> products = [
  Product(
    imageUrl: 'assets/products/tops/1.jpg',
    name: 'ives top',
    discount: 2,
    price: 175,
  ),
  Product(
    imageUrl: 'assets/products/tops/2.jpg',
    name: 'Green Cotton',
    discount: 5,
    price: 300,
  ),
  Product(
    imageUrl: 'assets/products/tops/3.jpg',
    name: 'Van Hesus',
    price: 240,
    discount: 0
  ),
  Product(
    imageUrl: 'assets/products/tops/4.jpg',
    name: 'Solly Tees',
    price: 100,
    discount: 1
  ),

];