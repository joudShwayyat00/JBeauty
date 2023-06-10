import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jbeauty/data/product.dart';

import '../main.dart';

@RoutePage()
class ProductDescritionScreen extends StatelessWidget {
  const ProductDescritionScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 26),
        fixedSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          tr.details,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(product.nameTR,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(product.discrptionTR, style: const TextStyle(fontSize: 18)),
              Text(product.ingredients.toString(),
                  style: const TextStyle(fontSize: 10)),
              const SizedBox(
                height: 20,
              ),
              Text('\$ ${product.price} JD',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              //const Spacer(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: style,
                onPressed: () {
                  var uid = FirebaseAuth.instance.currentUser!.uid;
                  FirebaseFirestore.instance
                      .collection('carts')
                      .doc(uid)
                      .collection('items')
                      .add(product.toMap());

                  /// show snackbar for success
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(tr.product_Added_to_Cart),
                    ),
                  );
                  context.router.pop();
                },
                child: Text(tr.buy_Now),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
