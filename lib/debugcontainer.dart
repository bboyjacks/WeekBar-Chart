import 'package:flutter/material.dart';

class DebugContainer extends StatelessWidget {
  DebugContainer({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1.0
        )
      ),
      child: child
    );
  }
}