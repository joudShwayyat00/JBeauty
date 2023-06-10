import 'product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SampleData {
  /// create a samble data for the app

  // static List<Category> categories = [];

  // static List<SubCategory> subCategorys = [];

// // Define a list of sample products
//   static List<Product> products = getRandomProducts(subCategorys);

//   // Define a function to get a list of products for a given subcategory
//   static List<Product> getProductsForSubcategory(SubCategory subcategory) {
//     // Filter the list of products to only include those with a matching subcategory
//     List<Product> filteredProducts = products
//         .where((product) => product.subCategorie == subcategory)
//         .toList();

//     // Shuffle the list of products to get a random order
//     filteredProducts.shuffle();

//     // Return the products
//     return filteredProducts.toList();
//   }

// // Generate a list of products for each subcategory
//   static Map<SubCategory, List<Product>> productsBySubcategory = {
//     for (var subcategory in subCategorys)
//       subcategory: getProductsForSubcategory(subcategory)
//   };

//   static List<Product> getRandomProducts(List<SubCategory> subCategorys) {
//     // Create a list of products
//     List<Product> products = [];

//     // crate a 5 random products for each subcategory
//     for (var subcategory in subCategorys) {
//       for (var i = 0; i < 5; i++) {
//         products.add(
//           Product(
//             name: '${subcategory.name} ${i + 1}',
//             image: getRandomImage(subcategory.category),
//             rating: Random().nextInt(5) + 1,
//             price: '${(i + 1) * 10}',
//             description:
//                 'This is a description for product ${subcategory.name} ${i + 1}',
//             subCategorie: subcategory,
//             id: '${i + 1}',
//             nutrition: [
//               'Fat',
//               'Protein',
//               'Carbohydrates',
//               'Fiber',
//               'Vitamin A',
//               'Vitamin C',
//               'Calcium',
//               'Iron',
//             ],
//           ),
//         );
//       }
//     }

//     // Return the list of products
//     return products;
//   }

// get a random image fro unsplash api for the product
  static String getRandomImage(Category category) {
    // var link = 'https://source.unsplash.com/random/400x400/?${category.name}';
    var link = 'https://source.unsplash.com/random/400x400/?makeup';
    return link;
  }

  // static List<SubCategory> getSubcategorysForCategory(Category category) {
  //   return subCategorys
  //       .where((subcategory) => subcategory.category == category)
  //       .toList();
  // }

  static uploadToFirebase() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    for (var i = 0; i < 3; i++) {
      var category = Category(
        name: 'Category ${i + 1}',
        id: '$i',
      );
      var categoriesDoc = firestore.collection('categories').doc(category.id);
      categoriesDoc.set(category.toMap());

      for (var j = 0; j < 3; j++) {
        var subcategory = SubCategory(
          name: 'SubCategory ${j + 1}',
          id: '$i$j',
          discount: 10,
          discrption: 'This is a description for subcategory ${i + 1}',
        );
        var subcategoriesDoc =
            categoriesDoc.collection('subcategories').doc(subcategory.id);
        subcategoriesDoc.set(subcategory.toMap());

        for (var k = 0; k < 3; k++) {
          var product = Product(
            name: 'Product ${k + 1}',
            image: getRandomImage(category),
            price: '${(k + 1) * 10}',
            description: 'This is a description for product ${k + 1}',
            id: '$i$j$k',
            ingredients: [],
            rating: 4.5,
          );
          var productsDoc =
              subcategoriesDoc.collection('products').doc(product.id);
          productsDoc.set(product.toMap());
        }
      }
    }
  }
}
