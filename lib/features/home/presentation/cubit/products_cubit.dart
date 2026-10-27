import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stark/features/home/data/data_source/products_data_source.dart';
import 'package:stark/features/home/presentation/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsInitialState());

  final ProductsDataSource remoteDataSource = ProductsDataSource();


  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    try {
      final products = await remoteDataSource.getProducts();

      emit(ProductsSuccessState(
        products: products,
      ));
    }on DioException catch (e) {
      if(e.type == DioExceptionType.connectionTimeout
      || e.type == DioExceptionType.receiveTimeout){
        emit(ProductsFailiurState(message: "Request timeout"));
      }
      else if(e.type== DioExceptionType.connectionError){
        emit(ProductsFailiurState(message:"No Internet Connection"));
      }
      else{
        emit(ProductsFailiurState(message: "Server Error"));
      }
    }
    catch(e){
      emit(ProductsFailiurState(message: "Unexpected error"));
    }
  }

}