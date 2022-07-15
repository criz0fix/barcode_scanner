import 'package:flutter/material.dart';

class BarcodeTile extends StatelessWidget {
  final String title;
  final String savedTime;
  const BarcodeTile({Key? key, required this.title, required this.savedTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 90, maxHeight: 90),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xAA000000)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [Text(title), const Spacer(), Text(savedTime)],
          ),
        ),
      ),
    );
  }
}
