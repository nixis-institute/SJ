part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class FetchOrders extends OrdersEvent{}