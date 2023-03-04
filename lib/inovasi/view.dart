import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:prototype_litbang/Inovasi/edit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import '../myenv.dart';


class ViewInovasi extends StatefulWidget{
  Map myData = {};
  String pelaksana = '';
  ViewInovasi(listData){
    this.myData = listData;
    if(myData['pelaksana'] == null){
      this.pelaksana =  '-';
    }else{
      for (var age in myData['pelaksana']) {
        this.pelaksana += age['nama']+"\n";
      }
    }
    this.myData['str_pelaksana'] = this.pelaksana;
  }

  _ViewInovasi createState() => _ViewInovasi(myData);

}

class _ViewInovasi extends State<ViewInovasi>{
  MyEnvironments env = new MyEnvironments();
  Map myData = {};
  String pelaksana = '';
  _ViewInovasi(Map myData){
    this.myData = myData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(title: Text(myData['nama'],),
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            },icon: Icon(Icons.arrow_circle_left),),
          ),
          body: ViewData(myData,pelaksana)
        )
    );
  }

  Future<void> deleteData(id) async {
    var _mytoken = await SessionManager().get('_token');
    Navigator.of(context).pop();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text( 'Silahkan Tunggu...' ),
        content: Text(""),
      );
    });
    print('mulai');
    var response = await http.post(
      Uri.https(env.apiUrl, 'api/inovasi/delete'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(context).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Data Berhasil Terhapus!'),
            content: Text(""),
          );
        }).then((value) => Navigator.of(context).pop());
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Data Gagal Terhapus!'),
            content: Text(dec['message']),
          );
        }).then((value) => Navigator.of(context).pop());
      }

    } );

  }

}

class ViewData extends StatelessWidget{
  Map data = {};
  String pelaksana = '';
  ViewData(Map data,String pelaksana){
    this.data = data;
    this.pelaksana = pelaksana;
  }
  @override
  Widget build(BuildContext context) {
    return
      Column(children: [
        Container(
          padding: EdgeInsetsDirectional.all(15),
          height: (MediaQuery.of(context).size.height - 25 - MediaQuery.of(context).padding.top - AppBar().preferredSize.height) * 0.9,
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nomor", style: TextStyle(fontWeight: FontWeight.bold),),
                                Container(
                                    padding: EdgeInsetsDirectional.all(10),
                                    child: Text(data['nomor'])),
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 10,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tanggal",style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['tanggal'])),
                              ]),

                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['nama'])),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tujuan",style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: SingleChildScrollView(
                                      child: Text(data['tujuan']),
                                      scrollDirection: Axis.vertical,
                                    )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Manfaat", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['manfaat'])),
                              ]),
                        ),
                      )
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hasil", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['hasil'] == null ? 'Tidak Ada' : data['hasil'])),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['deskripsi'] == null ? 'Tidak Ada' : data['deskripsi'])),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pelaksana", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  child: Text(pelaksana),)
                                //Text(data['pelaksana'].toString()),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            // border: BorderDirectional(),
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.white
                          ),
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dokumen", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(padding: EdgeInsetsDirectional.all(5),
                                  height: 20,)
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          height: (MediaQuery.of(context).size.height - 50  - MediaQuery.of(context).padding.top - AppBar().preferredSize.height) * 0.1,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsetsDirectional.all(3),
                decoration:
                BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  //     //
                ),
                height: 45,
                width: 75,

                child: TextButton(onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  //   return EditInovasi(data);
                  // },));
                },
                  child: Row(
                    children: [
                      //     //
                      Icon(Icons.edit,color: Colors.white,size: 14,),
                      SizedBox(width: 5,),
                      Text('edit', style: TextStyle(color: Colors.white,fontSize: 15)),
                    ],
                  ), ),
              ),
              Container(width: 15,),
              Container(
                padding: EdgeInsetsDirectional.all(3),
                decoration:
                BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                  //     //
                ),
                height: 45,
                width: 85,

                child: TextButton(onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  //   return EditInovasi(data);
                  // },));
                },
                  child: Row(
                    children: [
                      //     //
                      Icon(Icons.delete,color: Colors.white,size: 15,),
                      SizedBox(width: 5,),
                      Text('delete', style: TextStyle(color: Colors.white,fontSize: 15)),
                    ],
                  ), ),
              ),
            ],
          ),
        )

      ],);
  }
}

