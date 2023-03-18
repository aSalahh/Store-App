import 'dart:html';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store/blocs/product_bloc/product_event.dart';
import 'package:store/blocs/product_bloc/product_state.dart';
import 'package:store/services/repositories/product_repo.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState>{
  final ProductRepo repo;
  ProductsBloc(this.repo) :super(ProductLoadingState()){
    on<LoadProductEvent>((event, emit)async{
      emit(ProductLoadingState());
      try{
       final products=await repo.getAllProducts();
       emit(ProductLoadedState(products: products));
      }catch(e){
  emit(ProductsFailure(errorMessage: e.toString()));
      }
    });

  }
}