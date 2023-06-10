import 'package:auto_route/auto_route.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbeauty/data/product.dart';
import 'package:jbeauty/route/app_router.gr.dart';
import 'package:jbeauty/screens/tabs/home_tab.dart';

import 'package:jbeauty/style/style.dart';

import '../../main.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('categories').snapshots(),
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
          var categories = snapshot.data!.docs
              .map((e) => Category.fromMap(e.data()))
              .toList();
          return DefaultTabController(
            length: categories.length,
            child: Column(
              children: [
                Container(
                  color: Style.primaryColor,
                  height: 50,
                ),
                const SizedBox(height: 40),

                /// categories taps here
                ButtonsTabBar(
                  tabs: [
                    for (final category in categories)
                      Tab(text: category.nameTR),
                  ],
                  backgroundColor: Style.primaryColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 26),
                  unselectedBackgroundColor: Colors.transparent,
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  height: 40,
                ),

                /// categories content here
                Expanded(
                    child: TabBarView(children: [
                  for (int i = 0; i < categories.length; i++)
                    getViewByCategory(
                        categories[i], snapshot.data!.docs[i], ref),

                  // getViewByCategory(SampleData.categories[0]),
                  // getViewByCategory(SampleData.categories[1]),
                  // getViewByCategory(SampleData.categories[2]),
                ])),
              ],
            ),
          );
        });
  }

  Widget getViewByCategory(Category category,
      QueryDocumentSnapshot<Map<String, dynamic>> doc, WidgetRef ref) {
    var firestore = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    // var subcategorys = SampleData.getSubcategorysForCategory(category);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: doc.reference.collection('subcategories').snapshots(),
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
          var subcategorys = snapshot.data!.docs
              .map((e) => SubCategory.fromMap(e.data()))
              .toList();

          return ListView.builder(
            itemCount: subcategorys.length,
            itemBuilder: (context, index) {
              var subcategory = subcategorys[index];
              var subcategoryDoc = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                subcategory.nameTR,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(${subcategory.discount}% ${tr.off}})',
                                style: const TextStyle(
                                    color: Style.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subcategory.discrptionTR,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 250,
                        child: StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            stream: subcategoryDoc.reference
                                .collection('products')
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
                              var filterText = ref.watch(filterTextProvider);
                              products = products
                                  .where((element) => element.nameTR
                                      .toLowerCase()
                                      .contains(filterText))
                                  .toList();

                              if (products.isEmpty) {
                                return Center(
                                  child: Text(tr.no_products_found),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  var product = products[index];
                                  var productDoc = snapshot.data!.docs[index];
                                  return StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: firestore
                                          .collection('favorites')
                                          .doc(uid)
                                          .collection('items')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        /// check if the product is in the favorite list
                                        bool isFavorite = false;
                                        if (snapshot.hasData) {
                                          isFavorite = snapshot.data!.docs.any(
                                              (element) =>
                                                  element.id == productDoc.id);
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              context.router.push(
                                                  ProductDescritionRoute(
                                                      product: product));
                                            },
                                            child: SizedBox(
                                              width: 130,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Stack(
                                                      children: [
                                                        Positioned.fill(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            child:
                                                                Image.network(
                                                              product.image,
                                                              fit: BoxFit.cover,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            ),
                                                          ),
                                                        ),
                                                        // favorite button
                                                        Positioned(
                                                          top: 4,
                                                          right: 4,
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: IconButton(
                                                              iconSize: 16,
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxHeight:
                                                                          40,
                                                                      maxWidth:
                                                                          40),
                                                              icon: Icon(
                                                                isFavorite
                                                                    ? Icons
                                                                        .favorite
                                                                    : Icons
                                                                        .favorite_border,
                                                                color:
                                                                    Colors.red,
                                                                size: 16,
                                                              ),
                                                              onPressed: () {
                                                                if (isFavorite) {
                                                                  firestore
                                                                      .collection(
                                                                          'favorites')
                                                                      .doc(uid)
                                                                      .collection(
                                                                          'items')
                                                                      .doc(product
                                                                          .id)
                                                                      .delete();
                                                                } else {
                                                                  firestore
                                                                      .collection(
                                                                          'favorites')
                                                                      .doc(uid)
                                                                      .collection(
                                                                          'items')
                                                                      .doc(product
                                                                          .id)
                                                                      .set(product
                                                                          .toMap());
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RatingBar.builder(
                                                          initialRating:
                                                              product.rating,
                                                          itemSize: 12,
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          ignoreGestures: true,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      1.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {},
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(product.nameTR,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(
                                                            '\$ ${product.price} ',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            })),
                  ],
                ),
              );
            },
          );
        });
  }
}
