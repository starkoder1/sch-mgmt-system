import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget(
      {super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xffb0c46c4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Image.asset(
                'assets/icons/student.png',
                fit: BoxFit.cover,
                width: 65,
                height: 65,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            buttonText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
