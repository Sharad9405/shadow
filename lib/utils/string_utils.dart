import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/model/model.dart';

class StringUtils {
  static String TAG = "StringUtils";

  ///Singleton factory
  static final StringUtils _instance = StringUtils._internal();

  factory StringUtils() {
    return _instance;
  }

  StringUtils._internal();

  static bool isValidEmail(String email) {
    print('StringUtils = email = $email');
    if (email
        .trim()
        .isEmpty || email == null) return false;
    bool isValid = RegExp(AppConstant.emailRegExp).hasMatch(email);
    return isValid;
  }

  static log(String message) {
    print(message);
  }

  static List<ProductCategory> getProductCategory() {
    List<ProductCategory> list = [];

    var cat1 = ProductCategory(
        title: 'All Cat', icon: Icons.menu);

    var cat2 = ProductCategory(
        title: 'Offers', icon: Icons.local_offer_outlined);

    var cat3 = ProductCategory(
        title: 'Grocery', icon: Icons.local_grocery_store_outlined);

    var cat4 = ProductCategory(
        title: 'Mobiles', icon: Icons.settings_cell_outlined);

    var cat5 = ProductCategory(
    title: 'Fashion', icon: Icons.fastfood_outlined);

    var cat6 = ProductCategory(
        title: 'Home', icon: Icons.home_outlined);

    var cat7 = ProductCategory(
        title: 'Appliances', icon: Icons.settings_applications);

    var cat8 = ProductCategory(
        title: 'Electronics', icon: Icons.electric_car_outlined);

    var cat9 = ProductCategory(
        title: 'Beauty', icon: Icons.brightness_auto_outlined);

    var cat10 = ProductCategory(
        title: 'Flights', icon: Icons.airplanemode_active_outlined);

    var cat11 = ProductCategory(
        title: 'Food', icon: Icons.food_bank_outlined);

    var cat12 = ProductCategory(
        title: 'Sports', icon: Icons.sports_bar_outlined);
    list.add(cat1);
    list.add(cat2);
    list.add(cat3);
    list.add(cat4);
    list.add(cat5);
    list.add(cat6);
    list.add(cat7);
    list.add(cat8);
    list.add(cat9);
    list.add(cat10);
    list.add(cat11);
    list.add(cat12);
    return list;
  }
}
