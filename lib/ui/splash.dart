import 'package:flutter/material.dart';
import 'package:shadow/config/app_theme.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/db/db_constant.dart';
import 'package:shadow/db/db_helper.dart';
import 'package:shadow/db/sharedPrefManager.dart';
import 'package:shadow/model/model.dart';
import 'dart:async';
import 'package:shadow/ui/shadow_main.dart';
import 'package:shadow/ui/ui.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: AppTheme.white,
        primaryColorDark: AppTheme.white,
        accentColor: AppTheme.white,
      ), // This is the First Screen
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/signInOrSignUp': (BuildContext context) => new SignInOrSignUp(),
        '/SignIn': (BuildContext context) => new SignIn(),
        '/SignUp': (BuildContext context) => new SignUp(),
        '/ShadowMain': (BuildContext context) => new ShadowMainApp(),
      },
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DbHelper mDbHelper = DbHelper.instance;

  @override
  void initState() {
    _addDummyData();
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool isLogin = false;
    isLogin = await SharedPrefManager().getPrefKey(key: PrefConstant.isLogin);
    if(isLogin != null && isLogin == true){
      print('Splash 1');
      Navigator.pushNamedAndRemoveUntil(context, "/ShadowMain",  (route) => false);
    }else{
      print('Splash 2');
      Navigator.of(context).pushNamed('/signInOrSignUp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Image.asset(
          'assets/images/flutter_logo.png',
          filterQuality: FilterQuality.high,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future _addDummyData() async {
    var result = -1; // if result == 0 => success

    result = await mDbHelper.getAllRecordCountInGoldTable();
    if (result >= 10) {
      print('Already 10 items in db so not inserting records');
      return;
    }

    var item1 = GoldModel(
        title: 'Devotional Gold Ring for Men',
        description: 'Lord Ganesha Ring set in 22 Karat Yellow Gold',
        weight: '7.629',
        price: '48329.00',
        imgUrl: DbConstant.imgGoldRingUrl,
        goldType: 'Ring');

    var item2 = GoldModel(
        title: 'Luminous Pearl Stud Earrings',
        description:
        'Flowerbud Inspired Stud Earrings Crafted in 18 Karat Yellow Gold and studded with Pearls',
        weight: '2.618',
        price: '12437.00',
        imgUrl: DbConstant.imgPearlStudEarringUrl,
        goldType: 'Earring');

    var item3 = GoldModel(
        title: '22 Karat Gold Pendant',
        description: 'Tanishq 22 Karat Gold Pendant',
        weight: '5.618',
        price: '64690.00',
        imgUrl: DbConstant.imgGoldPendantUrl,
        goldType: 'Pendants');

    var item4 = GoldModel(
        title: 'Yellow Gold Mangalsutra',
        description:
        'Tanishq 22 Karat Yellow Gold Mangalsutra with Diamond Cut Patterned Balls and Cylindrical Designs',
        weight: '9.375',
        price: '58686.00',
        imgUrl: DbConstant.imgYellowGoldMangalsutraUrl,
        goldType: 'Mangalsutra');

    var item5 = GoldModel(
        title: 'Regal Gold Chain for Men',
        description: 'Opulent Cable Chain set in 22 Karat Yellow Gold',
        weight: '16.581',
        price: '102133.00',
        imgUrl: DbConstant.imgGoldChainUrl,
        goldType: 'Neckwear');

    var item6 = GoldModel(
        title: 'Diamond Nose Pin',
        description: 'Tanishq 18 Karat Yellow Gold Diamond Nose Pin',
        weight: '0.341',
        price: '9457.00',
        imgUrl: DbConstant.imgDiamondNosePinUrl,
        goldType: 'NoseWear');

    var item7 = GoldModel(
        title: 'Gold Neckwear Set',
        description:
        'Nature Inspired Neckwear and Earrings Set crafted in 22 Karat Yellow Gold',
        weight: '7.629',
        price: '87029.00',
        imgUrl: DbConstant.imgNecklaceSetUrl,
        goldType: 'Neckwear');

    var item8 = GoldModel(
        title: 'Floral Gold Neckwear Set',
        description:
        'Floral Neckwear and Earrings Set Crafted in 22 Karat Yellow Gold',
        weight: '61.869',
        price: '405879.00',
        imgUrl: DbConstant.imgFloralNecklaceSetUrl,
        goldType: 'Neckwear');

    var item9 = GoldModel(
        title: 'Majestic Gold Neckwear Set',
        description:
        'Elaborate Floral Neckwear and Earrings Set Crafted in 22 Karat Yellow Gold',
        weight: '84.760',
        price: '553928.00',
        imgUrl: DbConstant.imgMajesticGoldNecklaceSetUrl,
        goldType: 'Neckwear');

    var item10 = GoldModel(
        title: 'Glorious Floral Gold Neckwear Set',
        description:
        'Floral Choker Neckwear and Earrings Set with Coloured Stones Crafted in 22 Karat Yellow Gold',
        weight: '64.392',
        price: '424396.00',
        imgUrl: DbConstant.imgGloriousFloralGoldNeckwearSetUrl,
        goldType: 'Neckwear');

    try {
      await mDbHelper.insertGoldItemInDb(item7);
      await mDbHelper.insertGoldItemInDb(item8);
      await mDbHelper.insertGoldItemInDb(item9);
      await mDbHelper.insertGoldItemInDb(item10);
      await mDbHelper.insertGoldItemInDb(item3);
      await mDbHelper.insertGoldItemInDb(item1);

      await mDbHelper.insertGoldItemInDb(item1);
      await mDbHelper.insertGoldItemInDb(item2);
      await mDbHelper.insertGoldItemInDb(item4);
      await mDbHelper.insertGoldItemInDb(item5);
      await mDbHelper.insertGoldItemInDb(item6);

      result = await mDbHelper.getAllRecordCountInGoldTable();
      print('total record in db = $result');
    } catch (e) {
      print('_addTenPlusOnePlanIntoDb insert exception = $e');
    }
  }
}
