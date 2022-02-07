import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proje_denemesi_fire_base/models/user.dart';
import 'package:proje_denemesi_fire_base/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proje_denemesi_fire_base/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(value: AuthService().user, initialData: null,child:const MaterialApp(home: Wrapper() ,));
  }
  }

//  MaterialApp(home: Wrapper(),
      
//     );