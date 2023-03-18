import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

abstract class ProductsState extends Equatable {
}

class ProductLoadingState extends ProductsState{
  @override
  List<Object?> get props => [];

}
class ProductLoadedState extends ProductsState{
  List<ProductModel> products;
  ProductLoadedState ({required this.products});
  @override
  List<Object?> get props => [products];

}
class ProductsFailure extends ProductsState {
   String errorMessage;

  ProductsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}