class ProductsModel {
  final String coverPictureUrl, name;
  final double price;
  final String id;
  final String categories;

  ProductsModel({
    required this.coverPictureUrl,
    required this.name,
    required this.price,
    required this.id,
    required this.categories,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
     final categoriesData = json['categories'];
     
    return ProductsModel(
      name: json["name"]??'',
      coverPictureUrl: json["coverPictureUrl"]?.toString()??'',
      price: (json["price"] as num).toDouble(),
      id: json["id"]?.toString() ?? "",
      
      categories: categoriesData is List
          ? categoriesData.map((e) => e.toString()).join(', '):'',
          
    );
  }
}
