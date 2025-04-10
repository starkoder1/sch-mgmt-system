import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_mgmt/providers/user_type_provider.dart';
import 'package:school_mgmt/widgets/card_widget.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(userTypeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(children: [
          Image.asset(
            "assets/icons/result.png",
            color: Theme.of(context).colorScheme.onPrimary,
            height: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text("R E S U L T S",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600)),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            CustomCard(
                titleText: "First Term",
                bodyText: "No Image Available",
                buttonLabel: userType == 'teacher' ? "PUBLISH" : "VIEW"),
            CustomCard(
              titleText: "First Term",
              bodyText: "No Image Available",
              buttonLabel: userType == 'teacher' ? "PUBLISH" : "VIEW",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
