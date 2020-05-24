import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction/bloc/orders_bloc/orders_repository.dart';
import 'package:shopping_junction/models/orders_product.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  
  OrdersRepository repository;
  OrdersBloc({this.repository});
  @override
  OrdersState get initialState => OrdersInitial();

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is FetchOrders){
      yield LoadingOrders();
      final data = await repository.getAllOrders();
      yield LoadOrders(orders: data);
    }
  }
}

