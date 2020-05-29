import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction/bloc/subproduct_bloc/subproduct_repository.dart';
import 'package:shopping_junction/models/productAndCat.dart';

part 'subproduct_event.dart';
part 'subproduct_state.dart';

class SubproductBloc extends Bloc<SubproductEvent, SubproductState> {
  SubProductRepository repository;
  SubproductBloc({this.repository});
  @override
  SubproductState get initialState => SubproductInitial();
  // SubProductRepository repository = SubProductRepository();
  @override
  Stream<SubproductState> mapEventToState(
    SubproductEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if(event is FetchSubProducts)
    {
      yield Loading();
      // repository
      // print(event.id);
      final data = await repository.getSubProductByProductID(event.id);
      yield LoadSubProduct(subproduct:data["product"],sizes: data["size"],colors: data["color"] );
    }

    if(event is OnAddToCart){
      final product = (state as LoadSubProduct);
      yield LoadSubProduct(subproduct: product.subproduct,colors: product.colors,sizes: product.sizes);
    }
    if(event is OnRemoveFromCart){
      // final product = (state as LoadSubProduct).subproduct.map((e){
      //   e.id==event.prd?
      //     e.isInCart = false
      //     return e
      //   }
    List<SubProduct> subprd;
    print((state as LoadSubProduct).subproduct.length);
    print(event.prd);

    (state as LoadSubProduct).subproduct.forEach(
      (element) {
        print(element.id);
        if(element.id==event.prd)
        {
          element.isInCart = false;
          subprd.add(element);
        }
        else{
          print(element.listPrice);
          subprd.add(element);
        }
      });      

      yield LoadSubProduct(subproduct: subprd,colors: (state as LoadSubProduct).colors,sizes: (state as LoadSubProduct).sizes);
    }
  }
}
