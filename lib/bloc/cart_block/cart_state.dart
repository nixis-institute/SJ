part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

// class CartLoading extends CartState {}

class CartCount extends CartState {
  int count;
  CartCount({this.count});
}