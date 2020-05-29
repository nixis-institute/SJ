part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class FetchProductDetail extends ProductsEvent{
  String id;
  FetchProductDetail({this.id});
}
