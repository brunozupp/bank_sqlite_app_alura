import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:flutter/material.dart';

class CardContactComponent extends StatelessWidget {

  final IconData icon;
  final String text;
  final EdgeInsets? margin;
  final VoidCallback onTap;

  const CardContactComponent({ 
    Key? key, 
    required this.icon, 
    required this.text, 
    this.margin,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material( // Precisa desse cara para dar o efeito de click
        color: ColorsApp.primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            constraints: const BoxConstraints(
              minWidth: 150
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                const Spacer(),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}