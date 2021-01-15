import 'package:flutter/material.dart';
import 'package:shadow/http/api/api_service.dart';
import 'package:shadow/model/model.dart';

final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

class AddOrUpdateCustomer extends StatefulWidget {
 final Customer customer;

  AddOrUpdateCustomer({this.customer});

  @override
  _AddOrUpdateCustomerState createState() => _AddOrUpdateCustomerState();
}

class _AddOrUpdateCustomerState extends State<AddOrUpdateCustomer> {

  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldAgeValid;
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _ageController = TextEditingController();

  @override
  void initState() {
    if(widget.customer != null){
      _isFieldNameValid = true;
      _nameController.text = widget.customer.name;
      _isFieldEmailValid = true;
      _emailController.text = widget.customer.email;
      _isFieldAgeValid = true;
      _ageController.text = widget.customer.age.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.customer == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               _buildTextFieldName(),
               _buildTextFieldEmail(),
               _buildTextFieldAge(),

               Padding(
                 padding: const EdgeInsets.only(top: 8.0),
                 child: RaisedButton(
                   child: Text(
                     widget.customer == null
                         ? "Submit".toUpperCase()
                         : "Update Data".toUpperCase(),
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ),
                   onPressed: () {
                     if (_isFieldNameValid == null ||
                         _isFieldEmailValid == null ||
                         _isFieldAgeValid == null ||
                         !_isFieldNameValid ||
                         !_isFieldEmailValid ||
                         !_isFieldAgeValid) {
                       _scaffoldStateKey.currentState.showSnackBar(
                         SnackBar(
                           content: Text("Please fill all field"),
                         ),
                       );
                       return;
                     }
                     setState(() => _isLoading = true);
                     String name = _nameController.text.toString();
                     String email = _emailController.text.toString();
                     int age = int.parse(_ageController.text.toString());
                     Customer profile =
                     Customer(name: name, email: email, age: age);
                     if (widget.customer == null) {
                       _apiService.createCustomers(profile).then((isSuccess) {
                         setState(() => _isLoading = false);
                         if (isSuccess) {
                           Navigator.pop(_scaffoldStateKey.currentState.context, true);
                         } else {
                           _scaffoldStateKey.currentState.showSnackBar(SnackBar(
                             content: Text("Submit data failed"),
                           ));
                         }
                       });
                     } else {
                       profile.id = widget.customer.id;
                       _apiService.updateCustomers(profile).then((isSuccess) {
                         setState(() => _isLoading = false);
                         if (isSuccess) {
                           Navigator.pop(_scaffoldStateKey.currentState.context, true);
                         } else {
                           _scaffoldStateKey.currentState.showSnackBar(SnackBar(
                             content: Text("Update data failed"),
                           ));
                         }
                       });
                     }
                   },
                   color: Colors.orange[600],
                 ),
               ),
             ],
            ),
          ),
        ],
      ),

    );
  }


  Widget _buildTextFieldName() {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Full name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }


  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }


  Widget _buildTextFieldAge() {
    return TextField(
      controller: _ageController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Age",
        errorText: _isFieldAgeValid == null || _isFieldAgeValid
            ? null
            : "Age is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAgeValid) {
          setState(() => _isFieldAgeValid = isFieldValid);
        }
      },
    );
  }


}
