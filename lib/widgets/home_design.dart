import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';

class HomeScreenDesign extends StatelessWidget {
  const HomeScreenDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(800, 500),
                    bottomRight: Radius.elliptical(800, 500),
                  ),
                  color: Colors.teal,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 32.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Builder(
                      // Ensure correct context
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(),
              // ),
            ],
          ),
        ),
        Positioned(
          top: 90,
          left: MediaQuery.of(context).size.width / 2 - 90,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.teal,
                width: 4.0,
              ),
            ),
            child: const CircleAvatar(
              radius: 90,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
