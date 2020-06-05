part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class FetchProductDetail extends ProductsEvent{
  String id;
  FetchProductDetail({this.id});
}

class FetchProductAndType extends ProductsEvent{
  String id;
  String brand;
  String size;
  String color;
  String ordering;
  FetchProductAndType({this.id,this.brand,this.size,this.color,this.ordering});
}


class FetchMoreProductAndType extends ProductsEvent{
  String id;
  String brand;
  String after;
  String size;
  String color;
  String ordering;
  FetchMoreProductAndType({this.id,this.after,this.brand,this.size,this.color,this.ordering});
}
