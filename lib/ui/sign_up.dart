import 'package:flutter/material.dart';
import 'package:shadow/utils/utils.dart';

class SignUp extends StatelessWidget {
  // static const routeName = '/homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SignUpFormBody(),
    );
  }
}

class SignUpFormBody extends StatefulWidget {
  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<SignUpFormBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
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
                    padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                    child: ElevatedButton(
                       child: const Text('Sign Up'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // Scaffold.of(context).showSnackBar(SnackBar(
                          //   content: Text('Valid input'),
                          // ));
                          Navigator.pushNamedAndRemoveUntil(context, "/ShadowMain",  (route) => false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
