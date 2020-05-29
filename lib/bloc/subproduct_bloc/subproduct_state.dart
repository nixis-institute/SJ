part of 'subproduct_bloc.dart';

@immutable
abstract class SubproductState {}

class SubproductInitial extends SubproductState {}

class Loading extends SubproductState {}

class LoadSubProduct extends SubproductState{
  List<SubProduct> subproduct;
  dynamic sizes;
  dynamic colors;
  LoadSubProduct({this.subproduct,this.sizes,this.colors});
}
