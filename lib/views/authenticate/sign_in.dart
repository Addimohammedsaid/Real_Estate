import 'package:flutter/material.dart';
import 'package:real_estate/services/auth_services.dart';
import 'package:real_estate/utils/constant.dart';
import 'package:real_estate/widgets/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Hello",
                              style: TextStyle(
                                fontSize: 60.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Looking for a parking ?",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[400]),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: TextInputDecoration.copyWith(
                                  hintText: 'Email'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                _authService.email = val;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: TextInputDecoration.copyWith(
                                  hintText: 'Password'),
                              obscureText: true,
                              validator: (val) => val.length < 6
                                  ? 'Enter a 6+ chars long'
                                  : null,
                              onChanged: (val) {
                                _authService.password = val;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              color: kprimary,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 120.0, vertical: 15.0),
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (_formKey.currentState.validate()) {
                                  dynamic result = await _authService
                                      .signInWithEmailAndPassword;
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Could not Sign in with thoes credentials';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "New to parkIt? ",
                                  style: TextStyle(
                                      color: kprimary, fontSize: 15.0),
                                ),
                                GestureDetector(
                                  onTap: () => widget.toggleView(),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: ksecondary, fontSize: 15.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ]),
                    )),
              ),
            ),
          );
  }
}
