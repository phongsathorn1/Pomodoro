import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pomodoro/dialogs/image_picker_handler.dart';
import 'package:pomodoro/dialogs/image_picker_dialog.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:pomodoro/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProfilePicScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProfilePicScreenState();
  }
}

class AddProfilePicScreenState extends State<AddProfilePicScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  String imageUrl;
  bool _loading = false;

  Future getImage(context) async {
    var image = imagePicker.showDialog(context);
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadFile() async {
    final pref = await SharedPreferences.getInstance();
    String fileName = pref.getString('userid');
    print(fileName);
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(this._image);
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          print(downloadUrl);
          User.photoUrl = downloadUrl;
          Firestore.instance
              .collection('users')
              .document(fileName)
              .updateData({'photoUrl': downloadUrl}).then((data) async {
            setState(() {
              _loading = false;
              User.photoUrl = downloadUrl;
              Fluttertoast.showToast(msg: "Upload success");
            });
          }).catchError((err) {
            // Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {});
      // Fluttertoast.showToast(msg: err.toString());
    });
  }

  openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this._image = image;
    });
    uploadFile();
    // cropImage(image);
  }

  openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // setState(() {
    //  image =
    // });
    // cropImage(image);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add profile picture'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : _loading
                ? Center(
                    child: new CircularProgressIndicator(),
                  )
                : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => this.imagePicker.showDialog(context),
        // onPressed: getImage,
        // onPressed: () => openCamera(),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  userImage(File _image) {
    this._loading = true;
    setState(() {
      this._image = _image;
    });
    uploadFile();
  }
}
