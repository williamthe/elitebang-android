import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';
import 'package:prototype_litbang/sidenav.dart';
import 'edit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IndexBerita extends StatefulWidget{
  @override
  _IndexBerita createState() => _IndexBerita();
}

class _IndexBerita extends State<IndexBerita>{
  List listData = [];

  late BuildContext simpan;

  Widget myList = Center(
    child: Text('Loading Data...'),
  );
  Widget awal = Text('');

  late BuildContext ex;
  MyEnvironments env = new MyEnvironments();
  late BuildContext updel;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: env.myFont
        ),
        home: (
            Scaffold(
              resizeToAvoidBottomInset : false,
              body: Column(
                children: [
                  Container(height: (contentHeight *0.13),
                    padding: EdgeInsetsDirectional.only(top: 30),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(width: 40,),
                        IconButton(icon:Icon(Icons.list,size: 30,), onPressed: (){

                        },),
                        Expanded(
                          child: Container(
                            child: Text('Berita',
                            style: TextStyle(fontSize: 17,

                            ),
                          ),
                            padding: EdgeInsetsDirectional.only(start: 8),),
                        ),
                      ],
                    ),
                    color: CupertinoColors.white,),
                  Container(
                    //color : Colors.black,
                    height: (contentHeight *0.82),
                    //padding: EdgeInsetsDirectional.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                                height: (contentHeight * 0.8),
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
                         // awal = FormBaru();
                        });;
                      }

                    },
                  ),
                ],
              ),
            ))
    );
  }



  getList() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    var response = await http.get(
      Uri.https(env.apiUrl, 'api/berita/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
      },

    ).then((value) {
      // setState(){
      var listData = jsonDecode(value.body)['data'];
      setState(() {
        myList = ListView.separated(itemBuilder: (context,index){
          return Container(
              padding: EdgeInsetsDirectional.all(10),
              height: 125,
              decoration: BoxDecoration(
                // border: BorderDirectional(),
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white
              ),
              child:
              TextButton(
                onPressed: (){
                  // setState(() {
                  //   awal = FormEdit(listData[index]);
                  // });
                },
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index+1).toString(), style: TextStyle(fontSize: 12, color: Colors.black), ),
                      width: 60,
                      padding: EdgeInsets.all(15),
                      //color: Colors.lightBlue,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                    ),
                  ),
                  Expanded(
                    flex:11,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(listData[index]['judul'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                ),),
                            ),
                            Row(

                              children: [
                              IconButton(onPressed: (){
                                launchUrlString('${env.webUrl}/view-berita/${listData[index]['id']}',
                                  mode: LaunchMode.externalApplication,
                                );
                              }, icon: Icon(Icons.next_plan, color: Colors.black87,)),
                              IconButton(onPressed: (){
                                delete(listData[index]['id']);
                              }, icon: Icon(Icons.delete_forever, color: Colors.black87,))
                            ],
                            )
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
      });
    }).whenComplete(( ) {
      setState(() {});
      Navigator.of(ex).pop();
    });

  }

  Future<void> delete(id) async {

    showDialog(context: context, builder: (BuildContext upd){
      updel = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Menghapus Data...',),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    var response = await http.post(
      Uri.https(env.apiUrl, 'api/kelitbangan/delete'),
      headers: {
        //'Content-Type' : 'aplication/json;',
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'id' : id.toString(),
      },
    ).then((value){
      var dec = jsonDecode(value.body);
      Navigator.of(updel).pop();
      if(dec['status'] == true){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Berhasil!'),
            content: Text(dec['message']),
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

  confirmDelete(id){
    showDialog(context: context, builder: (BuildContext conf){
      updel = conf;
      return AlertDialog(
        title: Text( 'Akan Menghapus Data?' ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
            delete(id);
          },
              child: Text('Ya',
              )),
          TextButton(onPressed: (){
            Navigator.of(updel).pop();
          },
              child: Text('Batal',
              )),
        ],
      );
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

