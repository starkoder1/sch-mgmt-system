import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn(
      {super.key, required this.content, required this.onPressed});

  final String content;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(Theme.of(context).primaryColor),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 150, vertical: 15),
        ),
      ),
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
        ),
      ),
    );
  }
}
