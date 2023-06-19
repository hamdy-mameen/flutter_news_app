import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TagContainer extends StatelessWidget {
  final Color backgroundColor;
  final List<Widget> childern;
  const TagContainer(
      {super.key, required this.backgroundColor, required this.childern});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: backgroundColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: childern,
      ),
    );
  }
}
