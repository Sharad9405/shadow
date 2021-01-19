
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager{
  static final _Tag = 'SharedPrefManager';
  ///Singleton factory
  static final SharedPrefManager _instance = SharedPrefManager._internal();

  factory SharedPrefManager() {
    return _instance;
  }
  

  SharedPrefManager._internal();

  setPrefKey(String key, dynamic value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(value is int){
      print('$_Tag: setPrefKey = $value value is int');
      pref.setInt(key, value);
    }else if(value is String){
      print('$_Tag: setPrefKey = $value value is String');
      pref.setString(key, value);
    }else if(value is bool){
      print('$_Tag: setPrefKey = $value value is bool');
      pref.setBool(key, value);
    }else if(value is double){
      print('$_Tag: setPrefKey = $value value is double');
      pref.setDouble(key, value);
    }else{
      print('$_Tag: setPrefKey = $value value is undefined');
    }
 /*   switch(value){
      case int:{
        print('$_Tag: setPrefKey = $value value is int');
        pref.setInt(key, value);
      }break;
      case String:{
        print('$_Tag: setPrefKey = $value value is String');
        pref.setString(key, value);
      }break;
      case bool:{
        print('$_Tag: setPrefKey = $value value is bool');
        pref.setBool(key, value);
      }break;
      case double:{
        print('$_Tag: setPrefKey = $value value is double');
        pref.setDouble(key, value);
      }break;

      default:{
        print('$_Tag: setPrefKey = $value value is undefined');
      }
    }*/
  }

 Future<dynamic> getPrefKey({String key}) async{
    // SharedPreferences pref = await SharedPreferences.getInstance();
    var result = (await SharedPreferences.getInstance()).get(key);
    print('$_Tag  getPrefKey() result = $result}');
    return result;
  }

  Future<bool> clear() async{
    var result = (await SharedPreferences.getInstance()).clear();
    return result;
  }



}