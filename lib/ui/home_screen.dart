import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'package:shadow/config/config.dart';
import 'package:shadow/db/db_constant.dart';
import 'package:shadow/db/db_helper.dart';
import 'package:shadow/model/model.dart';
import 'package:shadow/ui/ui.dart';
import 'package:shadow/utils/string_utils.dart';
import 'package:shadow/view/view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController animationController;
  bool multiple = true;
  DbHelper mDbHelper = DbHelper.instance;
  List<GoldModel> _goldList = [];
  List<ProductCategory> _categoryList = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _categoryList = StringUtils.getProductCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarTitle(title: AppConstant.Home),
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
                  child: FutureBuilder<List<GoldModel>>(
                    future: _getGoldProducts(),
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text('No Data Found'),
                        );
                      } else {
                        return _goldList.length == 0
                            ? Center(child: Text('No data'))
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: _goldList.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        print('Clicked');
                                        // MaterialPageRoute(
                                        //     builder: (context) => ProductDetailsScreen()
                                        // );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                              goldModel: _goldList[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        child: Card(
                                          elevation: 5.0,
                                          shadowColor: Colors.yellow.shade200,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                bottom: 10.0,
                                                top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: CachedNetworkImage(
                                                      imageUrl: _goldList[index]
                                                          .imgUrl,
                                                      placeholder: (context,
                                                              bannerPath) =>
                                                          Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              bannerPath,
                                                              error) =>
                                                          FlutterLogo(),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),

                                                Text(
                                                  _goldList[index].title,
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   _goldList[index].description,
                                                //   style: TextStyle(
                                                //       fontSize: 11.0,
                                                //       color: Colors.grey,
                                                //       fontWeight:
                                                //       FontWeight.w200),
                                                // ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                Text(
                                                  'weight: ${_goldList[index].weight} g',
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                // Spacer(flex: 1,),
                                                Text(
                                                  'Price: ${AppConstant.symbolRupee} ${_goldList[index].price}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: AppTheme.darkText,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              );
                        // );
                      }
                    },
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  */

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppTheme.white,
            centerTitle: true,
            title: Text(
              AppConstant.Home,
              style: TextStyle(
                fontSize: 22,
                color: AppTheme.darkText,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.only(top: 0),
            scrollDirection: Axis.vertical,

            /*
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  // expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    // title: appBarTitle(title: AppConstant.Home),
                    collapseMode: CollapseMode.parallax,
                    // background: Image.asset('assets/images/str.jpeg'),
                    centerTitle: true,
                  ),
                  pinned: true,
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  floating: false,
                  actions: [
                    cartButton(),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(100),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _categoryList.length,
                        itemBuilder: (context, pos) {
                          return Container(
                            height: 70,
                            width: 70,
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                shape: BoxShape.circle),
                            padding: EdgeInsets.all(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  _categoryList[pos].icon,
                                  color: Colors.grey.shade500,
                                  size: 20,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('${_categoryList[pos].title}',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ];
            },
            */

            children: <Widget>[
              Container(
                  height: 100,
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categoryList.length,
                      itemBuilder: (context, pos) {
                        return Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                _categoryList[pos].icon,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${_categoryList[pos].title}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  )),
                            ],
                          ),
                        );
                      })),
              FutureBuilder<List<GoldModel>>(
                future: _getGoldProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<GoldModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        child: Text('No Data Found'),
                      ),
                    );
                  } else {
                    return GridView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: snapshot.data.length-1,
                            // _goldList.length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    print('Clicked');
                                    // MaterialPageRoute(
                                    //     builder: (context) => ProductDetailsScreen()
                                    // );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                          goldModel: _goldList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    child: Card(
                                      elevation: 5.0,
                                      shadowColor: Colors.yellow.shade200,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            bottom: 10.0,
                                            top: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Hero(
                                                    tag:
                                                        '${_goldList[index].id}',
                                                    child: CachedNetworkImage(
                                                      imageUrl: _goldList[index]
                                                          .imgUrl,
                                                      placeholder: (context,
                                                              bannerPath) =>
                                                          Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              bannerPath,
                                                              error) =>
                                                          FlutterLogo(),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                  // )

                                                  ),
                                            ),

                                            Text(
                                              _goldList[index].title,
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'weight: ${_goldList[index].weight} g',
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            // Spacer(flex: 1,),
                                            Text(
                                              'Price: ${AppConstant.symbolRupee} ${_goldList[index].price}',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: AppTheme.darkText,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          );
                    // );
                  }
                },
              ),
              _infoLabel(label: 'Similar Items'),
              SizedBox(height: 20),
              _similarProductsCorouselSlider(),
              _infoLabel(label: 'Other Items'),
              _otherProductsCorouselSlider(),
            ],

            /*
            body: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FutureBuilder<List<GoldModel>>(
                        future: _getGoldProducts(),
                        builder: (BuildContext context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text('No Data Found'),
                            );
                          } else {
                            return _goldList.length == 0
                                ? Center(child: Text('No data'))
                                : GridView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                    itemCount: 6, // _goldList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            print('Clicked');
                                            // MaterialPageRoute(
                                            //     builder: (context) => ProductDetailsScreen()
                                            // );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                  goldModel: _goldList[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(0),
                                            child: Card(
                                              elevation: 5.0,
                                              shadowColor:
                                                  Colors.yellow.shade200,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    bottom: 10.0,
                                                    top: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Hero(
                                                            tag:
                                                                '${_goldList[index].id}',
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  _goldList[
                                                                          index]
                                                                      .imgUrl,
                                                              placeholder: (context,
                                                                      bannerPath) =>
                                                                  Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                              errorWidget: (context,
                                                                      bannerPath,
                                                                      error) =>
                                                                  FlutterLogo(),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                          // )

                                                          ),
                                                    ),

                                                    Text(
                                                      _goldList[index].title,
                                                      style: TextStyle(
                                                          fontSize: 11.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'weight: ${_goldList[index].weight} g',
                                                      style: TextStyle(
                                                          fontSize: 11.0,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    // Spacer(flex: 1,),
                                                    Text(
                                                      'Price: ${AppConstant.symbolRupee} ${_goldList[index].price}',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              AppTheme.darkText,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    },
                                  );
                            // );
                          }
                        },
                      ),
                    ),
                    _similarItems(),
                    SizedBox(height: 20),
                    FutureBuilder(
                      future: _getGoldProducts(),
                      builder:
                          (context, AsyncSnapshot<List<GoldModel>> snapshot) {
                        if (snapshot.hasData) {
                          return CarouselSlider(
                            items: _getAllImagesListWidget(),
                            options: CarouselOptions(
                                height: 150,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.7),
                          );
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: Text('No Data'),
                          );
                        }
                      },
                    ),
                  ],
                )),

         */
          )),
    );
  }

  _infoLabel({String label}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 35, bottom: 20),
      child: Text(
        '$label:',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  _similarProductsCorouselSlider() {
    return FutureBuilder(
      future: _getGoldProducts(),
      builder: (context, AsyncSnapshot<List<GoldModel>> snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider(
            items: _getAllImagesListWidget(),
            options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.7),
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: Text('No Data'),
          );
        }
      },
    );
  }

  _otherProductsCorouselSlider() {
    return FutureBuilder(
      future: _getGoldProducts(),
      builder: (context, AsyncSnapshot<List<GoldModel>> snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider(
            // items: _getAllImagesList(),
            items: [
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2021/01/05/12/55/springbok-5891080_960_720.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://media.istockphoto.com/photos/running-springbok-jumping-high-picture-id175718573"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2020/12/30/14/26/impala-5873636_960_720.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://media.istockphoto.com/photos/an-impala-antelope-at-a-waterhole-picture-id989500822"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://media.istockphoto.com/photos/impala-antelopes-fighting-etosha-picture-id1089991394"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.7),
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: Text('No Data'),
          );
        }
      },
    );
  }

  List<Widget> _getAllImagesListWidget() {
    List<Widget> list = [];

    print('count = ${_goldList.length}');
    if (_goldList.length > 0) {
      for (int i = 0; i < _goldList.length; i++) {
        Widget c = Card(
          shadowColor: Colors.grey,
          elevation: 1.0,
          child: Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(_goldList[i].imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

/*
        w = Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(_goldList[i].imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        );
        */
        list.add(c);
      }
    }
    return list;
  }

  Widget cartButton() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 20),
        child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                print('Cart');
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
            )),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  Future<List<GoldModel>> _getGoldProducts() async {
    _goldList = await mDbHelper.getAllGoldItemListFromDb();
    print('_goldList Items count in db = ${_goldList.length}');
    return _goldList;
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
              ),
            ),
            */

          // Expanded(
          //   child:
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 22,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // ),
          ),

          /*
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      multiple ? Icons.dashboard : Icons.view_agenda,
                      color: AppTheme.dark_grey,
                    ),
                    onTap: () {
                      setState(() {
                        multiple = !multiple;
                      });
                    },
                  ),
                ),
              ),
            ),

            */
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
