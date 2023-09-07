import 'dart:io';
import 'package:cast/pages/add/components/add_page_widget.dart';
import 'package:flutter/material.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage({
    super.key,
    this.medicineImage,
    required this.medicineName,
  });

  final File? medicineImage;
  final String medicineName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          Text(
            '매일 복약 잊지 말아요!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
