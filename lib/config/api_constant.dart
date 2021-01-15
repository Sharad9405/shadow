
class ApiConstant{

  ///Singleton factory
  static final ApiConstant _instance = ApiConstant._internal();

  factory ApiConstant() {
    return _instance;
  }

  ApiConstant._internal();

  static final baseUrl = 'http://api.bengkelrobot.net:8001/api/';
  static final profile = 'profile';


}