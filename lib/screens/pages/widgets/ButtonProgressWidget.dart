import 'package:flutter/material.dart';

class ButtonProgressWidget extends StatelessWidget {
  const ButtonProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {}, child: const CircularProgressIndicator());
  }
}
