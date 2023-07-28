import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/shared/network/local/catch_helper.dart';
import 'package:social_app/view/chats_screen.dart';
import 'package:social_app/view/feeds_screen.dart';
import 'package:social_app/view/login_screen.dart';
import 'package:social_app/view/post_screen.dart';
import 'package:social_app/view/settings_screen.dart';
import 'package:social_app/view/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/view/widgets/shared_components.dart';

class SocialController extends GetxController {
  UserModel? userModel;
  bool loading = false;
  bool profileLoading = false;
  bool coverLoading = false;
  List<int> likes = [];
  List<String> postsId = [];

  SocialController() {
    getUserData();
    getPosts();
    getAllUsers();
  }

  //Profile Editing Controller
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  File? profileImage;
  File? coverImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
    } else {
      print("Error while picking images");
    }
  }

  Future<void> getCoverImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      update();
    } else {
      print("Error while picking images");
    }
  }

  // End

  // Social Controller
  List<UserModel> userModels = [];

  void getAllUsers() {
    FirebaseFirestore.instance.collection("users").get().then(
      (value) {
        userModels = [];
        for (var element in value.docs) {
          if (element['userID'] != userModel!.userID) {
            userModels.add(UserModel.fromJson(element.data()));
          }
        }
        update();
      },
    ).catchError(
      (error) {
        print("error While fetching");
      },
    );
  }

  final storage = FirebaseStorage.instance;

  void getUserData() {
    update();
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        userModel = UserModel.fromJson(value.data()!);
        userNameController.text = userModel!.username!;
        bioController.text = userModel!.bio!;
        phoneController.text = userModel!.phoneNumber!;
        update();
        print("pppp");
      },
    ).catchError(
      (error) {
        print(error.toString());
      },
    );
  }

  void uploadCoverImage({
    required String username,
    required String bio,
    required String phone,
  }) {
    coverLoading = true;
    update();
    storage
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
            username: username,
            bio: bio,
            phone: phone,
            coverImage: value,
          );
          coverLoading = false;
          update();
        }).catchError(
          (onError) {
            print("bbbb");
          },
        );
      },
    ).catchError((h) {
      print("kkkk");
    });
  }

  void uploadProfileImage({
    required String username,
    required String bio,
    required String phone,
  }) {
    profileLoading = true;
    update();
    storage
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
            username: username,
            bio: bio,
            phone: phone,
            profileImage: value,
          );
          profileLoading = false;
          update();
        }).catchError(
          (onError) {
            print("bbbb");
          },
        );
      },
    ).catchError((h) {
      print("kkkk");
    });
  }

  void updateUserData({
    required String username,
    required String bio,
    required String phone,
    String? coverImage,
    String? profileImage,
  }) {
    UserModel model = UserModel(
      username: username,
      phoneNumber: phone,
      bio: bio,
      cover: coverImage ?? userModel!.cover,
      image: profileImage ?? userModel!.image,
      isVerified: true,
      email: userModel!.email,
      userID: userModel!.userID,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.userID)
        .update(model.toJson())
        .then(
      (value) {
        getUserData();
        update();
      },
    ).catchError(
      (error) {
        print("error while getting Posts");
      },
    );
  }

  //Making Likes

  void likePost(String id) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("likes")
        .doc(userModel!.userID)
        .set({
      'like': true,
    }).then(
      (value) {
        update();
      },
    ).catchError(
      (error) {},
    );
  }

  // Chatting
  List<MessageModel> messages = [];

  void sendMessages(String senderId, String text, String dateTime) {
    MessageModel model = MessageModel(
      text: text,
      receiverId: userModel!.userID,
      senderId: senderId,
      dateTime: dateTime,
    );
    //sending to me
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.userID)
        .collection("chats")
        .doc(senderId)
        .collection("messages")
        .add(model.toJson())
        .then(
      (value) {
        messageController.text = '';
        update();
      },
    ).catchError(
      (error) {
        print("Error While Sending To me");
      },
    );

    //Sending to sender
    FirebaseFirestore.instance
        .collection("users")
        .doc(senderId)
        .collection("chats")
        .doc(userModel!.userID)
        .collection("messages")
        .add(model.toJson())
        .then(
      (value) {
        update();
      },
    ).catchError(
      (error) {
        print("error While Sending To sender");
      },
    );
  }

  //get Messages
  TextEditingController messageController = TextEditingController();

  void getMessages(String senderId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.userID)
        .collection("chats")
        .doc(senderId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen(
      (event) {
        messages = [];
        event.docs.forEach((element) {
          messages.add(MessageModel.fromJson(element.data()));
          update();
        });
        print("messages $messages");
      },
    );
  }

  //Comments
  //Getting All Posts
  List<PostModel> posts = [];

  void getPosts() {
    FirebaseFirestore.instance.collection("posts").get().then(
      (value) {
        for (var element in value.docs) {
          element.reference.collection("likes").get().then(
            (value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(
                PostModel.fromJson(
                  element.data(),
                ),
              );
              update();
            },
          ).catchError(
            (error) {
              update();
              print("error while getting Posts");
            },
          );
        }
      },
    ).catchError(
      (onError) {},
    );
  }

  //Posts Controller
  File? postImage;
  PostModel? postModel;
  TextEditingController postTextController = TextEditingController();
  bool postLoading = false;

  Future<void> getPostImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      update();
    } else {
      print("Error while picking images");
    }
  }

  void createPost({
    required String text,
    String? image,
    required String dateTime,
  }) {
    postModel = PostModel(
      username: userModel!.username,
      uId: userModel!.userID,
      image: userModel!.image,
      postImage: image ?? "",
      text: text,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel!.toJson())
        .then((value) {
      getToast(text: "Post Created", state: ToastStates.SUCCESS);
      update();
    }).catchError((error) {
      print("Error While creating post");
    });
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    postLoading = true;
    update();
    storage
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          image: value,
          dateTime: dateTime,
        );
        postLoading = false;
        update();
      });
    }).catchError((error) {
      print("error while posting image");
    });
  }

  void removePostImage() {
    postImage = null;
    update();
  }

  int currentIndex = 0;

  int changeIndex(int index) {
    if (index == 2) {
      Get.to(() => const PostsScreen());
    } else if (index == 1) {
      getAllUsers();
      currentIndex = index;
      update();
    } else {
      currentIndex = index;
      update();
    }
    return currentIndex;
  }

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const PostsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bNBItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.chat_outlined,
      ),
      label: "Chats",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.post_add_outlined,
      ),
      label: "Posts",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.supervised_user_circle_outlined,
      ),
      label: "User",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings_outlined,
      ),
      label: "Settings",
    ),
  ];
  List<String> titles = [
    "Home",
    "Chats",
    "Posts",
    "Users",
    "Settings",
  ];

  //SignOut
  void signOut() {
    uId = null;
    CacheHelper.remove("uId");
    FirebaseAuth.instance.signOut();
    update();
    Get.offAll(
      () => LoginScreen(),
    );
  }
}
