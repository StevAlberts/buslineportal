import 'package:flutter/material.dart';

class TableBody extends StatelessWidget {
  const TableBody({
    super.key,
    required this.text,
    this.color,
  });

  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: color ?? Colors.black,
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}
