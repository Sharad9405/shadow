import 'package:flutter/material.dart';
import 'package:shadow/utils/utils.dart';

class SignIn extends StatelessWidget {
  // static const routeName = '/homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('SignIn'),
        elevation: 0,
      ),
      body: FormBody(),
    );
  }
}

class FormBody extends StatefulWidget {
  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.email_outlined),
                  hintText: 'Enter email id',
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (!StringUtils.isValidEmail(value)) {
                    return 'Please enter a valid email id';
                  }
                  return null;
                },
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.lock_outline),
                  hintText: 'Enter password',
                  labelText: 'Password',

                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //   content: Text('Valid input'),
                      // ));

                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushNamedAndRemoveUntil(context, "/ShadowMain",  (route) => false);
                    }
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
            ],
          ),
        ));
  }
}
