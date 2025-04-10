import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';

class WelcomeIcons extends StatelessWidget {
  const WelcomeIcons(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.destinationScreen});
  final String label;
  final String iconPath;
  final Widget destinationScreen;
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedElevation: 0,
      closedBuilder: (context, action) {
        return InkWell(
          onTap: action,
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: buttonContainerSize,
                width: buttonContainerSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 153, 241, 222)),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    height: 70,
                    width: 70,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Text(
                label,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: 5,)
            ],
          ),
        );
      },
      openBuilder: (context, action) => destinationScreen,
    );
  }
}
