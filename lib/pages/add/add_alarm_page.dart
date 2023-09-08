import 'dart:io';
import 'package:cast/components/cast_colors.dart';
import 'package:cast/components/cast_constants.dart';
import 'package:cast/components/cast_widget.dart';
import 'package:cast/pages/add/components/add_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({
    super.key,
    this.medicineImage,
    required this.medicineName,
  });

  final File? medicineImage;
  final String medicineName;

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final _alarms = <String>{
    '08:00',
    '13:00',
    '15:00',
  };

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
          const SizedBox(
            height: largeSpace,
          ),
          Expanded(
            child: ListView(
              children: alarmWidget,
              // children: const [
              //   AlarmBox(),
              //   AddAlarmButton(),
              // ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () {},
        text: '완료',
      ),
    );
  }

  // get 으로 위젯 형태를 get 할수 있게 만들수 있다.
  List<Widget> get alarmWidget {
    final children = <Widget>[];
    children.addAll(
      _alarms
          .map((alarmTime) => AlarmBox(
              time: alarmTime,
              onPressdMinus: () {
                setState(() {
                  _alarms.remove(alarmTime);
                });
              }))
          .toList(),
    );
    children.add(
      AddAlarmButton(
        onPressed: () {
          final now = DateTime.now();
          final nowTime = DateFormat('HH:mm').format(now);
          setState(() {
            _alarms.add(nowTime);
          });
        },
      ),
    );
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    super.key,
    required this.time,
    required this.onPressdMinus,
  });

  final String time;
  final VoidCallback onPressdMinus;
  @override
  Widget build(BuildContext context) {
    final initTime = DateFormat('HH:mm').parse(time);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onPressdMinus,
            icon: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TimePickerBottomSheet(
                    initialDateTime: initTime,
                  );
                },
              );
            },
            child: Text(time),
          ),
        )
      ],
    );
  }
}

class TimePickerBottomSheet extends StatelessWidget {
  const TimePickerBottomSheet({
    super.key,
    required this.initialDateTime,
  });

  final DateTime initialDateTime;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        SizedBox(
          height: 200, // CupertinoDatePicker 쓸때는 높이를 지정해줘야 한다
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {},
            mode: CupertinoDatePickerMode.time,
            initialDateTime: initialDateTime,
          ),
        ),
        const SizedBox(
          height: regularSpace,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      backgroundColor: Colors.white,
                      foregroundColor: CastColors.primaryColor),
                  onPressed: () {},
                  child: const Text('취소'),
                ),
              ),
            ),
            // 여백 줄때는 SizedBox 를 쓰네
            const SizedBox(
              width: smallSpace,
            ),
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  /// 버튼의 글자 스타일을 변경하고자 할때는 아래처럼 해라
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.titleMedium),
                  onPressed: () {},
                  child: const Text('선택'),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 6,
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium),
      onPressed: onPressed,
      child: const Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              CupertinoIcons.plus_circle_fill,
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Text('복용 알람 시간 추가'),
            ),
          )
        ],
      ),
    );
  }
}
