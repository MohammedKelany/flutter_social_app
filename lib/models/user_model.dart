class UserModel {
  final String? username;
  final String? userID;
  final String? email;
  final String? phoneNumber;
  final String? image;
  final String? cover;
  final String? bio;
  final bool? isVerified;

  UserModel({
    this.image="https://img.freepik.com/free-photo/young-man-student-with-notebooks-showing-thumb-up-approval-smiling-satisfied-blue-studio-background_1258-65597.jpg",
    this.cover =
        "https://img.freepik.com/free-photo/young-man-student-with-notebooks-showing-thumb-up-approval-smiling-satisfied-blue-studio-background_1258-65597.jpg",
    this.bio = "Wright Your bio...",
    this.username,
    this.userID,
    this.email,
    this.phoneNumber,
    this.isVerified = false,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String?,
        userID = json['userID'] as String?,
        email = json['email'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        image = json['image'] as String?,
        cover = json['cover'] as String?,
        bio = json['bio'] as String?,
        isVerified = json['isVerified'] as bool?;

  Map<String, dynamic> toJson() => {
        'username': username,
        'userID': userID,
        'email': email,
        'phoneNumber': phoneNumber,
        'image': image,
        'bio': bio,
        'cover': cover,
        'isVerified': isVerified,
      };
}
