import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/constants/utils.dart';
import 'package:railgram/constants/validation.dart';
import 'package:railgram/features/posts/globalPost/services/createpostservices.dart';
import 'package:railgram/features/posts/post/services/postservices.dart';

class CreateGlobalPost extends StatefulWidget {
  final String? communityid;
  const CreateGlobalPost({super.key, this.communityid});

  @override
  State<CreateGlobalPost> createState() => _CreateGlobalPostState();
}

class _CreateGlobalPostState extends State<CreateGlobalPost> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FormValidator _formValidator = FormValidator();
  final String _type = 'Post';
  String imgUrl = '';

  GlobalPostServices createPostServices = GlobalPostServices();
  PostServices postServices = PostServices();

  File? imageFile;

  Future _getFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);
    setState(() {
      imageFile = file;
    });
  }

  void cleartext() {
    _titleEditingController.clear();
    _contentEditingController.clear();
    setState(() {
      imageFile = null;
    });
  }

  void addPost() {
    postServices.addPost(
        context: context,
        title: _titleEditingController.text,
        content: _contentEditingController.text,
        type: _type,
        imagePath: (imageFile == null) ? imgUrl : imageFile!.path,
        communityId: (widget.communityid == null) ? '' : widget.communityid);

    createPostServices.addPost(
      context: context,
      title: _titleEditingController.text,
      content: _contentEditingController.text,
      type: _type,
      imagePath: (imageFile == null) ? imgUrl : imageFile!.path,
      //communityId: (widget.communityid == null) ? '' : widget.communityid
    );
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
                      if (_formKey.currentState!.validate()) {
                        if (!isloading) {
                          addPost();
                          loadingSnackBar(context, 'Posting..');
                          //cleartext();
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
                          key: _formKey,
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
                                      _formValidator.isTitleValid(value)) {
                                    return 'title must be 10 charecter long';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _contentEditingController,
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
                                      _formValidator.isContentValid(value)) {
                                    return 'content must be 20 charecter long';
                                  }
                                  return null;
                                },
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => {_getFromGallery()},
                        child: Container(
                          height: imageFile == null ? 200 : null,
                          width: double.infinity,
                          color: Colors.deepPurple[200],
                          child: imageFile == null
                              ? const Icon(
                                  FontAwesomeIcons.image,
                                  size: 40,
                                )
                              : Container(
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
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
