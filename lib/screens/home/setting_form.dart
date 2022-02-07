import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proje_denemesi_fire_base/models/user.dart';
import 'package:proje_denemesi_fire_base/services/database.dart';
import 'package:proje_denemesi_fire_base/shared/constants.dart';
import 'package:proje_denemesi_fire_base/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrenth;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);


    return StreamBuilder<UserData>(
      stream: DatabaseService(uid :user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData = snapshot.data;

          return Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Uptdate your brew settings.",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: userData!.name,
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? "Please enter a name " : null,
                onChanged: (val) {
                  setState(() {
                    _currentName = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData!.sugars,
                  onChanged: (val) => setState(() {
                        _currentSugars = val as String?;
                      }),
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      child: Text("$sugar  sugars"),
                      value: sugar,
                    );
                  }).toList())
              // SelectFormField(
              // type: SelectFormFieldType.dropdown,
              // icon: Icon(Icons.content_paste_sharp),
              // items: _items,hintText:"Sugars",)
              ,
              Slider(
                activeColor: Colors.brown[_currentStrenth??userData.strength],
                inactiveColor:Colors.brown[_currentStrenth??userData.strength] ,
                value: (_currentStrenth ?? userData.strength).toDouble(),
                onChanged: (val)=>setState(() {
                  _currentStrenth=val.round() as int?;
                  
                }),
                min: 100.0,
                max: 900.0,
                divisions: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars??userData.sugars,
                      _currentName??userData.name,
                      _currentStrenth??userData.strength
                    );
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        );

        }else{
            return Loading();


        }
        
      }
    );
  }
}
