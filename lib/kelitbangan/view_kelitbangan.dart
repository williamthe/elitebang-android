import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class ViewKelitbangan extends StatefulWidget{
  Map myData = {};
  ViewKelitbangan(listData){
    this.myData = listData;
  }

  _ViewKelitbangan createState() => _ViewKelitbangan(myData);

}

class _ViewKelitbangan extends State<ViewKelitbangan>{
  Map myData = {};
  String pelaksana = '';
  _ViewKelitbangan(Map myData){
    this.myData = myData;
    if(myData['pelaksana'] == null){
      this.pelaksana =  '-';
    }else{
      for (var age in myData['pelaksana']) {
        this.pelaksana += age['nama']+"\n";
      }
    }
    this.myData['pelaksana'] = this.pelaksana;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(

          appBar: AppBar(title: Text(myData['judul'],style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white60,
            shadowColor: Colors.white60,
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            },icon: Icon(Icons.arrow_circle_left, color: Colors.blueAccent,),),
          ),
          body: ViewData(myData,pelaksana)
        )
    );
  }


  myListData(listData){
    return ListView.separated(itemBuilder: (context,index){

      return Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          selectedTileColor: Colors.blue,
          leading: CircleAvatar(
            child: Text((index+1).toString()),
            //backgroundColor: Colors.transparent,
            //foregroundColor: Colors.blue,

          ),
          title: Text(listData[index]['judul'].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,),
          ),
          subtitle: Text(listData[index]['abstrak'].toString()),
          trailing: Column(
            children: [
            ],
          ),
          onTap: (){
            //showLitbang(listData[index]);
          },
          style: ListTileStyle.drawer,

        ),
      );
    },
      separatorBuilder: (context, index) => SizedBox(height: 3,),
      itemCount:listData.length,
    );;
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
      Uri.https('api-litbang.btx.co.id', 'api/kelitbangan/delete'),
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
  late BuildContext hapus;
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
                                Text("Judul", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['judul'])),
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
                                Text("Abstrak",style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: SingleChildScrollView(
                                      child: Text(data['abstrak']),
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
                                Text("Lingkup", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                  padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['lingkup_data'] == null ? "Instansi Tidak Ditemukan": data['lingkup_data']['nama'])),
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
                                Text("Tindak Lanjut", style: TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    child: Text(data['tindak_lanjut'] == null ? 'Tidak Ada' : data['tindak_lanjut'])),
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
                                height: 10,
                                ),
                                //Text(data['attachment'].toString())
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 150,
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                      children: List.generate(data['attachment'].length, (index) => TextButton(
                          onPressed: (){
                            String url_file = data['attachment'][index]['url'].toString().split("//")[1];
                            launchUrlString("https://litbang.btx.co.id/${url_file}",mode: LaunchMode.externalApplication);
                          },
                          child: Container(
                            height: 20,
                              child: Text(data['attachment'][index]['nama'].toString())))),
                    ),
                  )
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
                  showDialog(context: context, builder: (BuildContext del) {
                    hapus = del;
                    return AlertDialog(
                      title: Text('Hapus Data?'),
                      actions: [
                        TextButton(onPressed: (){
                          deleteData(data['id']);
                          Navigator.pop(del);

                        }, child: Text('Ya')),
                        TextButton(onPressed: (){
                          Navigator.pop(del);
                        }, child: Text('Batal'))
                      ],
                    );
                  },);
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

  Future<void> deleteData(id) async {
    var _mytoken = await SessionManager().get('_token');
    showDialog(context: hapus, builder: (BuildContext hps){
      hapus = hps;
      return AlertDialog(
        title: Row(
          children: [
            Text( 'Menghapus Data...' ),
            new CircularProgressIndicator()
          ],
        ),
      );
    });
    await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/kelitbangan/delete'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
      },
    ).then((value){
      Navigator.of(hapus).pop();
      var dec = jsonDecode(value.body);

      if(dec['status'] == true){
        showDialog(context: hapus, builder: (hapus){
          return AlertDialog(
            title: Text('Berhasil!'),
            content: Text(dec['message']),
          );
        });
      }
      else{
        showDialog(context: hapus, builder: (hapus){
          return AlertDialog(
            title: Text('Gagal!'),
            content: Text(dec['message']),
          );
        });
      }
    } );

  }
}

