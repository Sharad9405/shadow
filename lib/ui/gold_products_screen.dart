import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/db/db_constant.dart';
import 'package:shadow/db/db_helper.dart';
import 'package:shadow/model/gold_model.dart';
import 'package:shadow/ui/ui.dart';
import 'package:shadow/view/view.dart';

class GoldProductsScreen extends StatefulWidget {
  @override
  _GoldProductsScreenState createState() => _GoldProductsScreenState();
}

class _GoldProductsScreenState extends State<GoldProductsScreen> {
  DbHelper mDbHelper = DbHelper.instance;
  List<GoldModel> _goldList = [];

  @override
  void initState() {
    // _addDummyData();
    super.initState();
  }

  Future<List<GoldModel>> _getGoldProducts() async {
    _goldList = await mDbHelper.getAllGoldItemListFromDb();
    print('_goldList Items count in db = ${_goldList.length}');
    return _goldList;
  }

  @override
  Widget build(BuildContext context) {
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
              appBarTitle(title: AppConstant.Gold),
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
                        return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: snapshot.data.length-1,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        print('Clicked');
                                        // MaterialPageRoute(
                                        //     builder: (context) => ProductDetailsScreen()
                                        // );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailsScreen(goldModel: _goldList[index],),
                                          ),
                                        );
                                      },
                                      child: Container(
                                            padding: EdgeInsets.all(0),
                                            child: Card(
                                                elevation: 5.0,
                                                shadowColor: Colors.yellow.shade200,
                                                child:  Padding(
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
                                                               tag: '${_goldList[index].id}',
                                                               child: CachedNetworkImage(
                                                                 imageUrl:  _goldList[index].imgUrl,
                                                                 placeholder: (context, bannerPath) => Center(
                                                                   child: CircularProgressIndicator(),
                                                                 ),
                                                                 errorWidget: (context, bannerPath, error) => FlutterLogo(),
                                                                 fit: BoxFit.fill,
                                                               ),
                                                             )
                                                             // )
                                                             /*
                                                            Container(
                                                              padding: EdgeInsets.all(0),
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10.0),
                                                                image: DecorationImage(
                                                                    fit: BoxFit.scaleDown,
                                                                    image: NetworkImage(
                                                                        _goldList[index]
                                                                            .imgUrl)),
                                                              ),
                                                              width: 180.0,
                                                              height: 180.0,
                                                            ),
                                                            */

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
                                          )
                                    );
                                  },
                              );
                        // );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _addDummyData() async {
    var result = -1; // if result == 0 => success

    result = await mDbHelper.getAllRecordCountInGoldTable();
      if(result >= 10){
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
        price: '87.029',
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
      await mDbHelper.insertGoldItemInDb(item1);
      await mDbHelper.insertGoldItemInDb(item2);
      await mDbHelper.insertGoldItemInDb(item3);
      await mDbHelper.insertGoldItemInDb(item4);
      await mDbHelper.insertGoldItemInDb(item5);
      await mDbHelper.insertGoldItemInDb(item6);
      await mDbHelper.insertGoldItemInDb(item7);
      await mDbHelper.insertGoldItemInDb(item8);
      await mDbHelper.insertGoldItemInDb(item9);
      await mDbHelper.insertGoldItemInDb(item10);
      result = await mDbHelper.getAllRecordCountInGoldTable();
      print('total record in db = $result');
    } catch (e) {
      print('_addTenPlusOnePlanIntoDb insert exception = $e');
    }
  }
}
