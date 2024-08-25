class Banner {
  final int id;
  final String title;
  final String image;
  final String createdDate;

  Banner({required this.id, required this.title, required this.image, required this.createdDate});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      createdDate: json['createdDate'],
    );
  }
}
