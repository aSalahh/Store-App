import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {

}
class LoadProductEvent extends ProductsEvent{
  @override
  List<Object?> get props => [];

}