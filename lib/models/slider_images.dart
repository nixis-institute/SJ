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
    imageUrl: 'assets/slider/1.JPG',
    name: 'Get 50% Off',
    discount: 2,
    price: 175,
  ),
  SliderImages(
    imageUrl: 'assets/slider/2.JPG',
    name: 'Tranding',
    discount: 5,
    price: 300,
  ),
  SliderImages(
    imageUrl: 'assets/slider/3.JPG',
    name: 'Special Deals',
    price: 240,
    discount: 0
  ),
  SliderImages(
    imageUrl: 'assets/slider/4.JPG',
    name: 'Exclusive',
    price: 100,
    discount: 1
  ),
];