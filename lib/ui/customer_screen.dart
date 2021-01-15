import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shadow/config/config.dart';
import 'package:shadow/http/api/api_service.dart';
import 'package:shadow/model/model.dart';
import 'package:shadow/ui/add_or_update_customer.dart';
import 'package:shadow/view/view.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        backgroundColor: Colors.grey.shade300,
        body: Container(
          width: double.infinity,
          // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 50.0),
                          child: appBarTitle(title: AppConstant.Customer),
                        )),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            elevation: 5.0,
                            mini: true,
                            tooltip: 'Add Customer',
                            foregroundColor: Colors.black,
                            backgroundColor: AppTheme.white,
                            child: Icon(Icons.add),
                            onPressed: () async {
                              var result = await Navigator.push(
                                _scaffoldState.currentContext,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return AddOrUpdateCustomer();
                                }),
                              );
                              if (result != null) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      )),
                ],
              ),
              FutureBuilder(
                future: apiService.getCustomersList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Customer>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          'Something went wrong error : ${snapshot.error}'),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<Customer> customerList = snapshot.data;
                    return _buildListView(customerList);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Customer> customerList) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: customerList.length,
          itemBuilder: (BuildContext, index) {
            Customer customer = customerList[index];
            return Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(customer.email),
                      Text(customer.age.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Warning"),
                                      content: Text(
                                          "Are you sure want to delete data profile ${customer.name}?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            apiService
                                                .deleteCustomers(customer.id)
                                                .then((isSuccess) {
                                              if (isSuccess) {
                                                setState(() {});
                                                ScaffoldMessenger.of(
                                                        this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Delete data success")));
                                              } else {
                                                ScaffoldMessenger.of(
                                                        this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Delete data failed")));
                                              }
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              var result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddOrUpdateCustomer(customer: customer);
                              }));
                              if (result != null) {
                                setState(() {});
                              }
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
