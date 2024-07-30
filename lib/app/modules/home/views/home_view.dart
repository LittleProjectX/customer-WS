import 'package:flutter/material.dart';
import 'package:waroengsederhana/app/modules/home/pages/all_orders.dart';
import 'package:waroengsederhana/app/modules/home/pages/food_page.dart';
import 'package:waroengsederhana/app/modules/home/pages/message.dart';
import 'package:waroengsederhana/app/modules/home/pages/profile.dart';
import 'package:waroengsederhana/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onTapNavigator(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pageOption = [
    const FoodPage(),
    Message(),
    AllOrders(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.fastfood),
              ),
              label: 'MENU'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.message),
              ),
              label: 'PESAN'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.shopping_cart_checkout),
              ),
              label: 'PESAN'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.person),
              ),
              label: 'PROFIL')
        ],
        iconSize: 30,
        unselectedItemColor: greyColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        backgroundColor: backgroundColor,
        onTap: (value) {
          _onTapNavigator(value);
        },
        selectedItemColor: tabColor,
      ),
    );
  }
}
