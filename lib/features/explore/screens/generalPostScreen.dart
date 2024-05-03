import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/explore/widgets/imageCard_widget.dart';
import 'package:railgram/features/posts/post/provider/postprovider.dart';
import 'package:railgram/features/posts/postview.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GeneralPostScreen extends StatefulWidget {
  const GeneralPostScreen({super.key});

  @override
  State<GeneralPostScreen> createState() => _GeneralPostScreenState();
}

class _GeneralPostScreenState extends State<GeneralPostScreen> {
  List<dynamic> postwithImage = [];

  @override
  void initState() {
    super.initState();
    getPostWithImage(context);
  }

  void getPostWithImage(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context, listen: false);
    for (var i in postProvider.homefeedPosts) {
      if (i["post_imageurl"] != "" && i["post_imageurl"] != null) {
        postwithImage.add(i);
      }
    }
    // print("numbers ${postwithImage.length}");

    // print(postProvider.homefeedPosts[1]["post_imageurl"]);
  }

  @override
  Widget build(BuildContext context) {
    //getPostWithImage(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Explore'),
        leading: const Icon(FontAwesomeIcons.globe),
      ),
      body: Container(
        color: Colors.white,
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          itemCount: postwithImage.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostView(
                    imgurl: postwithImage[index]["post_imageurl"],
                    title: postwithImage[index]["post_title"],
                    content: postwithImage[index]["post_content"],
                    type: postwithImage[index]["post_type"],
                    profileurl: postwithImage[index]["profileimgurl"] ?? "",
                    username: postwithImage[index]["username"],
                    date: postwithImage[index]["created_at"],
                    postid: postwithImage[index]["postid"],
                    commentcount:
                        postwithImage[index]["comment_count"].toString()),
              ));
            },
            child: ImageCardWidget(
                imageurl: postwithImage[index]["post_imageurl"],
                profileurl: postwithImage[index]["profileimgurl"],
                username: postwithImage[index]["username"],
                communityid: postwithImage[index]["community_uid"]),
          ),
        ),
      ),
    );
  }
}
