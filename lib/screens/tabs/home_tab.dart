import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbeauty/screens/categories_widget.dart';

import '../../main.dart';

final filterTextProvider = StateProvider<String>((ref) {
  return '';
});


class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          title: Text(
            tr.app_name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // actions: [
          //   ThemeModeButtons(colorScheme: Theme.of(context).colorScheme)
          // ],
        ),
        body: Stack(
          children: [
            const Positioned.fill(child: CategoriesWidget()),

            /// search bar
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Container(
                // add shadow
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  ref.read(filterTextProvider.notifier).state = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: tr.search,
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
