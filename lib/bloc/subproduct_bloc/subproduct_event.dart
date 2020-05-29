part of 'subproduct_bloc.dart';

@immutable
abstract class SubproductEvent {}

class FetchSubProducts extends SubproductEvent{
  String id;
  FetchSubProducts(this.id);
} 
class OnAddToCart extends SubproductEvent{
  List<SubProduct> prd;
  OnAddToCart({this.prd});
} 
class OnRemoveFromCart extends SubproductEvent{
  String prd;
  OnRemoveFromCart({this.prd});
}