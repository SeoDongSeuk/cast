import 'package:cast/components/cast_constants.dart';
import 'package:flutter/cupertino.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
