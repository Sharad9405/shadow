import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SignInOrSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
        elevation: 0,
      ),
      body: AppState(),
    );
  }
}


class AppState extends StatefulWidget {
  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<AppState> {

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 0.0),
                        child: ElevatedButton(
                          child: const Text('Sign In'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/SignIn');
                          },
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('------- OR -------'),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          child: const Text('Sign Up'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/SignUp');
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child:  FlatButton(
                              padding: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                              child: Text('Skip'.toUpperCase()
                              ),
                                onPressed: (){
                                print('Skip');
                                Navigator.pushNamedAndRemoveUntil(context, "/ShadowMain",  (route) => false);
                                },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      );
  }
}
