import 'package:flutter/material.dart';
import 'package:shadow/ui/ui.dart';

class HomeList {
  HomeList({this.navigateScreen, this.imagePath = ''});

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: MyHomePage(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: MyProfileScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: MyWalletScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: RedeemScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: OffersScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: FAQScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: TenPlusOnePlanScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/sharad.png',
      navigateScreen: MyGoldMinesScreen(),
    ),
  ];
}
