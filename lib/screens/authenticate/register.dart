import 'package:flutter/material.dart';
import 'package:proje_denemesi_fire_base/services/auth.dart';
import 'package:proje_denemesi_fire_base/shared/constants.dart';
import 'package:proje_denemesi_fire_base/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String err = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            style: ElevatedButton.styleFrom(
                primary: Colors.brown[400], elevation: 0.0),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: "Email"),
                      
                              
                  validator: (val) => val!.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) =>
                      val!.length < 6 ? "Enter a password 6+ chars long" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.pink),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(()=>loading=true);
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() { err = "please suply a valid email ";
                        loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(err, style: TextStyle(color: Colors.red, fontSize: 14.0))
              ],
            ),
          )),
    );
  }
}
