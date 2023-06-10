import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jbeauty/data/product.dart';

import '../main.dart';

@RoutePage()
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var firestore = fs.FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          tr.my_orders,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      /// get the cart items from the firebase from the user uid and display them in the cart screen
      body: StreamBuilder<fs.QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('orders')
              .doc(uid)
              .collection('items')
              .snapshots(),
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
            List<Order> orders = [];
            orders = snapshot.data!.docs
                .map((e) => Order.fromJson(e.data()))
                .toList();

            if (orders.isEmpty) {
              return Center(
                child: Text(tr.no_items_in_the_Cart),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    var orderDoc = snapshot.data!.docs[index];
                    var order = Order.fromJson(orderDoc.data());
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("id: ${orderDoc.id}",
                                    style: const TextStyle(fontSize: 10)),
                                const Spacer(),
                                Text(tr.total,
                                    style: const TextStyle(fontSize: 20)),
                                Text("JD ${order.total}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("${tr.status}: ",
                                    style: const TextStyle(fontSize: 12)),
                                Text(order.status!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                Text(
                                  DateFormat("yyyy-MM-dd").format(
                                      order.timestamp?.toDate() ??
                                          DateTime.now()),
                                )
                              ],
                            ),
                            const Divider(),
                            Text(tr.products),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, inde) {
                                var product = order.products![inde];
                                return ListTile(
                                  leading: Image.network(
                                    product.image,
                                    width: 50,
                                  ),
                                  title:
                                      Text(orders[index].products![inde].nameTR),
                                  trailing: Text(
                                    "${product.quantity}x JD ${product.price.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                              itemCount: order.products!.length,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: orders.length),
            );
          }),
    );
  }
}
