import 'package:sca6/tokens/topbar.dart';
import 'package:flutter/material.dart';

class DairyScreen extends StatelessWidget {
  const DairyScreen({
    super.key,
    required this.setPage,
  });

  final void Function(int) setPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(setPage: setPage),
        const Text('data'),
      ],
    );
  }
}
