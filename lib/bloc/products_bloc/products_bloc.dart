import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction/bloc/products_bloc/product_repository.dart';
import 'package:shopping_junction/models/productAndCat.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository repository;
  ProductsBloc(this.repository);
  @override
  ProductsState get initialState => ProductsInitial();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is FetchProductAndType){
      yield Loading();
      final data = await repository.getSubListAndProductBySubCateogryId(event.id, event.brand, event.size, event.color, event.ordering);      
      yield LoadProductAndType(data);
    }
    if(event is FetchMoreProductAndType){
      // print("called");
      TypeAndProduct data = await repository.fetchProductAfterCursor(event.id,event.after,event.brand,event.size, event.color, event.ordering);
      // List<TypeAndProduct> products = (state as LoadProductAndType).product;
      // print((state as LoadProductAndType).product[0].product.length );
      print(data.id);
      print(event.id);
      print(data.product.length);

      List<TypeAndProduct> products = (state as LoadProductAndType).product.map((e) {
        if(e.id==event.id){
          // print("matchhhhhh");
          e.endCursor = data.endCursor;
          e.hasNextPage = data.hasNextPage;
          e.product.addAll(data.product);
          return e;
        }
        else{
          return e;
        }
      }).toList();

      // print(products[0].product.length);

      yield LoadProductAndType(products);



    }

  }
}
