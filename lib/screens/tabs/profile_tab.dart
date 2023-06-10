import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:jbeauty/main.dart';
import 'package:jbeauty/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:jbeauty/style/style.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      floatingActionButton: const ThemeModeButtons(),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: const Text(
          '',
        ),
        actions: const [],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: firestore.collection('users').doc(uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(tr.something_went_wrong),
              );
            }
            var data = snapshot.data!.data() ?? {};
            return Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      color: Style.primaryColor,
                      height: 100,
                    ),
                    Center(
                      child: Column(
                        children: [
                          // CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //       'https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914__340.png'),
                          // ),
                          Text(data['name'] ?? '',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(FirebaseAuth.instance.currentUser!.email!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(" (${data['phone']})",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),

                          Text(data['address'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.router.push(NameAddressRoute(data: data));
                        },
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    context.router.push(const MyOrdersRoute());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          color: Style.primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          tr.my_orders,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          context.router.push(const SettingsRoute());
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.settings,
                              color: Style.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tr.settings,
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
                ),
                // Container(
                //   decoration: const BoxDecoration(
                //     border: Border(
                //       top: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   child: const Padding(
                //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.rate_review,
                //           color: Style.primaryColor,
                //         ),
                //         Text(
                //           tr.rate_Us,
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black),
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
                //   child: const Padding(
                //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.connect_without_contact,
                //           color: Style.primaryColor,
                //         ),
                //         Text(
                //           tr.refer_a_Friend,
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        //AutoRoute(page: HelpScreen.page);
                        context.router.push(const HelpRoute());
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.help,
                            color: Style.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            tr.help,
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

                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    SharedPerfManager.clearAllData();
                    context.router.push(const SplashRoute());
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Style.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            tr.log_out,
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
              ],
            );
          }),
    );
  }
}
