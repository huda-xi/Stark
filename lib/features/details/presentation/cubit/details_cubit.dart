import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stark/features/details/data/data_source/details_data_source.dart';
import 'package:stark/features/details/presentation/cubit/details_states.dart';

class DetailsCubit extends Cubit<DetailsStates> {
  DetailsCubit() : super(DetailsInitial());

  final DetailsDataSource remoteDataSource = DetailsDataSource();

  Future<void> getdetails(String id) async{
    emit(DetailsLoading());

    try {
      final details = await remoteDataSource.getDetails(id);

      emit(DetailsSuccess(details));
    }on DioException catch (e) {
      if(e.type == DioExceptionType.connectionTimeout
      || e.type == DioExceptionType.receiveTimeout){
        emit(DetailsFailure(message: "Request timeout"));
      }
      else if(e.type== DioExceptionType.connectionError){
        emit(DetailsFailure(message:"No Internet Connection"));
      }
      else{
        emit(DetailsFailure(message: "Server Error"));
      }
    }
    catch(e){
      log("error: $e");
      emit(DetailsFailure(message: "Unexpected error"));
    }
  }
}
