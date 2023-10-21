import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "© $year Openlyne. All rights reserved.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
            ),
      ),
      const SizedBox(width: 5),
      // divider
      Container(
        width: 1,
        height: 20,
        color: Theme.of(context).colorScheme.secondary,
      ),
      const SizedBox(width: 5),
      Text(
        "Terms of Use",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
            ),
      ),
      const SizedBox(width: 5),
      Container(
        width: 1,
        height: 20,
        color: Theme.of(context).colorScheme.secondary,
      ),
      const SizedBox(width: 5),
      Text(
        "Privacy Policy",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 16,
            ),
      ),
    ]);
  }
}
