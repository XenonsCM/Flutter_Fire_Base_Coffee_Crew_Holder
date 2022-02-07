import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proje_denemesi_fire_base/models/brew.dart';
import 'package:proje_denemesi_fire_base/screens/home/setting_form.dart';
import 'package:proje_denemesi_fire_base/services/auth.dart';
import 'package:proje_denemesi_fire_base/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.brown[400], elevation: 0.0),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.brown[400], elevation: 0.0),
                onPressed: () => _showSettingsPanel(),
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                label: Text("settings"))
          ],
        ),
        body: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/coffee_bg.png"),fit: BoxFit.cover)),child: BrewList()),
      ),
    );
  }
}
