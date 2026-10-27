
class DetailsModel {
  final String id;
  final String name;
  final String description;
  final String pictureUrl;
  final double price;
  final List<String> categories;
  final List<String> productPictures;

  DetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.price,
    required this.categories,
    required this.productPictures,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      pictureUrl: json['coverPictureUrl']?.toString() ?? '',
      price: double.tryParse(
            json['price']?.toString() ?? '',
          ) ??
          0.0,
      categories: List<String>.from(
        json['categories'] ?? [],
      ),
      productPictures: List<String>.from(
        json['productPictures'] ?? [],
      ),
    );
  }
}
