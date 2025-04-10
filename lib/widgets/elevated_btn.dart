import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn({
    super.key,
    required this.content,
    required this.onPressed,
    this.hPadding = 150,
    this.vPadding = 15,
    this.isLoading,
  });

  final String content;
  final void Function()? onPressed;
  final double hPadding;
  final double vPadding;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading == true ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primary,
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        ),
      ),
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        ),
      ),
    );

    if (isLoading == true) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.31),
        highlightColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.64),
        child: AbsorbPointer(
          child: button,
        ),
      );
    }

    return button;
  }
}
