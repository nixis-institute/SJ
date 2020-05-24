part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class FetchCartCount extends CartEvent {}

class CartLoading extends CartEvent {}