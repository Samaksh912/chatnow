import 'package:flutter/material.dart';

class mybutton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const mybutton({super.key,
  required this.text,
    required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Center(child: Text(text),
        ),
      ),
    );
  }
}
