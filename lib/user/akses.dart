import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';

class AksesUser extends StatefulWidget{
  Map akses = {};
  AksesUser(Map acc){
    akses = acc;
  }
  @override
  _AksesUser createState() => _AksesUser(akses);
}

class _AksesUser extends State<AksesUser>{
  Map aksesSaya = {};
  List aktifAccess = [];
  _AksesUser(Map acc){
    aksesSaya = acc;
    aktifAccess = acc['akses'];
  }
 
  late BuildContext simpan;

  MyEnvironments env = new MyEnvironments();

  Map dataAkses = {
    'kelitbangan' : {
      'status' : false,
      'nilai' : 'kelitbangan'
    },
    'inovasi' : {
      'status' : false,
      'nilai' : 'inovasi'
    },
    'agenda' : {
      'status' : false,
      'nilai' : 'agenda'
    },
    'berita' : {
      'status' : false,
      'nilai' : 'berita'
    },
    'penelitian' : {
      'status' : false,
      'nilai' : 'penelitian'
    },
    'usulan inovasi' : {
      'status' : false,
      'nilai' : 'usulan inovasi'
    },
    'regulasi' : {
      'status' : false,
      'nilai' : 'regulasi'
    },
    'user akses' : {
      'status' : false,
      'nilai' : 'user akses'
    },
  };

  Map aksesSrc = {};

  Widget myList = Center(
    child: Center(child: new CircularProgressIndicator()),
  );


  late BuildContext ex;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home: (
            Scaffold(
              resizeToAvoidBottomInset : false,
              body: Column(
                children: [
                  Container(height: (100),
                    padding: EdgeInsetsDirectional.only(top: 30),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          flex:2,
                            child: Container(
                              padding: EdgeInsetsDirectional.only(start: 10),

                                child: Icon(Icons.list,size: 30,))),
                        Expanded(
                          flex: 8,
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('Atur Akses User ${aksesSaya['nama'].toString()}',
                              style: TextStyle(fontSize: 17,

                              ),
                            ),
                            padding: EdgeInsetsDirectional.only(start: 8),),
                        ),
                        Expanded(
                          flex: 2,
                            child: Container(
                              padding: EdgeInsetsDirectional.only(end: 20),
                              child: IconButton(
                          icon: Icon(Icons.keyboard_double_arrow_left),
                          onPressed: (){
                              Navigator.of(context).pop();
                          },
                        ),
                            ))
                      ],
                    ),
                    color: CupertinoColors.white,),
                  Container(
                    height: contentHeight - 130,
                    child: ListView(
                      children: [
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Kelitbangan',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['kelitbangan']['status'] = xr;
                                            });
                                            setAkses(dataAkses['kelitbangan']['nilai'],xr);
                                          },value: dataAkses['kelitbangan']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [
                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Inovasi',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['inovasi']['status'] = xr;
                                            });
                                            setAkses(dataAkses['inovasi']['nilai'],xr);
                                          },value: dataAkses['inovasi']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Agenda',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['agenda']['status'] = xr;
                                            });
                                            setAkses(dataAkses['agenda']['nilai'],xr);
                                          },value: dataAkses['agenda']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Berita',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['berita']['status'] = xr;
                                            });
                                            setAkses(dataAkses['berita']['nilai'],xr);
                                          },value: dataAkses['berita']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Penelitian',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['penelitian']['status'] = xr;
                                            });
                                            setAkses(dataAkses['penelitian']['nilai'],xr);
                                          },value: dataAkses['penelitian']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Usulan Inovasi',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['usulan inovasi']['status'] = xr;
                                            });
                                            setAkses(dataAkses['usulan inovasi']['nilai'],xr);
                                          },value: dataAkses['usulan inovasi']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('Regulasi',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['regulasi']['status'] = xr;
                                            });
                                            setAkses(dataAkses['regulasi']['nilai'],xr);
                                          },value: dataAkses['regulasi']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 5,),
                        Container(
                            padding: EdgeInsetsDirectional.all(10),
                            height: 85,
                            decoration: BoxDecoration(
                              // border: BorderDirectional(),
                                borderRadius: BorderRadius.circular(20),
                                color: CupertinoColors.white
                            ),
                            child:
                            TextButton(
                              onPressed: (){
                                setState(() {

                                });
                              },
                              child: Row(children: [

                                Expanded(
                                  flex:11,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('User Management',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      decoration: BoxDecoration(border: Border(),
                                        //color: Colors.black12
                                      )
                                  ),
                                ),
                                Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlutterSwitch(onToggle: (bool xr){
                                            setState(() {
                                              dataAkses['user akses']['status'] = xr;
                                            });
                                            setAkses(dataAkses['user akses']['nilai'],xr);
                                          },value: dataAkses['user akses']['status'],)
                                        ],
                                      ),
                                    )
                                )
                              ],),
                            )
                        ),
                        Container(height: 10,),
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
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,),),
                                        onPressed: (){
                                          saveAccess();
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
                      ],
                    ),
                  ),

                ],
              ),
            ))
    );
  }

  setAktif(){
    dataAkses.forEach((key, value) {
      setState(() {
        if(aktifAccess.contains(key)){
          value['status'] = true;
          aksesSrc[key] = key;
        }
        else{
          value['status'] = false;
        }
      });
    });
  }

  setAkses(value,status){
    if(status == true){
      aksesSrc[value] = value;
    }
    else{
      aksesSrc.remove(value);
    }
  }

  Future<void> saveAccess() async {
    List req = [];
    aksesSrc.forEach((key, value) {req.add(value);});
    print(req);
    showDialog(context: context, builder: (BuildContext upd){
      simpan = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Menyimpan Data...', style: TextStyle(fontFamily: 'Poppins') ),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });


    var _mytoken = await SessionManager().get('_token');

    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/pengguna/update-akses-android'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'user_id' :aksesSaya['id'].toString(),
        'akses': jsonEncode(req),
      },
    ).then((value){
      var dec = jsonDecode(value.body);

      Navigator.of(simpan).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Berhasil!'),
            content: Text('Data Berhasil Tersimpan!'),
          );
        });
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Gagal!'),
            content: Text(dec['message']),
          );
        });
      }

    } );

  }


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        setAktif();
      });
    });
  }

}

