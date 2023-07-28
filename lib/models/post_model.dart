class PostModel {
  String? username;
  String? uId;
  String? postImage;
  String? image;
  String? dateTime;
  String? text;

  PostModel({
    this.username,
    this.uId,
    this.postImage,
    this.image,
    this.dateTime,
    this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    username = json['username'] as String?;
    uId = json['uId'] as String?;
    postImage = json['postImage'] as String?;
    image = json['image'] as String?;
    dateTime = json['dateTime'] as String?;
    text = json['text'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['username'] = username;
    json['uId'] = uId;
    json['postImage'] = postImage;
    json['image'] = image;
    json['dateTime'] = dateTime;
    json['text'] = text;
    return json;
  }
}
