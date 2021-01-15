import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/db/db_helper.dart';
import 'package:shadow/model/gold_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({this.goldModel, Key key}) : super(key: key);

  GoldModel goldModel;

  @override
  _ProductDetailsScreenState createState() =>
      _ProductDetailsScreenState(goldModel);
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  _ProductDetailsScreenState(this.goldModel);


  DbHelper mDbHelper = DbHelper.instance;

  GoldModel goldModel;
  List<GoldModel> _goldList = [];

  final _formKey = GlobalKey<FormState>();
  var _titleTextEditingController = TextEditingController();
  var _descriptionTextEditingController = TextEditingController();
  var _weightTextEditingController = TextEditingController();
  var _priceTextEditingController = TextEditingController();

  @override
  void initState() {
    // _getGoldProducts();
    _titleTextEditingController.text = goldModel.title;
    _descriptionTextEditingController.text = goldModel.description;
    _weightTextEditingController.text = goldModel.weight;
    _priceTextEditingController.text = goldModel.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(bottom: 50),
          scrollDirection: Axis.vertical,
          children: [
            Stack(
              children: [
                goldImage(),
                backButton(),
                editButton(),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _goldTitle(goldModel.title),
                  _goldDescription(goldModel.description),
                  _goldWeight(goldModel.weight),
                  _goldPrice(goldModel.price),
                  SizedBox(height: 20),
                ],
              ),
            ),

            _similarItems(),
            SizedBox(height: 20),
            FutureBuilder(
              future: _getGoldProducts(),
              builder: (context,  AsyncSnapshot<List<GoldModel>> snapshot){
                if(snapshot.hasData){
                  return  CarouselSlider(
                    items: _getAllImagesListWidget(),
                    options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.7
                    ),
                  );
                }else{
                  return Align(
                    alignment: Alignment.center,
                    child: Text('No Data'),
                  );
                }
              },
            ),

            _otherItems(),
            FutureBuilder(
              future: _getGoldProducts(),
              builder: (context,  AsyncSnapshot<List<GoldModel>> snapshot){
                if(snapshot.hasData){
                  return  CarouselSlider(
                    // items: _getAllImagesList(),
                    items: [
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage("https://cdn.pixabay.com/photo/2021/01/05/12/55/springbok-5891080_960_720.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage("https://media.istockphoto.com/photos/running-springbok-jumping-high-picture-id175718573"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage("https://cdn.pixabay.com/photo/2020/12/30/14/26/impala-5873636_960_720.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage("https://media.istockphoto.com/photos/an-impala-antelope-at-a-waterhole-picture-id989500822"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage("https://media.istockphoto.com/photos/impala-antelopes-fighting-etosha-picture-id1089991394"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.7
                    ),
                  );
                }else{
                  return Align(
                    alignment: Alignment.center,
                    child: Text('No Data'),
                  );
                }
              },
            ),


         ]
        ));
  }

  _updateUi(){
    setState(() {
        _goldTitle(goldModel.title);
        _goldDescription(goldModel.description);
        _goldWeight(goldModel.weight);
        _goldPrice(goldModel.price);
    });
  }

  _goldTitle(String title) {
    return Text(
      '$title',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
  _goldDescription(String des) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'Des: $des',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  _goldWeight(String weight) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        'weight: $weight g',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  _goldPrice(String price) {
    double p = double.parse(price) + 1200.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Price: ${AppConstant.symbolRupee}$price',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '${AppConstant.symbolRupee}$p',
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  _similarItems() {
    return Padding(
        padding: EdgeInsets.only(left: 20, top: 35, bottom: 20),
        child: Text(
            'Similar Products:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.start,
          ),
        );
  }
  _otherItems() {
    return Padding(
        padding: EdgeInsets.only(left: 20, top: 35, bottom: 20),
        child: Text(
            'Others:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.start,
          ),
        );
  }

  Widget backButton() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10),
        child: Align(

          alignment: Alignment.topLeft,
          child: FloatingActionButton(
            heroTag: 'back',
            elevation: 5.0,
            mini: true,
            tooltip: 'Back',
            foregroundColor: Colors.grey.shade700,
            backgroundColor: AppTheme.white,
            child: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
  Widget editButton() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 15.0, right: 10),
        child: Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(
            heroTag: 'edit',
            elevation: 5.0,
            mini: true,
            tooltip: 'Edit',
            foregroundColor: Colors.grey.shade700,
            backgroundColor: AppTheme.white,
            child: Icon(Icons.edit),
            onPressed: () async {
              await  _showUpdateDialog(goldModel);
            },
          ),
        ),
      ),
    );

  }

 Future _showUpdateDialog(GoldModel model) async {
   return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context){
          return Container(
            padding: EdgeInsets.all(15.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child:  FloatingActionButton(
                          heroTag: 'close',
                          elevation: 5.0,
                          mini: true,
                          tooltip: 'close',
                          foregroundColor: Colors.grey.shade700,
                          backgroundColor: AppTheme.white,
                          child: Icon(Icons.close),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                    ),

                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            TextFormField(
                              controller: _titleTextEditingController,
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.title),
                                hintText: 'Enter title',
                                labelText: 'Title',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.always,
                              validator: (value){
                                if(value.trim().isEmpty){
                                  return 'Please enter title';
                                }else{
                                  return null;
                                }
                              },
                              maxLines: 1,
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: _descriptionTextEditingController,
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.title),
                                hintText: 'Enter product description',
                                labelText: 'Description',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.always,
                              validator: (value){
                                if(value.trim().isEmpty){
                                  return 'Please enter description';
                                }else{
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: _weightTextEditingController,
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.title),
                                hintText: 'Enter product weight',
                                labelText: 'Weight',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.always,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              validator: (value){
                                if(value.trim().isEmpty){
                                  return 'Please enter weight';
                                }else{
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: _priceTextEditingController,
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.title),
                                hintText: 'Enter product price',
                                labelText: 'Price',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              autovalidateMode: AutovalidateMode.always,
                              validator: (value){
                                if(value.trim().isEmpty){
                                  return 'Please enter price';
                                }else{
                                  return null;
                                }
                              },
                              maxLines: 1,
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),

                      ),

                    ),
/*
                    RaisedButton(
                      child: Text('Update'),
                      onPressed: () {

                       *//*
                        if(_formKey.currentState.validate()){
                          var data = GoldModel(
                            title: _titleTextEditingController.text.trim(),
                            description: _descriptionTextEditingController.text.trim(),
                            weight: _weightTextEditingController.text.trim(),
                            price: _priceTextEditingController.text.trim(),
                            goldType: model.goldType,
                            imgUrl: model.imgUrl,
                            id: model.id
                          );
                          print('Update gold model = ${data.toString()}');
                          // Navigator.pop(context);
                        }
                        *//*
                      } ,
                    ),
                */


                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 40.0, left: 20,right: 20),
                  child: ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        var data = GoldModel(
                            title: _titleTextEditingController.text.trim(),
                            description: _descriptionTextEditingController.text.trim(),
                            weight: _weightTextEditingController.text.trim(),
                            price: _priceTextEditingController.text.trim(),
                            goldType: model.goldType,
                            imgUrl: model.imgUrl,
                            id: model.id
                        );
                        print('Update gold model = ${data.toString()}');

                        try{
                          var result = await mDbHelper.updateGoldItemRecord(data.id, data);
                          print('update result = $result');
                        }catch(e){
                          print('update record exception = $e');
                        }
                        try{
                          var p = await mDbHelper.getGoldItemById(data.id);
                          print('get item by id = $p');
                          Navigator.pop(context);
                          goldModel = p;
                          _updateUi();
                        }catch(e){
                          print('fetch record by id exception = $e');
                        }
                      }
                      // Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Container goldImage() {
    return Container(
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      child: Hero(
        tag: '${goldModel.id}',
        child: CachedNetworkImage(
          imageUrl: goldModel == null ? '' : goldModel.imgUrl,
          placeholder: (context, bannerPath) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, bannerPath, error) => FlutterLogo(),
          height: 400.0,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _getAllImagesListWidget() {
    List<Widget> list = [];

    print('count = ${_goldList.length}');
    if (_goldList.length > 0) {
      for (int i = 0; i < _goldList.length; i++) {

        Widget c = Card(
          shadowColor: Colors.grey,
          elevation: 2.0,
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

  Future<List<GoldModel>> _getGoldProducts() async {
    _goldList = await mDbHelper.getAllGoldItemListFromDb();
    print('_goldList Items count in db = ${_goldList.length}');
    return _goldList;
  }
}
