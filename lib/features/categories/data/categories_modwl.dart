class CategoriesModel{
  final String name,coverPictureUrl;

  CategoriesModel({required this.name, required this.coverPictureUrl});

  factory CategoriesModel.fromJson(Map<String,dynamic>json){
    return CategoriesModel(
      name: json["name"]?? "",
      coverPictureUrl: json["coverPictureUrl"]?? "",
    );
  }
}