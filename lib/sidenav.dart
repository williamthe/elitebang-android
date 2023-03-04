

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_litbang/Inovasi/inovasi.dart';
import 'package:prototype_litbang/agenda/index.dart';
import 'package:prototype_litbang/berita/index.dart';
import 'package:prototype_litbang/kelitbangan/kelitbangan.dart';
import 'package:prototype_litbang/menu.dart';
import 'package:prototype_litbang/penelitian/penelitian.dart';
import 'package:prototype_litbang/user_menu.dart';

class Sidenav extends StatelessWidget{
@override
Widget build(BuildContext context) {
  return ListView(
    children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list, size: 35,color: Colors.white,),
            Text('Side Navigasi',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        ),
        height: 70,
        color: Colors.blueAccent,
      ),
      ListTile(

        leading: Icon(Icons.laptop),
        title: Text('Kelitbangan'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Kelitbangan();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.lightbulb_circle_outlined),
        title: Text('Inovasi'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Inovasi();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.schedule_send),
        title: Text('Agenda'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return IndexAgenda();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('Berita'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return IndexBerita();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.saved_search_sharp),
        title: Text('Penelitian'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Penelitian();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Main Menu'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Menu();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.grid_view),
        title: Text('User Menu'),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return UserMenu();
          }));
        },
      ),
    ],
  );

}
}