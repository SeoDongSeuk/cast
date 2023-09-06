import 'dart:io';

import 'package:cast/components/cast_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _nameController = TextEditingController();
  File? _pikedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '어떤 약이에요?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: largeSpace,
              ),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: CupertinoButton(
                    padding: _pikedImage == null ? null : EdgeInsets.zero,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Padding(
                                padding: pagePadding,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera)
                                            .then((xfile) {
                                          Navigator.maybePop(context);
                                        });
                                      },
                                      child: const Text('카메라 촬영'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then((xfile) {
                                          if (xfile != null) {
                                            setState(() {
                                              _pikedImage = File(xfile.path);
                                              Navigator.maybePop(context);
                                            });
                                          }
                                        });
                                      },
                                      child: const Text('앨범에서 가져오기'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: _pikedImage == null
                        ? const Icon(
                            CupertinoIcons.photo_camera_solid,
                            size: 30,
                            color: Colors.white,
                          )
                        : CircleAvatar(
                            foregroundImage: FileImage(_pikedImage!),
                            radius: 40,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: largeSpace + regularSpace,
              ),
              Text(
                '약 이름',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextFormField(
                controller: _nameController,
                maxLength: 20,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: '복용할 약 이름을 기입해주세요',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  contentPadding: textFieldContentPadding,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.titleMedium),
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }
}
