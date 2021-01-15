import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/db/db_helper.dart';
import 'package:shadow/model/model.dart';
import 'package:shadow/view/view.dart';
import 'package:shadow/utils/utils.dart';

class TenPlusOnePlanScreen extends StatefulWidget {
  const TenPlusOnePlanScreen({Key key}) : super(key: key);

  @override
  _TenPlusOnePlanScreenState createState() => _TenPlusOnePlanScreenState();
}

class _TenPlusOnePlanScreenState extends State<TenPlusOnePlanScreen> {
  final _emiFormKey = GlobalKey<FormState>();
  var _emiTextFormFieldController = TextEditingController();
  double _firstEmiOff;
  double _ninethEmi;
  double _eleventhEmi;
  double _totalPurchaseAmount;
  double _totalSaving;
  String _planStartDateAndMaturityDate;

  DbHelper mDbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    _emiTextFormFieldController.addListener(_updateLatestEmiValue);
    _firstEmiOff = 0;
    _ninethEmi = 0;
    _eleventhEmi = 0;
    _totalPurchaseAmount = 0;
    _totalSaving = 0;
    _planStartDateAndMaturityDate = 'Start Plan Date';
  }

  _resetValues(){
    _emiTextFormFieldController.text = '';
    _planStartDateAndMaturityDate = 'Start Plan Date';
  }

  _updateLatestEmiValue() {
    print('Latest value = ${_emiTextFormFieldController.text}');
    setState(() {
      if (_emiTextFormFieldController.text.isEmpty) {
        _firstEmiOff = 0;
        _ninethEmi = 0;
        _eleventhEmi = 0;
        _totalPurchaseAmount = 0;
        _totalSaving = 0;
      } else {
        double value = double.parse(_emiTextFormFieldController.text);
        print('value = $value');
        _firstEmiOff = value / 2;
        _ninethEmi = value;
        _eleventhEmi = 0;
        double f = _firstEmiOff.toDouble();
        double e = value;
        double total = value * 11;

        _totalPurchaseAmount = total;
        _totalSaving = f + e;
      }
    });
  }

  @override
  void dispose() {
    _emiTextFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Form(
          key: _emiFormKey,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery
                .of(context)
                .padding
                .top),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBarTitle(title: AppConstant.TenPlusOnePlan),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0, right: 20.0, bottom: 10.0),
                        child: FlatButton(
                          onPressed: (){
                            _openDatePickerDialog();
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // 'Plan Start Date: 10th Jan, 2021\nPlan Maturity Date: 10th Dec, 2021',
                              '$_planStartDateAndMaturityDate',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Padding(
                          padding: EdgeInsets.all(0.0),

                          child: TextFormField(
                            // onChanged: (text){
                            //   print('latest value = $text');
                            // },
                            controller: _emiTextFormFieldController,
                            style: TextStyle(
                              fontSize: 22,
                              color: AppTheme.darkText,
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter amount',
                                labelText: 'Payable emi Amount'),
                            validator: (value) {
                              if (value
                                  .trim()
                                  .isEmpty) {
                                return 'Please enter payable amount as emi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                          '1st EMI: $_firstEmiOff (50% OFF)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                          '9th EMI: $_ninethEmi',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                          '11th EMI: 0 (100% OFF)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                          'Total Purchase\nAmount: $_totalPurchaseAmount',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey.shade50,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                          'Your Savings:\nINR ${(_totalSaving.toStringAsFixed(
                              2))}/-',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 20, bottom: 20),
                    child: RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        print(
                            '**************** btn Clicked Start ****************');
                        _addTenPlusOnePlanIntoDb();
                        print(
                            '**************** btn Clicked end ****************');
                      },
                      elevation: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _openDatePickerDialog(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context){
        return Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Icon(Icons.close),
                      padding: EdgeInsets.all(20.0),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),

              Text('Please select plan start date:',
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (DateTime pickedTime){
                          // 2021-01-14 01:02:00.000
                          print('picked Time = $pickedTime');

                          String startDate = DateUtils.getFormattedDate(inputDate: pickedTime);
                          print('startDate = $startDate');
                          setState(() {
                            _planStartDateAndMaturityDate = 'Plan Start Date: $startDate\n'
                                'Plan Maturity Date: ${DateUtils.getElevenMonthsFutureDate(inputDate: pickedTime)}';
                          });
                        },
                      ),
                    ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Future _addTenPlusOnePlanIntoDb() async {
    var result = -1; // if result == 0 => success
    if (_emiFormKey.currentState.validate()) {
      TenPlusOnePlanModel model = TenPlusOnePlanModel(
          id: 0,
          payableEmiAmount: _emiTextFormFieldController.text.trim(),
          firstEmiOff: '$_firstEmiOff',
          ninethEmi: '$_ninethEmi',
          eleventhEmi: '$_eleventhEmi',
          totalPurchaseAmount: '$_totalPurchaseAmount',
          totalSaving: '$_totalSaving',
          planStartAndMaturityDate: _planStartDateAndMaturityDate
      );

      try {
        result = await mDbHelper.insertTenPlusOnePlanInDb(model);
        if(result != null && result != -1){
          _showSnackBar('Record inserted successfully');
        }
      } catch (e) {
        print('_addTenPlusOnePlanIntoDb insert exception = $e');
        _showSnackBar('$e');
      }
    } else {
      print('Sharad');
    }
    print('$TenPlusOnePlanScreen _addTenPlusOnePlanIntoDb(): result = $result');

    try {
      var dbData = await mDbHelper.getAllTenPlusOnePlanFromDb();
      print('$TenPlusOnePlanScreen _addTenPlusOnePlanIntoDb(): dbData = $dbData');
    } catch (e) {
      print('_addTenPlusOnePlanIntoDb fetch record exception = $e');
    }

    _resetValues();
  }

  _showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(snackBar(message));
  }

  snackBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
}
