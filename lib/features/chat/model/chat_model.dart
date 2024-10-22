class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? imageUrl;
  String? stickerUrl;
  String? filePath;
  //String? fileName; // New field to store file name

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.imageUrl,
    this.stickerUrl,
    this.filePath,
    //this.fileName
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'imageUrl': imageUrl,
      'stickerUrl': stickerUrl,
      'filePath': filePath,   // Add file URL to the map
      //'fileName': fileName, // Add file name to the map
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
      filePath: json['filePath'],   // Parse file URL
      //fileName: json['fileName'], // Parse file name
    );
  }
}
