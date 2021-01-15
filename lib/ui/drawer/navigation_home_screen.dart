import 'package:flutter/material.dart';

import 'package:shadow/config/config.dart';
import 'package:shadow/ui/gold_products_screen.dart';
import '../ui.dart';
import 'package:shadow/custom_drawer/custom_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget homeScreenView;
  DrawerIndex drawerIndex;

  List<BottomNavigationBarItem> _items;
  int _index = 0;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    homeScreenView = const MyHomePage();
    // bottom nav bar
    _addNavItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexData) {
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
              changeIndex(drawerIndexData);
            },
            screenView: homeScreenView,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _items,
            currentIndex: _index,
            elevation: 15.0,
            selectedItemColor: Colors.lightBlue,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey.shade400,
            onTap: (int item) {
              setState(() {
                _index = item;
                print('Bottom nav index = $item');
                _updateBottomNavBar(_index);
              });
            },
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexData) {
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
    }
    switch (drawerIndexData) {
      case DrawerIndex.HOME:
        {
          setState(() {
            homeScreenView = const MyHomePage();
          });
        }
        break;
      case DrawerIndex.PROFILE:
        {
          setState(() {
            homeScreenView = const MyProfileScreen();
          });
        }
        break;
      case DrawerIndex.MYWALLET:
        {
          setState(() {
            homeScreenView = const MyWalletScreen();
          });
        }
        break;
      case DrawerIndex.REDEEM:
        {
          setState(() {
            homeScreenView = const RedeemScreen();
          });
        }
        break;
      case DrawerIndex.OFFERS:
        {
          setState(() {
            homeScreenView = const OffersScreen();
          });
        }
        break;
      case DrawerIndex.FAQ:
        {
          setState(() {
            homeScreenView = const FAQScreen();
          });
        }
        break;

      case DrawerIndex.TENPLUSONEPLAN:
        {
          setState(() {
            homeScreenView = const TenPlusOnePlanScreen();
          });
        }
        break;
      case DrawerIndex.MYGOLDMINE:
        {
          setState(() {
            homeScreenView = const MyGoldMinesScreen();
          });
        }
        break;

      default:
        {
          setState(() {
            homeScreenView = const MyHomePage();
          });
        }
    }
    /*
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = MyHomePage();
        });
      } else {
        //do in your way......
      }
    }
    */
  }

  void _addNavItems() {
    _items = List<BottomNavigationBarItem>();
  /*

    _items.add(BottomNavigationBarItem(
      label: 'About Us',
      icon: Icon(Icons.info_outline),
    ));
   */

    _items.add(BottomNavigationBarItem(
        label: 'Product List', icon: Icon(Icons.list_alt_outlined)));
    _items.add(BottomNavigationBarItem(
        label: 'Customers', icon: Icon(Icons.group_add)));
    _items.add(BottomNavigationBarItem(label: 'Map', icon: Icon(Icons.map)));
  }

  void _updateBottomNavBar(int index) {
    switch (index) {
      case 0:
        {
          setState(() {
            homeScreenView = GoldProductsScreen();
          });
        }
        break;
      case 1:
        {
          setState(() {
            homeScreenView = CustomersScreen();
          });
        }
        break;
      case 2:
        {
          setState(() {
            homeScreenView = MapViewScreen();
          });
        }
        break;
    }
  }
}
