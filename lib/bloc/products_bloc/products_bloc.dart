import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  @override
  ProductsState get initialState => ProductsInitial();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
