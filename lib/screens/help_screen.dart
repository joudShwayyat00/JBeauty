import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../main.dart';

@RoutePage()
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          tr.help,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                tr.in_help,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
