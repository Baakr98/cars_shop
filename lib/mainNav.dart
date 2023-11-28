import 'package:cars_shop/shopScreens/reports/view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'core/constance.dart';
import 'shopScreens/ShopHomeScreen/view.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int selectedIndex = 1;
  final Screen = [
    ShopHomeScreen(),
    const ReportsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return 
    // Obx(() {
    //   return (Get.find<ShopAuthViewModel>().user == null)
    //       ? ShopLogIn()
    //       : 
          Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                color: secondaryColor,
                backgroundColor: Colors.transparent,
                index: selectedIndex,
                items: const [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: black,
                  ),
                  Icon(
                    Icons.edit_note_sharp,
                    size: 30,
                    color: black,
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              body: Screen[selectedIndex],
            );
    }
    // );
  }
// }
