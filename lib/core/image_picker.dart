import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppAlert {
  static AppAlert get init => AppAlert._();
  AppAlert._();
  Future imagePickerDialog(
      {Function(File file,String imageName)? onSubmit,
        bool withCrop = false,
        Function(List<File> file)? onSubmitMulti,
        required BuildContext context}) async {
    ImagePicker pick = ImagePicker();
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: const Text('cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            CupertinoButton(
              child: const Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.photo_camera_solid,
                  ),
                  const SizedBox(width: 20),
                  Text('camera'),
                ],
              ),
              onPressed: () async {
                XFile? pickedFile = await pick.pickImage(
                    source: ImageSource.camera, maxWidth: 400);
                if (pickedFile != null) {
                  Navigator.pop(context);
                  if (onSubmit != null) onSubmit(File(pickedFile.path),pickedFile.name);
                  if (onSubmitMulti != null) {
                    onSubmitMulti([File(pickedFile.path)]);
                  }
                }
              },
            ),
            CupertinoButton(
              child: const Row(
                children: <Widget>[
                  Icon(Icons.insert_photo),
                  const SizedBox(width: 20),
                  Text('gallery'),
                ],
              ),
              onPressed: () async {
                XFile? pickedFile = await pick.pickImage(source: ImageSource.gallery, maxWidth: 400);
                if (pickedFile != null) {
                  Navigator.pop(context);
                  if (onSubmit != null) onSubmit(File(pickedFile.path),pickedFile.name);
                  if (onSubmitMulti != null) {
                    onSubmitMulti([File(pickedFile.path)]);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}