import 'package:flutter/material.dart';
import 'package:real_estate/services/auth_services.dart';
import 'package:real_estate/utils/constant.dart';
import 'package:real_estate/widgets/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool notification = true;
  RegExp licensePlateReg = RegExp(r'\d\d\d\d\d[-.]\d\d\d[-.]\d\d');
  RegExp emailReg = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');

  // text field state
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Free Yourself from Parking",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[400]),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: TextInputDecoration.copyWith(
                                hintText: 'Email *'),
                            validator: (val) => !emailReg.hasMatch(val)
                                ? 'Enter an valid email : (exp) parkIt@park.com'
                                : null,
                            onChanged: (val) {
                              _authService.email = val;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: TextInputDecoration.copyWith(
                                hintText: 'Password *'),
                            obscureText: true,
                            validator: (val) =>
                                val.length < 6 ? 'Enter a 6+ chars long' : null,
                            onChanged: (val) {
                              _authService.password = val;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 110.0, vertical: 15.0),
                            color: kprimary,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .registerWithEmailAndPassword;
                                if (result == null) {
                                  setState(() {
                                    error = 'Connexion erreur';
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
                                "Already Have an account? ",
                                style:
                                    TextStyle(color: kprimary, fontSize: 15.0),
                              ),
                              GestureDetector(
                                onTap: () => widget.toggleView(),
                                child: Text(
                                  "Sing In",
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
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ]),
                  ),
                ),
              ),
            ));
  }
}
