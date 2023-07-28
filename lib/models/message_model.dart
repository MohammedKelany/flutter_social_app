class MessageModel{
  final String? text;
  final String? senderId;
  final String? receiverId;
  final String? dateTime;

  MessageModel({
    this.dateTime,
    this.text,
    this.senderId,
    this.receiverId,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String?,
        senderId = json['senderId'] as String?,
        receiverId = json['receiverId'] as String?,
        dateTime = json['dateTime'] as String?;

  Map<String, dynamic> toJson() => {
    'text': text,
    'senderId': senderId,
    'receiverId': receiverId,
    'dateTime': dateTime
  };
}