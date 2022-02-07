import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proje_denemesi_fire_base/models/brew.dart';
import 'package:proje_denemesi_fire_base/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({ Key? key }) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ??[] ;
    if(brews==null){
     return Card(child: ListTile(title: Text("There is no member"),),);
    }
    else{
    return ListView.builder(itemBuilder:(context,index){
      return BrewTile(brew: brews[index]);
    } ,itemCount: brews.length,);
    }
    
  }
}