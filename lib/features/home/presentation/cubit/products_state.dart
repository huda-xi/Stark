
import 'package:stark/features/home/data/models/products_model.dart';

abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates{}

class ProductsLoadingState extends ProductsStates{}

class ProductsSuccessState extends ProductsStates {
  final List<ProductsModel> products;

  ProductsSuccessState({
    required this.products,
  });

  ProductsSuccessState copyWith({
    List<ProductsModel>? products,
  }) {
    return ProductsSuccessState(
      products: products ?? this.products,
    );
  }
}

class ProductsFailiurState extends ProductsStates{
  final String message;

  ProductsFailiurState({required this.message});
}