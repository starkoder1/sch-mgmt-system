import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.titleText,
    required this.bodyText,
    required this.buttonLabel,
    this.onPressed,
  });

  final String titleText;
  final String bodyText;
  final String buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    titleText,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              Wrap(
                children: [
                  Text(
                    softWrap: true,
                    bodyText,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onPressed,
                    child: Text(
                      buttonLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
