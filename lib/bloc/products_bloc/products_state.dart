part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class Loading extends ProductsState{}

class LoadingMore extends ProductsState{}

class LoadProductAndType extends ProductsState{
  List<TypeAndProduct> product;
  LoadProductAndType(this.product);
}
