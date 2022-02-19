import 'package:flutter/material.dart';
import 'package:toko_ada/model/user.dart';
import 'package:toko_ada/view/seller/orderpage.dart';
import 'package:toko_ada/view/seller/productpage.dart';
import 'package:toko_ada/view/customer/cartpage.dart';
import 'package:toko_ada/view/customer/homepage.dart';
import 'package:toko_ada/view/profilepage.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Toko Ada";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
        ),
      ),
      title: 'Toko Ada',
      home: Scaffold(
          appBar: AppBar(
            title: Text(maintitle),
          ),
          body: tabchildren[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: widget.user.level == "1"
                      ? const Icon(Icons.store_mall_directory)
                      : const Icon(Icons.home),
                  label: widget.user.level == "1" ? "Product" : "Home"),
              BottomNavigationBarItem(
                  icon: widget.user.level == "1"
                      ? const Icon(Icons.format_list_bulleted)
                      : const Icon(Icons.local_grocery_store),
                  label: widget.user.level == "1" ? "Order" : "Cart"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.user.level == "1") {
      maintitle = "Products";
      tabchildren = [
        //Admin
        ProductPage(user: widget.user), //TabPage1
        OrderPage(user: widget.user), //TabPage2
        ProfilePage(user: widget.user), //TabPage3
      ];
    } else {
      maintitle = "Home";
      tabchildren = [
        //Customer
        HomePage(
          user: widget.user,
        ), //TabPage1
        CartPage(user: widget.user), //TabPage2
        ProfilePage(
          user: widget.user,
        ), //TabPage3
      ];
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (_currentIndex) {
        case 0:
          if (widget.user.level == "1") {
            maintitle = "Products";
          } else {
            maintitle = "Home";
          }
          break;
        case 1:
          if (widget.user.level == "1") {
            maintitle = "Order";
          } else {
            maintitle = "Cart";
          }
          break;
        case 2:
          maintitle = "Profile";
          break;
        default:
          maintitle = "Toko Ada";
      }
    });
  }
}