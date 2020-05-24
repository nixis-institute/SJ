class Orders{
  String orderId;
  String sellerName;
  String status;
  String productId;
  String productName;
  String date;
  int qty;
  String size;
  String color;
  double mrp;
  double discount;
  double coupon;
  double price;
  String paymentMode;
  String imgLink;
  Orders(this.orderId,this.status,this.productId,this.productName,this.date,this.qty,this.size,this.color,this.mrp, this.price,this.discount,this.coupon, this.paymentMode,this.imgLink,this.sellerName);
}

// class OrderAddress{
//   String id;
//   String houseNo;

// }