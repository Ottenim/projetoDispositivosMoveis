import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photo extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => Photo());

  const Photo({super.key});

  @override
  State<Photo> createState() => _PageState();
}

class _PageState extends State<Photo> {
  XFile? _imageFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  ImageProvider<Object>? _previewImage() {
    if (_imageFile != null) {
      return FileImage(File(_imageFile!.path));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey[200],
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _previewImage(),
                    child: _imageFile == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      onPressed: _showOpcoesBottomSheet,
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _onImageButtonPressed(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _onImageButtonPressed(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.restore_from_trash_outlined,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tornar a foto null
                  setState(() {
                    _imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
