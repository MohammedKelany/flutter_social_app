import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/social_controller.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/view/widgets/shared_components.dart';

final SocialController socialController = Get.find();

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<SocialController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Image(
                    image: NetworkImage(controller.userModel!.image!),
                  ),
                ),
                if (controller.posts.isNotEmpty)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (
                      context,
                      index,
                    ) =>
                        buildPostItems(
                      controller.posts[index],
                      context,
                      index,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: controller.posts.length,
                  ),
                if (controller.posts.isEmpty) emptyBody(text: "Posts"),
                const SizedBox(
                  height: 8,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget buildPostItems(PostModel postModel, context, int index) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    elevation: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(postModel.image!),
              ),
              const SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          postModel.username!,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 17,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    postModel.dateTime.toString().substring(
                          0,
                          postModel.dateTime.toString().lastIndexOf('.'),
                        ),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz_outlined),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: ColoredBox(
            color: Colors.black12,
            child: SizedBox(
              width: double.infinity,
              height: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            postModel.text!,
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
          ),
        ),
        // Wrap(
        //   children: [
        //     MaterialButton(
        //       minWidth: 1,
        //       padding: const EdgeInsets.only(left: 8, right: 5),
        //       onPressed: () {},
        //       child: const Text(
        //         "#Software",
        //         style: TextStyle(color: Colors.blue),
        //       ),
        //     ),
        //     MaterialButton(
        //       minWidth: 1,
        //       padding: const EdgeInsets.only(right: 5),
        //       onPressed: () {},
        //       child: const Text(
        //         "#Software_Development",
        //         style: TextStyle(color: Colors.blue),
        //       ),
        //     ),
        //     MaterialButton(
        //       minWidth: 1,
        //       padding:const EdgeInsets.only(right: 5),
        //       onPressed: () {},
        //       child: const Text(
        //         "#IT_Support",
        //         style: TextStyle(color: Colors.blue),
        //       ),
        //     ),
        //   ],
        // ),
        if (postModel.postImage != '')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Container(
              height: 150,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(postModel.postImage!),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            top: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_outline_sharp,
                        color: Colors.red,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        socialController.likes[index].toString(),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.comment_outlined,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Comments",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: ColoredBox(
            color: Colors.black12,
            child: SizedBox(
              width: double.infinity,
              height: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  socialController.userModel!.image!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Wright a comment...",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  socialController.likePost(socialController.postsId[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_outline_sharp,
                        color: Colors.red,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Likes",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
