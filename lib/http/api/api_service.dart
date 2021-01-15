import 'package:http/http.dart' show Client;
import 'package:shadow/config/config.dart';
import 'package:shadow/model/model.dart';

class ApiService{
  final String baseUrl = ApiConstant.baseUrl;
  final String profile = ApiConstant.profile;

  Client client = Client();

  Future<List<Customer>> getCustomersList() async {
    print('getCustomer list api calling');
    final response = await client.get("$baseUrl$profile");
    if (response.statusCode == 200) {
      return employeeFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createCustomers(Customer data) async{
    final response = await client.post(
      '$baseUrl$profile',
      headers: {'content-type': 'application/json'},
      body: employeeToJson(data)
    );
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updateCustomers(Customer data) async {
    final response = await client.put(
      "$baseUrl$profile/${data.id}",
      headers: {"content-type": "application/json"},
      body: employeeToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCustomers(int id) async {
    final response = await client.delete(
      "$baseUrl${ApiConstant.profile}/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


}