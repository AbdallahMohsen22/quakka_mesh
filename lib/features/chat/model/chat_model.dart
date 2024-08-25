class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? imageUrl;
  String? stickerUrl;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.imageUrl,
    this.stickerUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'imageUrl': imageUrl,
      'stickerUrl': stickerUrl,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      dateTime: json['dateTime'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      stickerUrl: json['stickerUrl'],
    );
  }
}
