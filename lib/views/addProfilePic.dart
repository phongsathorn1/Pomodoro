import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pomodoro/dialogs/image_picker_handler.dart';
import 'package:pomodoro/dialogs/image_picker_dialog.dart';

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

  Future getImage(context) async {
    var image = imagePicker.showDialog(context);
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
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
    print(imagePicker);
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
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => this.imagePicker.showDialog(context),
        // onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
