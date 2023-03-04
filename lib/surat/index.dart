import 'dart:convert';
//import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/surat/jenis/edit_jenis.dart';

import 'edit.dart';
import 'jenis/tambah_jenis.dart';
import 'keluar/edit_keluar.dart';
import 'masuk/edit_masuk.dart';
import 'tambah.dart';
import '../myenv.dart';
import 'keluar/tambah_keluar.dart';
import 'masuk/tambah_masuk.dart';

class IndexSurat extends StatefulWidget{
  @override
  _IndexSurat createState() => _IndexSurat();
}

class _IndexSurat extends State<IndexSurat>{
  List listData = [];
  MyEnvironments env = new MyEnvironments();

  late BuildContext simpan;

  Widget myList = Center(
    child: Center(child: new CircularProgressIndicator()),
  );
  Widget awal = Text('');
  Widget buttonBaru = IconButton(onPressed: (){}, icon: Icon(Icons.add_circle));
  int curi = 1;
  double konten = 0.72;

  late BuildContext ex;
  Widget formSearch = Container();
  double contentHeight = 0;
  String pencarian = '';


  @override
  Widget build(BuildContext context) {
    contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    return MaterialApp(
      theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
        home: (
            Scaffold(
              //resizeToAvoidBottomInset : false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: (contentHeight *0.13),
                      padding: EdgeInsetsDirectional.only(top: 30),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(width: 40,),
                          Icon(Icons.list,size: 30,),
                          Expanded(
                            child: Container(
                              child: Text('Surat',
                                style: TextStyle(fontSize: 17,

                                ),
                              ),
                              padding: EdgeInsetsDirectional.only(start: 8),),
                          ),
                          buttonBaru,
                          SizedBox(width: 10,)
                        ],
                      ),
                      color: CupertinoColors.white,),
                    formSearch,
                    Container(
                      //color : Colors.black,
                      height: (contentHeight * konten),
                      //padding: EdgeInsetsDirectional.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: (contentHeight * (konten - 0.02)),
                                  child: awal
                              ),
                            ],
                          ),
                        ],),
                    ),

                    //NavigationDestination(icon: icon, label: label,),
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      iconSize: 25,
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.keyboard_double_arrow_left),label: 'Kembali'),
                        BottomNavigationBarItem(icon: Icon(Icons.outgoing_mail),label: 'Keluar'),
                        BottomNavigationBarItem(icon: Icon(Icons.mark_email_read),label: 'Masuk',),
                        BottomNavigationBarItem(icon: Icon(Icons.mark_email_read),label: 'Jenis',),
                      ],
                      backgroundColor: CupertinoColors.white,
                      elevation: 0,
                      currentIndex: curi,
                      onTap: (value) {
                        switch(value){
                          case 0 : Navigator.of(context).pop(); break;
                          case 1 : getListKeluar(); break;
                          case 2 : getListMasuk(); break;
                          case 3 : getJenisSurat();
                        }

                      },
                    ),
                  ],
                ),
              ),
            ))
    );
  }

  getListMasuk() async {
    print('ini list masuk');
    curi = 2;
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.get(
      Uri.https(env.apiUrl, 'api/surat-masuk/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer '},

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        konten = 0.72;
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                    formSearch = Container();
                    konten = 0.82;
                    awal = FormEditMasuk(listData[index]);
                  });
                },
                child: Row(
                  children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                      width: 50,
                      padding: EdgeInsets.all(20),
                      //color: Colors.lightBlue,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex:10,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(listData[index]['nomor_surat'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),),
                            ),

                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        awal = myList;
        buttonBaru = IconButton(onPressed: (){
          setState((){
            formSearch = Container();
            konten = 0.82;
            awal = FormTambahMasuk();
          });

        }, icon: Icon(Icons.add_circle));
        formSearch = Container(

          padding:EdgeInsets.all(10),
          height: (contentHeight * 0.1),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(onPressed: (){
                  getListMasukByNomor();
                },icon: Icon(Icons.search_outlined),)

            ),
            onChanged: (v){
              pencarian = v;
            },
          ),


        );
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();
    });

  }

  getListMasukByNomor() async {
    print('get list masuk' + pencarian);
    curi = 1;
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.post(
        Uri.https(env.apiUrl, 'api/surat-masuk/list/by-nomor'),
        headers: { 'Authorization': 'Bearer '},
        body: {
          'nomor': pencarian,
        }

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                    awal = FormEditKeluar(listData[index]);
                  });
                },
                child: Row(

                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                        width: 50,
                        padding: EdgeInsets.all(20),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                      ),
                    ),
                    Expanded(
                      flex:10,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(listData[index]['nomor_surat'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),),
                              ),

                            ],
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        konten = 0.72;
        awal = myList;
        buttonBaru = IconButton(onPressed: (){
          setState((){
            awal = FormTambahKeluar();
            formSearch = Container();
            konten = 0.82;
          });

        }, icon: Icon(Icons.add_circle));
        formSearch = Container(
          padding:EdgeInsets.all(10),
          height: (contentHeight * 0.1),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(onPressed: (){
                  getListMasukByNomor();
                  print('Search Surat Masuk ' + pencarian);
                },icon: Icon(Icons.search_outlined),)

            ),
            onChanged: (v){
              pencarian = v;
            },
          ),


        );
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();

    });

  }

  getListKeluar() async {
    curi = 1;
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.get(
      Uri.https(env.apiUrl, 'api/surat-keluar/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer '},

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                   formSearch = Container();
                   konten = 0.82;
                    awal = FormEditKeluar(listData[index]);
                  });
                },
                child: Row(

                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                        width: 50,
                        padding: EdgeInsets.all(20),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                      ),
                    ),
                    Expanded(
                      flex:10,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(listData[index]['nomor_surat'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),),
                              ),

                            ],
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        konten = 0.72;
        awal = myList;
        buttonBaru = IconButton(onPressed: (){
         setState((){
           awal = FormTambahKeluar();
           formSearch = Container();
           konten = 0.82;

         });

        }, icon: Icon(Icons.add_circle));
        formSearch = Container(

          padding:EdgeInsets.all(10),
          height: (contentHeight * 0.1),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(onPressed: (){
                  getListKeluarByNomor();
                },icon: Icon(Icons.search_outlined),)

            ),
            onChanged: (v){
               pencarian = v;
            },
          ),


        );
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();

    });

  }

  getListKeluarByNomor() async {
    curi = 1;
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.post(
      Uri.https(env.apiUrl, 'api/surat-keluar/list/by-nomor'),
      headers: { 'Authorization': 'Bearer '},
      body: {
        'nomor': pencarian,
      }

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                    awal = FormEditKeluar(listData[index]);
                  });
                },
                child: Row(

                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                        width: 50,
                        padding: EdgeInsets.all(20),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                      ),
                    ),
                    Expanded(
                      flex:10,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(listData[index]['nomor_surat'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),),
                              ),

                            ],
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        konten = 0.72;
        awal = myList;
        buttonBaru = IconButton(onPressed: (){
          setState((){
            awal = FormTambahKeluar();
            formSearch = Container();
            konten = 0.82;

          });

        }, icon: Icon(Icons.add_circle));
        formSearch = Container(

          padding:EdgeInsets.all(10),
          height: (contentHeight * 0.1),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(onPressed: (){
                  getListKeluarByNomor();
                },icon: Icon(Icons.search_outlined),)

            ),
            onChanged: (v){
               pencarian = v;
            },
          ),


        );
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();

    });

  }

  getJenisSurat() async {
    curi = 3;
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.get(
      Uri.https(env.apiUrl, 'api/jenis-surat/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer '},

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 100,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  setState(() {
                    formSearch = Container();
                    konten = 0.82;
                    awal = FormEditJenis(listData[index]);
                  });
                },
                child: Row(

                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                        width: 50,
                        padding: EdgeInsets.all(20),
                        //color: Colors.lightBlue,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                      ),
                    ),
                    Expanded(
                      flex:10,
                      child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(listData[index]['jenis'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),),
                              ),
                              SizedBox(height: 3,),
                              Container(
                                child: Text(listData[index]['kode'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(border: Border(),
                            //color: Colors.black12
                          )
                      ),
                    ),
                  ],),
              )
          );
        },
          separatorBuilder: (context, index) => Container(height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
          ),
          itemCount:listData.length,
        );
        konten = 0.72;
        awal = myList;
        buttonBaru = IconButton(onPressed: (){
          setState((){
            awal = FormTambahJenis();
            formSearch = Container();
            konten = 0.82;

          });

        }, icon: Icon(Icons.add_circle));
        formSearch = Container(

          padding:EdgeInsets.all(10),
          height: (contentHeight * 0.1),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(onPressed: (){
                  getListKeluarByNomor();
                },icon: Icon(Icons.search_outlined),)

            ),
            onChanged: (v){
              pencarian = v;
            },
          ),


        );
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();

    });

  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        getListKeluar();
      });
    });
  }

}

