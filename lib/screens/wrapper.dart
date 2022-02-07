import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proje_denemesi_fire_base/models/user.dart';
import 'package:proje_denemesi_fire_base/screens/authenticate/authenticate.dart';
import 'package:proje_denemesi_fire_base/screens/home/home.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
   Widget build(BuildContext context) {
     User? user = Provider.of<User?>(context);
     print(user);

    if (user==null){
      return Authenticate();
    }else{
      return Home();
    }

  }
}