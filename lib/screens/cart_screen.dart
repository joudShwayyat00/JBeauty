// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jbeauty/data/product.dart';

import '../main.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          tr.cart,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),

      /// get the cart items from the firebase from the user uid and display them in the cart screen
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('carts')
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
            List<Product> products = [];

            products = snapshot.data!.docs
                .map((e) => Product.fromMap(e.data()))
                .toList();

            if (products.isEmpty) {
              return Center(
                child: Text(tr.no_items_in_the_Cart),
              );
            }

            double total = products.fold(
                0, (previousValue, element) => previousValue + element.total);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var productDoc = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              width: 50,
                              height: 50,
                              products[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(products[index].nameTR),
                          subtitle: Text(
                            '\$ ${products[index].price} JD',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// add quantity buttons + and - to increase or decrease the quantity of the product
                              IconButton(
                                onPressed: () {
                                  int quantity = products[index].quantity ?? 0;
                                  int newQuantity = quantity + 1;
                                  productDoc.reference.set(
                                      {'quantity': newQuantity},
                                      SetOptions(merge: true));
                                },
                                icon: const Icon(Icons.add),
                              ),
                              Text(products[index].quantity.toString()),
                              IconButton(
                                onPressed: () {
                                  var quantity = products[index].quantity ?? 0;
                                  var newQuantity = quantity - 1;
                                  if (products[index].quantity == 1) {
                                    return;
                                  }
                                  productDoc.reference
                                      .update({'quantity': newQuantity});
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {
                                  productDoc.reference.delete();
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// get the total price of the products in the cart

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr.total,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ $total JD',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      /// show dialog are you sure
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(tr.are_you_sure),
                              content:
                                  Text(tr.do_you_want_to_checkout_your_cart),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      context.router.pop();
                                    },
                                    child: Text(tr.no)),
                                TextButton(
                                    onPressed: () async {
                                      /// delete the cart items from the firebase
                                      await firestore
                                          .collection('carts')
                                          .doc(uid)
                                          .collection('items')
                                          .get()
                                          .then((snapshot) {
                                        for (DocumentSnapshot ds
                                            in snapshot.docs) {
                                          ds.reference.delete();
                                        }
                                      });

                                      // Create a new order in the firebase
                                      await firestore
                                          .collection('orders')
                                          .doc(uid)
                                          .collection('items')
                                          .doc()
                                          .set({
                                        'products': products
                                            .map((e) => e.toMap())
                                            .toList(),
                                        'total': total,
                                        'createdAt':
                                            FieldValue.serverTimestamp(),
                                        'status': 'pending',
                                        'uid': uid,
                                      });
                                      // SHOW SNACKBAR
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text(tr.your_order_has_been_placed),
                                      ));
                                      context.router.popUntil((route) =>
                                          route.data?.name == 'HomeRoute');
                                    },
                                    child: Text(tr.yes)),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    child: Text(tr.checkout),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
