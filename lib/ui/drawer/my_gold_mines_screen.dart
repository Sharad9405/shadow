import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/db/db_helper.dart';
import 'package:shadow/model/model.dart';
import 'package:shadow/view/view.dart';

class MyGoldMinesScreen extends StatefulWidget {
  const MyGoldMinesScreen({Key key}) : super(key: key);
  // final bool refresh;

  @override
  _MyGoldMinesScreenState createState() => _MyGoldMinesScreenState();
}

class _MyGoldMinesScreenState extends State<MyGoldMinesScreen>
    with WidgetsBindingObserver {
  // _MyGoldMinesScreenState(this.refresh);

  // final bool refresh;

  DbHelper mDbHelper = DbHelper.instance;
  List<TenPlusOnePlanModel> _tenPlusPlansList = [];

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    print('didChangeAppLifecycleState = $state');

    if (state == AppLifecycleState.resumed) {
      // _getTenPlusOnePlanData();
    }
  }

  @override
  void initState() {
    // _getTenPlusOnePlanData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Future<List<TenPlusOnePlanModel>> _getTenPlusOnePlanData() async {
    _tenPlusPlansList = await mDbHelper.getAllTenPlusOnePlanFromDb();
    print('Items count in db = ${_tenPlusPlansList.length}');
    return _tenPlusPlansList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TenPlusOnePlanModel>>(
        future: _getTenPlusOnePlanData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TenPlusOnePlanModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    appBarTitle(title: AppConstant.MyGoldMines),
                    Expanded(
                      child: _tenPlusPlansList.length == 0
                          ? Center(
                              child: Text('No record found'),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _tenPlusPlansList.length,
                              itemBuilder: (BuildContext context, int pos) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 17.0, right: 17.0),
                                  child: Card(
                                    child: ListTile(
                                        dense: true,
                                        leading: FlutterLogo(),
                                        trailing: GestureDetector(
                                          child: Icon(Icons.more_vert),
                                          onTap: () {
                                            // _openPopupMenu(pos);
                                          },
                                        ),
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'EMI Amount: ${_tenPlusPlansList[pos].payableEmiAmount}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '${_tenPlusPlansList[pos].planStartAndMaturityDate}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _openPopupMenu([int pos]) {
    return PopupMenuButton<TenPlusOnePlanModel>(
      child: Icon(Icons.input),
      initialValue: _tenPlusPlansList[pos],
      onSelected: _onSelected,
      itemBuilder: (BuildContext context) {
        // return _tenPlusPlansList[pos];
      },
    );
  }

  void _onSelected(TenPlusOnePlanModel model) {
    setState(() {
      // _selected = animals;
      // _value = 'You selected ${_getDisplay(animals)}';
    });
  }
}
