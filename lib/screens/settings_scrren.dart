import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jbeauty/main.dart';
import 'package:jbeauty/route/app_router.gr.dart';

import '../style/style.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          tr.settings,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //   child: InkWell(
          //     onTap: () {},
          //     child: const Row(
          //       children: [
          //         Icon(
          //           Icons.account_circle,
          //           color: Style.primaryColor,
          //         ),
          //         Text(
          //           tr.account,
          //           style: TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //               ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   decoration: const BoxDecoration(
          //     border: Border(
          //       top: BorderSide(color: Colors.grey),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //     child: InkWell(
          //       onTap: () {},
          //       child: const Row(
          //         children: [
          //           Icon(
          //             Icons.notifications,
          //             color: Style.primaryColor,
          //           ),
          //           Text(
          //             tr.notification,
          //             style: TextStyle(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //         ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          PopupMenuButton<Locale>(
            offset: Offset(MediaQuery.of(context).size.width - 100, 40),
            onSelected: (Locale result) {
              ref.read(currentLocalProvider).setLocale(result);
              context.router.popUntilRoot();
              context.router.replace(const SplashRoute());
            },
            itemBuilder: (context) {
              return AppLocalizations.supportedLocales.map((Locale locale) {
                return PopupMenuItem<Locale>(
                  value: locale,
                  child: Text(locale.languageCode),
                );
              }).toList();
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Style.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      tr.language,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   decoration: const BoxDecoration(
          //     border: Border(
          //       top: BorderSide(color: Colors.grey),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //     child: InkWell(
          //       onTap: () {},
          //       child: const Row(
          //         children: [
          //           Icon(
          //             Icons.home_filled,
          //             color: Style.primaryColor,
          //           ),
          //           Text(
          //             tr.change_Address,
          //             style: TextStyle(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //       ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
