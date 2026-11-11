import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final String productId;
  final dynamic cubit;

  const CounterWidget({
    super.key,
    required this.value,
    required this.productId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => cubit.decrementCounter(productId),
              icon: const Icon(Icons.remove),
            ),

            Text(value.toString()),

            IconButton(
              onPressed: () => cubit.incrementCounter(productId),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
