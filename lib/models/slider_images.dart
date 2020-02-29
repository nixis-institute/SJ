class SliderImages {
  String imageUrl;
  String name;
  double discount;
  int price;

  SliderImages({
    this.imageUrl,
    this.name,
    this.discount,
    this.price,
  });
}

final List<SliderImages> slider_images = [
  SliderImages(
    imageUrl: 'assets/banner/1.jpeg',
    name: 'Get 50% Off',
    discount: 2,
    price: 175,
  ),
  SliderImages(
    imageUrl: 'assets/banner/2.jpeg',
    name: 'Tranding',
    discount: 5,
    price: 300,
  ),
  SliderImages(
    imageUrl: 'assets/banner/3.jpeg',
    name: 'Special Deals',
    discount: 5,
    price: 300,
  ),  
  // SliderImages(
  //   imageUrl: 'assets/slider/3.jpeg',
  //   name: 'Special Deals',
  //   price: 240,
  //   discount: 0
  // ),


  // SliderImages(
  //   imageUrl: 'assets/slider/4.JPG',
  //   name: 'Exclusive',
  //   price: 100,
  //   discount: 1
  // ),
];