import 'dart:convert';
//import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:filesystem_picker/filesystem_picker.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import '../baru.dart';
import '../edit_kelitbangan.dart';
import '../view_kelitbangan.dart';
import '../../myenv.dart';

class IndexByBidang extends StatefulWidget{
  int bidang = 0;
  String nama_bidang = '';
  IndexByBidang(int bidang, String nama_bidang){
    this.bidang = bidang;
    this.nama_bidang = nama_bidang;
  }
 @override
  _IndexByBidang createState() => _IndexByBidang(bidang, nama_bidang);

}

class _IndexByBidang extends State<IndexByBidang>{
  List listData = [];
  MyEnvironments env = new MyEnvironments();
  int bidang = 0;
  String nama_bidang = '0';
  int page = 0;

  _IndexByBidang(int bidang, String nama_bidang){
    this.bidang = bidang;
    this.nama_bidang = nama_bidang;
  }

  int id = 0;
  String tanggal = '';
  String judul = '';
  int instansi = 1;
  String abstrak = '';
  String tindakLanjut = '';
  String nomor = '';
  String pelaksana = '';
  int dokumen = 0;
  String pencarian = '';

  late BuildContext simpan;
  late BuildContext ex;

  Widget myList = Center( child: Text('Loading Data...'), );
  Widget awal = Text('');
  Widget formSearch = Container();
  double  contentHeight = 0;
  double bodyContent = 0.72;


  @override
  Widget build(BuildContext context) {
    contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    //BottomNavigationBar().
    return MaterialApp(
      theme: ThemeData(fontFamily: env.myFont),
     debugShowCheckedModeBanner: false,
     home: (
         Scaffold(
           resizeToAvoidBottomInset : false,
           body: Column(
       children: [
         Container(height: (contentHeight *0.13),
           decoration: BoxDecoration(
             color: Colors.blueAccent,
             borderRadius: BorderRadiusDirectional.circular(15)
           ),
           padding: EdgeInsetsDirectional.only(top: 30),
           width: double.infinity,
           child: Row(
             children: [
               Container(width: 40,),
               Icon(Icons.list,size: 30,color: CupertinoColors.white,),
               Flexible(child: Text(nama_bidang,
                 style: TextStyle(fontSize: 17,
                   color: CupertinoColors.white,
                   overflow: TextOverflow.ellipsis

                 ),
               ),
                 //padding: EdgeInsetsDirectional.only(start: 8),
                 ),
             ],
           ),
           //color: CupertinoColors.white,
           ),
         Container(
           //color : Colors.black,
           height: (contentHeight * 0.82),
           //padding: EdgeInsetsDirectional.only(top: 10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Column(
                 children: [
                   formSearch,
                   Container(
                       height: (contentHeight * (bodyContent) ),
                       child: awal
                   ),
                 ],
               ),
             ],),
         ),
         BottomNavigationBar(
           iconSize: 25,
           items: [
               BottomNavigationBarItem(icon: Icon(Icons.keyboard_double_arrow_left),label: 'Kembali'),
               BottomNavigationBarItem(icon: Icon(Icons.filter_list),label: 'Daftar'),
               BottomNavigationBarItem(icon: Icon(Icons.add_circle),label: 'Baru',),
           ],
           backgroundColor: CupertinoColors.white,
           elevation: 0,
           currentIndex: 1,
           onTap: (value) {
             switch(value){
               case 0 : Navigator.of(context).pop(); break;
               case 1 : getList(); break;
               case 2 : setState(() {
                 formSearch = Container( height: 0,);
                 bodyContent = 0.82;
                 print(formSearch);
                 awal = FormBaru(bidang);
               });;
             }
           },
         ),
       ],
     ),
     ))
    );
  }

  void showLitbang(listData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ViewKelitbangan(listData);
    }));
  }

  getList() async {
    print('List Per Bidang');
    var _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
   await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/list/by-bidang-limit'),
      headers: {
        'Authorization': 'Bearer ${_mytoken}' },
     body: {
        'bidang' : bidang.toString(),
         'page'  : page.toString(),
     }

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      // print(listData);
      setState(() {
        bodyContent = 0.72;
        formSearch = Container(
            padding:EdgeInsets.all(10),
            height: (contentHeight * 0.1),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(onPressed: (){
                    getListByName();
                  },icon: Icon(Icons.search_outlined),)

              ),
              onChanged: (v){
                pencarian = v;
              },
            )
        );
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
                    bodyContent = 0.82;
                    formSearch = Container( );
                    awal = FormEdit(listData[index]);
                  });
                },
                child: Row(children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                      width: 50,
                      padding: EdgeInsets.all(15),
                      //color: Colors.lightBlue,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(listData[index]['judul'],
                                style: TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.ellipsis),),
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['lingkup_data'] == null ? 'Instansi Tidak Ditemukan' : listData[index]['lingkup_data']['nama'],
                                style: TextStyle(color: Colors.black38, fontSize: 10,overflow: TextOverflow.ellipsis),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                  Expanded(child: Container(child: Text(listData[index]['tanggal'].toString().split("-")[0]),))
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
      });
    }).whenComplete(( ) {
      setState(() {});
       Navigator.of(ex).pop();
    });

  }

  getListByName() async {
    var _mytoken = await SessionManager().get('_token');
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    await http.post(
        Uri.https(env.apiUrl, 'api/kelitbangan/list/by-bidang-limit-judul'),
        headers: {
          'Authorization': 'Bearer ${_mytoken}' },
        body: {
          'bidang' : bidang.toString(),
          'page'  : page.toString(),
          'judul' : pencarian,

        }

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      print(listData);
      setState(() {
        bodyContent = 0.72;
        formSearch = Container(
            padding:EdgeInsets.all(10),
            height: (contentHeight * 0.1),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(onPressed: (){
                    getListByName();
                  },icon: Icon(Icons.search_outlined),)

              ),
              onChanged: (v){
                pencarian = v;
              },
            )
        );
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
                    awal = FormEdit(listData[index]);
                  });
                },
                child: Row(children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 11, color: Colors.black), ),
                      width: 50,
                      padding: EdgeInsets.all(15),
                      //color: Colors.lightBlue,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listData[index]['judul'],
                              style: TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.ellipsis),),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['lingkup_data'] == null ? 'Instansi Tidak Ditemukan' : listData[index]['lingkup_data']['nama'],
                                style: TextStyle(color: Colors.black38, fontSize: 10,overflow: TextOverflow.ellipsis),),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(),
                          //color: Colors.black12
                        )
                    ),
                  ),
                  Expanded(child: Container(child: Text(listData[index]['tanggal'].toString().split("-")[0]),))
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
        getList();
      });
    });
  }

}

