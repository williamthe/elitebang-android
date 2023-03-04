
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:prototype_litbang/mysettings.dart';
import '../agenda/index.dart';
import '../berita/index.dart';
import '../inovasi/index.dart';
import '../kelitbangan/index.dart';
import '../penelitian/index.dart';
import '../regulasi/index.dart';
import '../user/index.dart';
import '../user_menu.dart';
import '../usulan-inovasi/index.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'instansi/index.dart';
import 'myenv.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'surat/index.dart';


class Menu extends StatefulWidget{
  Menu(){

  }
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu>{
  _Menu(){
    SessionManager().get('auth') == null ? Navigator.of(context).pop() : null ;

  }
  MyEnvironments env = new MyEnvironments();
  var myPusher;


  TextStyle menuText = TextStyle(
      fontSize: 16,
      color: Colors.black87,
  );
  Color menuColor = Colors.white;
  late BuildContext log;
  bool akses = false;
  List menuTitle = [
    'Kelitbangan',
    'Inovasi',
    'Agenda',
    'Berita',
    'Penelitian',
    'Usul Inovasi',
    'Regulasi / Produk Hukum',
    'User Management'
  ];

  List myMenu = [
    {
      'title' : 'Kelitbangan',
      'navigasi' : Index(),
      'akses' : 'kelitbangan',
    },
    {
      'title' : 'Inovasi',
      'navigasi' : IndexInovasi(),
      'akses' : 'inovasi',
    },
    {
      'title' : 'Agenda',
      'navigasi' : IndexAgenda(),
      'akses' : 'agenda',
    },
    {
      'title' : 'Berita',
      'navigasi' : IndexBerita(),
      'akses' : 'berita',
    },
    {
      'title' : 'Penelitian',
      'navigasi' : IndexPenelitian(),
      'akses' : 'penelitian',
    },
    {
      'title' : 'Usulan Inovasi',
      'navigasi' : IndexUsulanInovasi(),
      'akses' : 'usulan inovasi',
    },
    {
      'title' : 'Regulasi / Produk Hukum',
      'navigasi' : IndexRegulasi(),
      'akses' : 'regulasi',
    },
    {
      'title' : 'Instansi',
      'navigasi' : IndexInstansi(),
      'akses' : 'regulasi',
    },
    {
      'title' : 'User Management',
      'navigasi' : IndexUser(),
      'akses' : 'user akses',
    },
    {
      'title' : 'Pref Setting',
      'navigasi' : MySettings(),
      'akses' : 'user akses',
    },
    {
      'title' : 'Surat',
      'navigasi' : IndexSurat(),
      'akses' : 'regulasi',
    },
  ];
  Widget notif = IconButton(onPressed: (){

  }, icon: Icon(
    Icons.notifications,
    //size: myBodyHeight * 0.2 * 0.15,
    color: Colors.white,
  )
  );
  double menuIconSize = 33;
  Color menuIconColor = Colors.black;
  String myUser = 'Tanpa Nama';


  @override
  Widget build(BuildContext context) {

    List<Widget> listMenu = List.generate(myMenu.length, (index) => Column(
      children:[
        Container(
          decoration: BoxDecoration(
            color: menuColor,
            borderRadius: BorderRadiusDirectional.circular(15),
            border: Border.all( color: CupertinoColors.white),
          ),
          padding: EdgeInsetsDirectional.all(15),
          //color: Colors.blue,
          height: 93,
          child: TextButton(
            onPressed:
                (){
              cekAkses(myMenu[index]);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(myMenu[index]['title'],
                          style: menuText, ),
                        padding: EdgeInsetsDirectional.all(10),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.list,
                      color: menuIconColor,
                      size: menuIconSize,),),
                )
              ],
            ),
          ),),
        Container(height: 10,),],
    ) );
    Widget menuContainer = Container(
      padding: EdgeInsetsDirectional.all(15),
      child: ListView(
        children: [
          Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadiusDirectional.circular(15)
                  ),
                  padding: EdgeInsetsDirectional.only(top: 5,bottom: 5),
                  //color: Colors.blue,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(icon:Icon(Icons.grid_view_sharp), onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                            return UserMenu();
                          },));
                        },),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(padding: EdgeInsetsDirectional.only(start: 10),
                            child: Text('Hello, ${myUser}', style: TextStyle(),)),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(icon:Icon(Icons.admin_panel_settings_rounded), onPressed: (){
                          showDialog(context: context, builder: (BuildContext ex) {
                            log = ex;
                            return AlertDialog(title: Row(

                              children: [
                                Expanded(
                                  flex:9,
                                  child: Text('Hallo ${myUser}..!',
                                    style: TextStyle(
                                        fontFamily: 'Poppins'
                                    ),),
                                ),
                                Expanded(
                                  flex :1,
                                  child: Column(
                                    children: [
                                      IconButton(onPressed: (){
                                        logout();
                                      }, icon: Icon(Icons.logout), tooltip:'Logout',),
                                      IconButton(onPressed: (){
                                        //logout();
                                      }, icon: Icon(Icons.notifications), tooltip:'Logout',),
                                    ],
                                  ),)
                              ],
                            ),);
                          },);
                        },),
                      ),
                    ],
                  ),

                ),
                Container(height: 10,),
                Container(
                    child: Column(children: listMenu,)
                )
              ]),

        ],
      ),
    );

    final myBodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    TextStyle menuStyle = TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold
    );
    double paddingMenu = 20;
    double menuheight = 85;
    double menuIcon = 40;
    double menuRadius = 20;

    Widget menuv2 = Container(
      height:  myBodyHeight,
      child: Column(
        children: [
          Container(
            height: myBodyHeight * 0.2,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      notif,
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                          return UserMenu();
                        },));
                      }, icon: Icon(
                        Icons.home,
                        size: myBodyHeight * 0.2 * 0.23,
                        color: Colors.white,
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.supervised_user_circle_outlined,
                            size: myBodyHeight * 0.2 * 0.35,
                            color:CupertinoColors.white,
                          ),
                          Text('Hello, ${myUser}', style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16
                          ),)
                        ],
                      ),
                      IconButton(onPressed: (){
                        //getNotif();
                        logout();
                      }, icon: Icon(
                        Icons.logout,
                        size: myBodyHeight * 0.2 * 0.23,
                        color: Colors.white,
                      )
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ),
          Container(
            height: myBodyHeight * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(15)
            ),
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.all(3),
              child: Column(
                children: [
                  TextButton(onPressed: (){
                    cekAkses(myMenu[0]);
                  },
                      child: Container(
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        height: menuheight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(40, 70, 200, 0.87),
                            //color: Colors.greenAccent,
                            //borderRadius: BorderRadiusDirectional.circular(menuRadius)
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children :[
                            Icon(
                              Icons.screen_search_desktop_outlined,
                              color: CupertinoColors.white,
                              size: menuIcon,
                            ),
                            SizedBox(width: 35,),
                            Text('Kelitbangan', style: menuStyle,)
                          ]
                      ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[1]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_circle,
                              color: CupertinoColors.white,
                              size: menuIcon,
                            ),
                            SizedBox(width: 35,),
                            Text('Inovasi', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[2]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.cyan[400],
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: CupertinoColors.white,
                              size: menuIcon,
                            ),
                            SizedBox(width: 35,),
                            Text('Agenda', style: menuStyle),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[3]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(40, 70, 200, 0.87),
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.new_releases,
                              color: CupertinoColors.white,
                              size: menuIcon,
                            ),
                            SizedBox(width: 35,),
                            Text('Berita', style: menuStyle),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[4]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.content_paste_search,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Usulan Penelitian', style: menuStyle),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[5]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.cyan[400],
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_pin,
                              color: CupertinoColors.white,
                              size: menuIcon,
                            ),
                            SizedBox(width: 35,),
                            Text('Usulan Inovasi', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[10]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: CupertinoColors.white,
                              size: menuIcon,
                            ),
                            SizedBox(width: 35,),
                            Text('Arsip Surat', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[6]);
                  },
                      child: Container(
                        height: menuheight,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(40, 70, 200, 0.87),
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.gavel_outlined,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Regulasi / Produk Hukum', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[7]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            //color: Color.fromRGBO(40, 70, 200, 0.87),
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_work,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Instansi', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[8]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Colors.cyan[400],
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('User Management', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[9]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(40, 70, 200, 0.87),
                            borderRadius: BorderRadiusDirectional.only(
                              //bottomStart: Radius.circular(menuRadius),
                              topStart: Radius.circular(menuRadius),
                              //topEnd: Radius.circular(menuRadius),
                              bottomEnd: Radius.circular(menuRadius),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Prefset', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Color singleColor = Color.fromRGBO(20, 68, 190, 0.97);
    Color iconColor = CupertinoColors.white;
    //Color textColor = Colors.black54;

    Widget menuv3 = Container(
      height:  myBodyHeight,
      child: Column(
        children: [
          Container(
            height: myBodyHeight * 0.2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return UserMenu();
                    },));
                  }, icon: Icon(
                    Icons.home,
                    size: myBodyHeight * 0.2 * 0.23,
                    color: Colors.white,
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.supervised_user_circle_outlined,
                        size: myBodyHeight * 0.2 * 0.35,
                        color:CupertinoColors.white,
                      ),
                      Text('Hello, ${myUser}', style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16
                      ),)
                    ],
                  ),
                  IconButton(onPressed: (){
                    logout();
                  }, icon: Icon(
                    Icons.logout,
                    size: myBodyHeight * 0.2 * 0.23,
                    color: Colors.white,
                  )
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: myBodyHeight * 0.8,
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadiusDirectional.circular(15)
            ),
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.all(3),
              child: Column(
                children: [
                  TextButton(onPressed: (){
                    cekAkses(myMenu[0]);
                  },
                      child: Container(
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        height: menuheight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                            children :[
                              Icon(
                                Icons.screen_search_desktop_outlined,
                                color: iconColor,
                                size: 35,
                              ),
                              SizedBox(width: 35,),
                              Text('Kelitbangan', style: menuStyle,)
                            ]
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[1]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_circle,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Inovasi', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[2]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Agenda', style: menuStyle),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[3]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.new_releases,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Berita', style: menuStyle),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[4]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.content_paste_search,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Penelitian', style: menuStyle),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[5]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_pin,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Usulan Inovasi', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[10]);
                  },
                      child: Container(
                        height: menuheight,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Surat', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[6]);
                  },
                      child: Container(
                        height: menuheight,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.gavel_outlined,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Regulasi / Produk Hukum', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[7]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_work,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Instansi', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[8]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('User Management', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                  TextButton(onPressed: (){
                    cekAkses(myMenu[9]);
                  },
                      child: Container(
                        height: menuheight,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(paddingMenu),
                        decoration: BoxDecoration(
                            color: singleColor,
                            borderRadius: BorderRadiusDirectional.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: CupertinoColors.white,
                              size: 35,
                            ),
                            SizedBox(width: 35,),
                            Text('Prefset', style: menuStyle,),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: MyEnvironments().myFont),
      home:Scaffold(
        // backgroundColor: Color.fromRGBO(30, 30, 200, 0.7),
        backgroundColor:Color.fromRGBO(20, 60, 200, 0.8),
        body:menuv2,
      )
    );
  }

  setUser() async {
    myUser = await SessionManager().get('user');
  }

  void logout() {

    SessionManager().destroy();
    //Navigator.pop(log);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return UserMenu();
    },));
  }

  cekAkses (menuNav) async {

    showDialog(context: context, builder: (BuildContext ex) {
      log = ex;
      return AlertDialog(title: Row(
        children: [
          Expanded(
            flex:9,
            child: Column(
              children: [
                Text('Mengecek Akses...',),
                new CircularProgressIndicator()
              ],
            ),
          ),
        ],
      ),);
    },);

    String _token = await SessionManager().get('_token');
    var user_id = await SessionManager().get('user_id');
    bool isConnected = await InternetConnectionChecker().hasConnection;

    await http.post(
        Uri.https(env.apiUrl, 'api/pengguna/android-check'),
        headers: {

          'Authorization': 'Bearer ${_token}'
        },
        body: {
          'user_id' : user_id.toString(),
          'menu' : menuNav['akses'],
        }

    ).then((value) async {
      Navigator.of(log).pop();
      // setState(){
      var cek = jsonDecode(value.body);
      if(cek['status'] == true){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return menuNav['navigasi'];
        },));
      }
      else{
        showDialog(context: context, builder: (BuildContext ex) {
          log = ex;
          return AlertDialog(title: Row(
            children: [
              Expanded(
                flex:9,
                child: Text(cek['message'],
                  style: TextStyle(

                  ),),
              ),
            ],
          ),);
        },);
      }

    });


  }

  getNotif(){

    setState((){
      print('get Pusher');
      notif = IconButton(onPressed: (){
        cekNotif();
      }, icon: Icon(
        Icons.notifications,
        //size: myBodyHeight * 0.2 * 0.15,
        color: Colors.amber,
      )
      );
    });

  }

  cekNotif(){
    setState((){
      notif = IconButton(onPressed: (){
        cekNotif();
      }, icon: Icon(
        Icons.notifications,
        //size: myBodyHeight * 0.2 * 0.15,
        color: Colors.white,
      )
      );
    });
  }

  setPusher() async {
    myPusher = PusherChannelsFlutter();
    myPusher.init(apiKey: "40ab74c9addd0e520f33", cluster: "ap1");
    myPusher.connect();
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        setUser();
        //setPusher();
      });
    });
  }

}




