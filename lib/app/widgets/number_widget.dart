import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IndividualField(),
        Gap(5),
        IndividualField(),
        Gap(5),
        IndividualField(),
      ],
    );
  }
}

class IndividualField extends StatelessWidget {
  const IndividualField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
          ),
        ),
        SizedBox(
          width: 75,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {},
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.minimize,
          ),
        ),
      ],
    );
  }
}
