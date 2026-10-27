abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesFailureState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<dynamic> categories;

  CategoriesSuccessState({required this.categories});
}