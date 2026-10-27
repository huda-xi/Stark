import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stark/features/categories/data/categories_data_sourse.dart';
import 'package:stark/features/categories/presentaion/cubit/categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitialState());
  final CategoriesDataSource remoteDataSource = CategoriesDataSource();
  
  
  
  Future<void> getCategories() async {
    emit(CategoriesLoadingState());
    await remoteDataSource.getCategories().then(
      (val) {
        emit(CategoriesSuccessState(categories: val));
      },
      onError: (e) {
        log("Categories Error: $e");
        emit(CategoriesFailureState());
      },
    );
  }}