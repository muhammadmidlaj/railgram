import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/constants/validation.dart';
import 'package:railgram/features/posts/globalPost/services/createpostservices.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';

class CreateGlobalQuestion extends StatefulWidget {
  final String? communityid;
  const CreateGlobalQuestion({super.key, this.communityid});

  @override
  State<CreateGlobalQuestion> createState() => _CreateGlobalQuestionState();
}

class _CreateGlobalQuestionState extends State<CreateGlobalQuestion> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _conetntEditingController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final GlobalPostServices _createpost = GlobalPostServices();
  final PostServices _postServices = PostServices();
  final FormValidator _formFieldValidator = FormValidator();

  final String _type = 'Question';
  final imageUrl = '';

  void addQuestion() {
    _postServices.addPost(
        context: context,
        title: _titleEditingController.text,
        content: _conetntEditingController.text,
        type: _type,
        imagePath: imageUrl,
        communityId: (widget.communityid == null) ? '' : widget.communityid);
    _createpost.addPost(
        context: context,
        title: _titleEditingController.text,
        content: _conetntEditingController.text,
        type: _type,
        imagePath: imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: secondaryColor,
        border: Border(),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    icon: const Icon(
                      FontAwesomeIcons.rectangleXmark,
                      color: primaryColor,
                    )),
                OutlinedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        if (!isloading) {
                          addQuestion();
                          loadingSnackBar(context, 'posting');
                        }
                      }
                    },
                    child: const Text(
                      'POST',
                      style: TextStyle(color: primaryColor),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _titleEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'Title..',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.blueGrey)),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      _formFieldValidator.isTitleValid(value)) {
                                    return 'title must be 10 charecter long';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _conetntEditingController,
                                maxLines: 8,
                                decoration: const InputDecoration(
                                  hintText: 'Content...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blueGrey),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      _formFieldValidator
                                          .isContentValid(value)) {
                                    return 'content must be 20 charecer long';
                                  }
                                  return null;
                                },
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
