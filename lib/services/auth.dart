import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proje_denemesi_fire_base/models/user.dart';
import 'package:proje_denemesi_fire_base/screens/authenticate/authenticate.dart';
import 'package:proje_denemesi_fire_base/screens/authenticate/sign_in.dart';
import 'package:proje_denemesi_fire_base/services/database.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users? _userFromFireBaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User?> get user {
     return _auth.authStateChanges().map((User? user){return user;});
   
   
  }
   
   

  // sign in anonymous

  Future signInAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFireBaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
    Future signInWithEmailAndPassword(String email,String password) async{
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        //create new document for the user with uid 
        await DatabaseService(uid: user!.uid).updateUserData("0","new crew member",100);
        return _userFromFireBaseUser(user);
      }catch(e){
        print(e.toString());
        return null;

      }
  }

  // register with emeail & password
  Future registerWithEmailAndPassword(String email,String password) async{
      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        return _userFromFireBaseUser(user!);
      }catch(e){
        print(e.toString());
        return null;

      }
  }

 // sign out
 Future signOut() async {
   try{
      await _auth.signOut();
      return Authenticate();

   }catch(e){
     print(e.toString());
     return null;
   }
 }
}
