
import 'package:stark/features/details/data/models/details_model.dart';

abstract class DetailsStates {}

class DetailsInitial extends DetailsStates {}

class DetailsLoading extends DetailsStates {}

class DetailsSuccess extends DetailsStates {
  final DetailsModel details;

  DetailsSuccess(this.details);
}

class DetailsFailure extends DetailsStates {
  final String message;
  DetailsFailure({required this.message});
}