// class CategoryResponse {
//   final String messages;
//   final List<Category> categorey;
//
//   CategoryResponse({
//     required this.messages,
//     required this.categorey,
//   });
//
//   factory CategoryResponse.fromJson(Map<String, dynamic> json) {
//     var list = json['categoey'] as List;
//     List<Category> categoryList = list.map((i) => Category.fromJson(i)).toList();
//
//     return CategoryResponse(
//       messages: json['messages'],
//       categorey: categoryList,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'messages': messages,
//       'categoey': categorey.map((category) => category.toJson()).toList(),
//     };
//   }
// }
//
// class Category {
//   final int id;
//   final String titel;
//   final String image;
//   final bool? isActive;
//
//   Category({
//     required this.id,
//     required this.titel,
//     required this.image,
//     this.isActive,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       titel: json['titel'],
//       image: json['image'],
//       isActive: json['isActive'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'titel': titel,
//       'image': image,
//       'isActive': isActive,
//     };
//   }
// }

class Category {
  final int id;
  final String titel;
  final String image;
  final bool? isActive;

  Category({required this.id, required this.titel, required this.image,  this.isActive});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      titel: json['titel'], // corrected to match the JSON key
      image: json['image'],
      isActive: json['isActive'],
    );
  }
}

