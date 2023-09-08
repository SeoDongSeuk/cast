import 'dart:io';

import 'package:cast/components/cast_constants.dart';
import 'package:cast/components/cast_page_route.dart';
import 'package:cast/components/cast_widget.dart';
import 'package:cast/pages/add/add_alarm_page.dart';
import 'package:cast/pages/add/components/add_page_widget.dart';
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
  File? _mdicineImage;

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
        child: AddPageBody(
          children: [
            Text(
              '어떤 약이에요?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: largeSpace,
            ),
            Center(
              child: MedicineImageButton(
                changeImageFile: (File? value) {
                  _mdicineImage = value;
                },
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
              onChanged: (_) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: _nameController.text.isEmpty ? null : _onAddAlarmPage,
        text: '다음',
      ),
    );
  }

  void _onAddAlarmPage() {
    Navigator.push(
      context,
      FadePageRoute(
        page: AddAlarmPage(
          medicineImage: _mdicineImage,
          medicineName: _nameController.text,
        ),
      ),
    );
  }
}

class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({
    super.key,
    required this.changeImageFile,
  });

  final ValueChanged<File?> changeImageFile;

  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<MedicineImageButton> {
  File? _pikedImage;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        padding: _pikedImage == null ? null : EdgeInsets.zero,
        onPressed: _showBottomSheet,
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
    );
  }

  /// _showBottomSheet
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheet(
            onPressdCamera: () => _onPressed(ImageSource.camera),
            onPressdGallery: () => _onPressed(ImageSource.gallery),
          );
        });
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xfile) {
      if (xfile != null) {
        setState(() {
          _pikedImage = File(xfile.path);
          widget.changeImageFile(_pikedImage);
        });
      }
      Navigator.maybePop(context);
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({
    super.key,
    required this.onPressdCamera,
    required this.onPressdGallery,
  });

  final VoidCallback onPressdCamera;
  final VoidCallback onPressdGallery;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressdCamera,
          child: const Text('카메라 촬영'),
        ),
        TextButton(
          onPressed: onPressdGallery,
          child: const Text('앨범에서 가져오기'),
        )
      ],
    );
  }
}
