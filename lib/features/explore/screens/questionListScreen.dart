import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railgram/features/explore/widgets/questionListWidget.dart';
import 'package:railgram/features/posts/post/provider/postprovider.dart';
import 'package:railgram/features/posts/postview.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key});

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

List<dynamic> questions = [];
void getQuestions(BuildContext context) {
  var postProvider = Provider.of<PostProvider>(context, listen: false);
  questions = [];
  for (var i in postProvider.homefeedPosts) {
    if (i["post_type"] == "Question") {
      questions.add(i);
    }
  }
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  @override
  void initState() {
    super.initState();
    getQuestions(context);
  }

  @override
  Widget build(BuildContext context) {
    getQuestions(context);
    return Container(
      child: ListView.separated(
        itemCount: questions.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 3,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostView(
                  imgurl: questions[index]["post_imageurl"],
                  title: questions[index]["post_title"],
                  content: questions[index]["post_content"],
                  type: questions[index]["post_type"],
                  profileurl: questions[index]["profileimgurl"] ?? "",
                  username: questions[index]["username"],
                  date: questions[index]["created_at"],
                  postid: questions[index]["postid"],
                  commentcount: questions[index]["comment_count"].toString()),
            ));
          },
          child: QuestionViewWidget(
            username: questions[index]["username"],
            title: questions[index]["post_title"],
            profileurl: questions[index]["profileimgurl"],
            created: questions[index]["created_at"],
          ),
        ),
      ),
    );
  }
}
