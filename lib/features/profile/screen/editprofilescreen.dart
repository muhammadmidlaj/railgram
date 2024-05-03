import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:railgram/constants/global_variable.dart';
import 'package:railgram/features/profile/providers/userProvider.dart';
import 'package:railgram/features/profile/services/editProfileService.dart';

class EditProfileScreen extends StatefulWidget {
  final String userid;
  final String coverimgurl;
  final String profileimgurl;
  final String firstname;
  final String lastname;
  final String phonenumber;
  const EditProfileScreen(
      {super.key,
      required this.userid,
      required this.coverimgurl,
      required this.profileimgurl,
      required this.firstname,
      required this.lastname,
      required this.phonenumber});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileEditService _profileEditService = ProfileEditService();
  File? _coverimageFile;
  File? _profileimageFile;

  final TextEditingController _firstnameEditingController = TextEditingController();
  final TextEditingController _lastnameEditingController = TextEditingController();
  final TextEditingController _phonenumberEditingController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstnameEditingController.text = widget.firstname;
    _lastnameEditingController.text = widget.lastname;
    _phonenumberEditingController.text = widget.phonenumber;
  }

  Future _getFromGalleryCoverimg() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);
    setState(() {
      _coverimageFile = file;
    });
  }

  Future _getFromGalleryProfileimg() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);
    setState(() {
      _profileimageFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    String currentProfileimgurl = userprovider.user.profileimgurl;
    String currentCoverImgurl = userprovider.user.coverimgurl;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                    IconButton(
                      onPressed: () {
                        _profileEditService.updateProfile(
                            context: context,
                            firstname: _firstnameEditingController.text,
                            lastname: _lastnameEditingController.text,
                            phoneno: _phonenumberEditingController.text,
                            profileimgpath: _profileimageFile == null
                                ? currentProfileimgurl
                                : _profileimageFile!.path,
                            coverimgpath: _coverimageFile == null
                                ? currentCoverImgurl
                                : _coverimageFile!.path);
                      },
                      icon: const Icon(Icons.done),
                    )
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: _coverimageFile == null
                          ? Image.network(
                              fit: BoxFit.cover,
                              widget.coverimgurl,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.blue,
                              ),
                            )
                          : Image.file(
                              _coverimageFile!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned.fill(
                      // top: 30,
                      // right: MediaQuery.of(context).size.width / 2 - 25,
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: _profileimageFile == null
                                ? CircleAvatar(
                                    radius: 47,
                                    backgroundImage:
                                        NetworkImage(widget.profileimgurl),
                                    onBackgroundImageError:
                                        (exception, stackTrace) => Colors.blue,
                                  )
                                : CircleAvatar(
                                    radius: 47,
                                    backgroundImage:
                                        FileImage(_profileimageFile!),
                                  )
                            // ClipOval(
                            //     child: Image.file(
                            //       _profileimageFile!,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            ),
                      ),
                    ),
                    Positioned(
                      top: 85,
                      left: MediaQuery.of(context).size.width / 2 + 15,
                      child: InkWell(
                        onTap: () => _getFromGalleryProfileimg(),
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 18,
                          child: CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.edit, size: 17),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      // top: 30,
                      // right: MediaQuery.of(context).size.width / 2 - 25,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () => _getFromGalleryCoverimg(),
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: CircleAvatar(
                                radius: 15,
                                child: Icon(Icons.edit, size: 17),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _firstnameEditingController,
                        decoration: const InputDecoration(
                          label: Text('Firstname'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _lastnameEditingController,
                        decoration: const InputDecoration(
                          label: Text('Lastname'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _phonenumberEditingController,
                        decoration: const InputDecoration(
                          label: Text('Phonenumber'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
