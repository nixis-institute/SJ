part of 'orders_bloc.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class LoadingOrders extends OrdersState{}

class LoadOrders extends OrdersState{
  List<Orders> orders;
  LoadOrders({this.orders});
}
