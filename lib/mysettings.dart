
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../user_menu.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'myenv.dart';


class MySettings extends StatefulWidget{

  _MySettings createState() => _MySettings();
}

class _MySettings extends State<MySettings>{

  _Menu(){
    SessionManager().get('auth') == null ? Navigator.of(context).pop() : null ;
  }
  MyEnvironments env = new MyEnvironments();


  TextStyle menuText = TextStyle(
      //fontFamily: env.myFont,
      //fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black87
  );
  Color menuColor = Colors.white;
  late BuildContext log;
  bool akses = false;

  double menuIconSize = 33;
  Color menuIconColor = Colors.black;
  String myUser = 'Tanpa Nama';
  List fonts = ['Poppins','Roboto','Open-Sans','PT-Serif'];
  String profile = '';
  String font = 'Roboto';
  String visi = '';
  String misi = '';
  String nama = '';


  @override
  Widget build(BuildContext context) {

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
                        child: IconButton(icon:Icon(Icons.arrow_circle_left), onPressed: (){
                          Navigator.of(context).pop();
                        },),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(padding: EdgeInsetsDirectional.only(start: 10),
                            child: Text('Settings', style: TextStyle( fontSize: 16),)),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: IconButton(icon:Icon(Icons.admin_panel_settings_rounded), onPressed: (){
                      //     showDialog(context: context, builder: (BuildContext ex) {
                      //       log = ex;
                      //       return AlertDialog(title: Row(
                      //
                      //         children: [
                      //           Expanded(
                      //             flex:9,
                      //             child: Text('Hallo ${myUser}..!',
                      //               style: TextStyle(
                      //                   fontFamily: 'Poppins'
                      //               ),),
                      //           ),
                      //           Expanded(
                      //             flex :1,
                      //             child: IconButton(onPressed: (){
                      //             }, icon: Icon(Icons.logout), tooltip:'Logout',),)
                      //         ],
                      //       ),);
                      //     },);
                      //   },),
                      // ),
                    ],
                  ),

                ),
                Container(height: 5,),
                Container(
                    padding: EdgeInsetsDirectional.all(5),
                    height: 160,
                    decoration: BoxDecoration(
                      // border: BorderDirectional(),
                        borderRadius: BorderRadius.circular(15),
                        color: CupertinoColors.white
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:3,

                          child: Container(
                            child: Text('Pilih Font',
                              style: TextStyle(fontSize: 15, color: Colors.black,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.all(13),
                            //color: Colors.lightBlue,
                            decoration: BoxDecoration(
                              //   color: Colors.black12,
                                borderRadius: BorderRadiusDirectional.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                              padding: EdgeInsetsDirectional.all(15),
                              child:
                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                value: font,
                                isExpanded: true,
                                hint: const Text(
                                  'Pilih Font',
                                  style: TextStyle(fontSize: 15),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: fonts
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Silahkan Pilih';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    env.myFont = value.toString();
                                    font = value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    env.myFont = value.toString();
                                    font = value.toString();
                                  });

                                },
                              ),

                              decoration: BoxDecoration(border: Border(),
                                //color: Colors.black12
                              )
                          ),
                        ),
                      ],)
                ),
                Container(height: 5,),
                Container(
                    padding: EdgeInsetsDirectional.all(5),
                    height: 200,
                    decoration: BoxDecoration(
                      // border: BorderDirectional(),
                        borderRadius: BorderRadius.circular(15),
                        color: CupertinoColors.white
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            child: Text('Profile',
                              style: TextStyle(fontSize: 15, color: Colors.black,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.all(13),
                            //color: Colors.lightBlue,
                            decoration: BoxDecoration(
                              //   color: Colors.black12,
                                borderRadius: BorderRadiusDirectional.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                              padding: EdgeInsetsDirectional.all(15),
                              child: TextFormField(
                                maxLines: 10,
                                minLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  
                                ),
                                onChanged: (e){
                                  profile = e;
                                },
                                controller: TextEditingController(text: profile),
                                style: TextStyle(fontSize: 13),
                              ),

                              decoration: BoxDecoration(border: Border(),
                                //color: Colors.black12
                              )
                          ),
                        ),
                      ],)
                ),
                Container(height: 5,),
                Container(
                    padding: EdgeInsetsDirectional.all(5),
                    height: 160,
                    decoration: BoxDecoration(
                      // border: BorderDirectional(),
                        borderRadius: BorderRadius.circular(20),
                        color: CupertinoColors.white
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:3,

                          child: Container(
                            child: Text('Visi',
                              style: TextStyle(fontSize: 15, color: Colors.black,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.all(13),
                            //color: Colors.lightBlue,
                            decoration: BoxDecoration(
                              //   color: Colors.black12,
                                borderRadius: BorderRadiusDirectional.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                              padding: EdgeInsetsDirectional.all(15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  )
                                ),
                                minLines: 2,
                                maxLines: 3,
                                onChanged: (e){
                                  visi = e;
                                },
                                controller: TextEditingController(text: visi),
                                style: TextStyle(fontSize: 13),
                              ),

                              decoration: BoxDecoration(border: Border(),
                                //color: Colors.black12
                              )
                          ),
                        ),
                      ],)
                ),
                Container(height: 5,),
                Container(
                    padding: EdgeInsetsDirectional.all(5),
                    height: 190,
                    decoration: BoxDecoration(
                      // border: BorderDirectional(),
                        borderRadius: BorderRadius.circular(15),
                        color: CupertinoColors.white
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:2,

                          child: Container(
                            child: Text('Misi',
                              style: TextStyle(fontSize: 15, color: Colors.black,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.all(13),
                            //color: Colors.lightBlue,
                            decoration: BoxDecoration(
                              //   color: Colors.black12,
                                borderRadius: BorderRadiusDirectional.circular(15)
                            ),

                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                              padding: EdgeInsetsDirectional.all(15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                ),
                                minLines: 5,
                                maxLines: 10,
                                onChanged: (e){
                                  misi = e;
                                },
                                controller: TextEditingController(text: misi),
                                style: TextStyle(fontSize: 13),
                              ),

                              decoration: BoxDecoration(border: Border(),
                                //color: Colors.black12
                              )
                          ),
                        ),
                      ],)
                ),
                Container(height: 5,),
                Container(
                    padding: EdgeInsetsDirectional.all(5),
                    height: 160,
                    decoration: BoxDecoration(
                      // border: BorderDirectional(),
                        borderRadius: BorderRadius.circular(15),
                        color: CupertinoColors.white
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            child: Text('Title Aplikasi',
                              style: TextStyle(fontSize: 15, color: Colors.black,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.all(13),
                            //color: Colors.lightBlue,
                            decoration: BoxDecoration(
                              //   color: Colors.black12,
                                borderRadius: BorderRadiusDirectional.circular(15)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                              padding: EdgeInsetsDirectional.all(15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),

                                ),
                                minLines: 3,
                                maxLines: 10,
                                onChanged: (e){
                                  nama = e;
                                },
                                style: TextStyle(fontSize: 13),

                                controller: TextEditingController(text: nama),
                              ),

                              decoration: BoxDecoration(border: Border(),
                                //color: Colors.black12
                              )
                          ),
                        ),
                      ],)
                ),
                Container(height: 5,),
                Container(
                    padding: EdgeInsetsDirectional.all(10),
                    height: 70,
                    decoration: BoxDecoration(
                      border: BorderDirectional(),
                      borderRadius: BorderRadius.circular(20),
                      //color: CupertinoColors.white
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          //flex: 9,
                          child: Container(
                            //height: 60,
                              padding: EdgeInsetsDirectional.all(5),
                              child: TextButton(
                                child: Text('simpan',
                                  style: TextStyle(fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white,),),
                                onPressed: (){
                                   simpan();
                                },
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                  ),
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                  color: Colors.greenAccent
                              )
                          ),
                        ),
                      ],)
                ),
              ]),
        ],
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home:Scaffold(
         // backgroundColor: Color.fromRGBO(12, 12, 220, 100),
          //endDrawer: Icon(Icons.arrow_left, color: Colors.black, size: 50,),
          body:menuContainer,
        )
    );
  }

  setUser() async {
    myUser = await SessionManager().get('user');
  }


  Future<void> simpan () async {
    String _token = await SessionManager().get('_token');
    await http.post(
        Uri.https(env.apiUrl, 'api/pref/update'),
        headers: {
          'Authorization': 'Bearer ${_token}'
        },
        body: {
          'title' : nama,
          'visi' : visi,
          'misi' : misi,
          'profile': profile,
          'font': font,
          'id' : '1',

        }

    ).then((value) async {
      // setState(){
      var cek = jsonDecode(value.body);
      if(cek['status'] == true){
        showDialog(context: context, builder: (BuildContext ex) {
          log = ex;
          return AlertDialog(title: Row(
            children: [
              Expanded(
                flex:9,
                child: Text(cek['message'],
                  style: TextStyle(
                      fontFamily: 'Poppins'
                  ),),
              ),
            ],
          ),);
        },);
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
                      fontFamily: 'Poppins'
                  ),),
              ),
            ],
          ),);
        },);
      }

    });
  }

  Future<void> getPref () async {
    String _token = await SessionManager().get('_token');
    await http.get(
        Uri.https(env.apiUrl, 'api/pref/get'),
        headers: {
          'Authorization': 'Bearer ${_token}'
        }

    ).then((value) async {
      // setState(){
      var cek = jsonDecode(value.body);
      if(cek['status'] == true){

        setState((){
          font = cek['data']['font'] == null ? 'Poppins': cek['data']['font'] ;
          visi = cek['data']['visi'] == null ? 'Visi': cek['data']['visi'] ;
          misi = cek['data']['misi'] == null ? 'Misi': cek['data']['misi'] ;
          nama = cek['data']['title'] == null ? 'Title': cek['data']['title'] ;
          profile = cek['data']['profile'] == null ? 'Profile': cek['data']['profile'] ;
        });
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
                      fontFamily: 'Poppins'
                  ),),
              ),
            ],
          ),);
        },);
      }

    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getPref();
      });
    });
  }

}




