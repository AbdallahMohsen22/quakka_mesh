class Cart {
  final int id;
  final String title;
  final String imageDesign;
  final String receiver;
  final String sender;
  final String content;
  final int numberOfPoints;
  final bool isPremium;
  final bool isActive;
  final DateTime created;

  Cart({
    required this.id,
    required this.title,
    required this.imageDesign,
    required this.receiver,
    required this.sender,
    required this.content,
    required this.numberOfPoints,
    required this.isPremium,
    required this.isActive,
    required this.created,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      title: json['titel'],
      imageDesign: json['imageDesign'],
      receiver: json['receiver'],
      sender: json['sender'],
      content: json['content'],
      numberOfPoints: json['numberOfPoint'],
      isPremium: json['isPremium'],
      isActive: json['isActive'],
      created: DateTime.parse(json['created']),
    );
  }
}
