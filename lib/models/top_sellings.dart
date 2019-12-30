class TopSelling {
  String imageUrl;
  String name;
  int count;
  int price;

  TopSelling({
    this.imageUrl,
    this.name,
    this.count,
    this.price,
  });
}

final List<TopSelling> top_sellings = [
  TopSelling(
    imageUrl: 'assets/products/top_selling/1.jpg',
    name: "Women's pents",
    count: 100,
    price: 175,
  ),
  TopSelling(
    imageUrl: 'assets/products/top_selling/2.jpg',
    name: "Men's Shoes",
    count: 120,
    price: 300,
  ),
  TopSelling(
    imageUrl: 'assets/products/top_selling/3.jpg',
    name: 'T-Shirt',
    price: 240,
    count: 200
  ),
  TopSelling(
    imageUrl: 'assets/products/top_selling/4.jpg',
    name: "Women's Top",
    price: 100,
    count: 150
  ),

];