// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jbeauty/data/product.dart';

import '../../main.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          tr.favorite,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),

      /// get the cart items from the firebase from the user uid and display them in the cart screen
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('favorites')
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
                child: Text(tr.no_items_in_the_Favorite),
              );
            }

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
              ],
            );
          }),
    );
  }
}
