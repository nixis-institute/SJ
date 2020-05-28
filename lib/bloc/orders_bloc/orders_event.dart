part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class FetchOrders extends OrdersEvent{}

class OnUpdateOrder extends OrdersEvent{
  // String status;
  // String id;
  Orders order;
  OnUpdateOrder({this.order});
}