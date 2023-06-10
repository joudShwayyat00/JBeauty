import 'package:jbeauty/main.dart';
import 'package:jbeauty/screens/cart_screen.dart';
import 'package:jbeauty/screens/tabs/fav_tab.dart';
import 'package:jbeauty/screens/tabs/home_tab.dart';
import 'package:jbeauty/screens/tabs/profile_tab.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CartWidget(),
    FavoriteWidget(),
    ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: tr.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            label: tr.cart,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: tr.favorite,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_2_outlined),
            label: tr.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     SampleData.uploadToFirebase();
      //   },
      //   // backgroundColor: Style.primaryColor,
      //   child: const Icon(Icons.add),
      // ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
