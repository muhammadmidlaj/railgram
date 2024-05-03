import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final void Function(int index) onChanged;
  final void Function() onSubmit;
  final int value;
  const RatingBar(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return IconButton(
                  icon: Icon(
                    index < value ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 60,
                  ),
                  onPressed: () {
                    onChanged(value == index + 1 ? index : index + 1);
                  });
            }),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: TextButton(
                    onPressed: () {
                      onSubmit();
                    },
                    child: const Text('Submit')),
              ))
        ],
      ),
    );
  }
}
