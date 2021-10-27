import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {

  final String message;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;

  const CenteredMessage({ 
    Key? key, 
    required this.message, 
    this.icon, 
    this.iconSize, 
    this.fontSize 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              size: iconSize,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: fontSize
            ),
          ),
        ],
      ),
    );
  }
}