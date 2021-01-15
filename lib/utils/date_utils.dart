import 'package:intl/intl.dart';
import 'package:shadow/config/config.dart';

class DateUtils{
 static String TAG = "StringUtils";

 ///Singleton factory
 static final DateUtils _instance = DateUtils._internal();

 factory DateUtils() {
   return _instance;
 }

 DateUtils._internal();

 static bool isValidEmail(String email){
   print('StringUtils = email = $email');
   if(email.trim().isEmpty || email == null) return false;
    bool isValid = RegExp(AppConstant.emailRegExp).hasMatch(email);
    return isValid;
  }

  static String getFormattedDate({DateTime inputDate}){
   // final DateTime now = DateTime.now();
   var now = DateTime.now();
   now = inputDate;
   var formatter = DateFormat('d MMM, yyyy');
   var formatted = formatter.format(now);
   print('formatted date = $formatted');
   return formatted;
  }
 static String getElevenMonthsFutureDate({DateTime inputDate}){
  // var now = DateTime.now();
  var now = inputDate;
  var newDate = DateTime(now.year, now.month + 11, now.day - 1);
  var formatter = DateFormat('d MMM, yyyy');
  var formatted = formatter.format(newDate);
  print('formatted date = $formatted');
  return formatted;
 }


}