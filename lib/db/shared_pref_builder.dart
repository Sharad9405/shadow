
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefBuilder<T> extends StatelessWidget{

  final String prefKey;
  final AsyncWidgetBuilder<T> builder;

  const SharedPrefBuilder({Key key, @required this.prefKey, @required this.builder}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot){
          return this.builder(context, snapshot);
      },
    );
  }

  _future() async{
    return (await SharedPreferences.getInstance()).get(prefKey);
  }
}


// use like 
class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SharedPrefBuilder<String>(
      prefKey: 'access_token',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return snapshot.hasData ? Text(snapshot.data) : Container();
      },
    );
  }
}