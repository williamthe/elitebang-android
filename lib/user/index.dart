import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_litbang/myenv.dart';

import 'akses.dart';
import 'edit.dart';
import 'tambah.dart';

class IndexUser extends StatefulWidget{
  @override
  _IndexUser createState() => _IndexUser();
}

class _IndexUser extends State<IndexUser>{
  List listData = [];
  late BuildContext simpan;
  bool _lights = false;

  Widget myList = Center(
    child: Center(child: new CircularProgressIndicator()),
  );
  Widget awal = Text('');

  late BuildContext ex;
  MyEnvironments env = new MyEnvironments();

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: env.myFont),
        home: DefaultTabController(
          child: (
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
                          Icon(Icons.list,size: 30,),
                          Expanded(
                            child: Container(
                              child: Text('User',
                                style: TextStyle(fontSize: 17,

                                ),
                              ),
                              padding: EdgeInsetsDirectional.only(start: 8),),
                          ),
                        ],
                      ),
                      color: CupertinoColors.white,
                    ),
                    Container(
                      //color : Colors.black,
                      height: (contentHeight *0.82),
                      //padding: EdgeInsetsDirectional.only(top: 10),
                      child: TabBarView(
                          children: [
                            Column(
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
                          ]),
                    ),

                    //NavigationDestination(icon: icon, label: label,),
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
                            awal = FormTambah();
                          });;
                        }

                      },
                    ),
                  ],
                ),
              )),
          length: 1,
        )
    );
  }

  getList() async {
    showDialog(context: context, builder: (BuildContext cc) {
      ex = cc;
      return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    },);
    String _token = await SessionManager().get('_token');
    var response = await http.get(
      Uri.https('api-litbang.btx.co.id', 'api/pengguna/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer ${_token}'
      },

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
                    awal = FormEdit(listData[index]);
                  });
                },
                child: Row(children: [
                  Expanded(
                    flex: 3,
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
                    flex:11,
                    child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(listData[index]['email'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),),
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.all(3),
                              child: Text(listData[index]['full_name'] == null ? '-' : listData[index]['full_name'],
                                style: TextStyle(color: Colors.black38, fontSize: 11, ),),
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
                            IconButton(onPressed: (){
                              editAkses(listData[index]['id']);
                            }, icon: Icon(Icons.supervised_user_circle_rounded, color: Colors.black87,))
                          ],
                        ),
                      )
                  )
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

  Future<void> editAkses(id) async {
    showDialog(context: context, builder: (BuildContext upd){
      simpan = upd;
      return AlertDialog(
        title: Column(
          children: [
            Text( 'Mengambil Data...', style: TextStyle() ),
            Center(child: new CircularProgressIndicator()),
          ],
        ),
      );
    });

    var _mytoken = await SessionManager().get('_token');

    var response = await http.post(
      Uri.https('api-litbang.btx.co.id', 'api/pengguna/android-get'),
      headers: {
        'Authorization': 'Bearer ${_mytoken.toString()}'
      },
      body: {
        'user_id' : id.toString(),
      },
    ).then((value){
      var dec = jsonDecode(value.body);

      Navigator.of(simpan).pop();
      if(dec['status'] == true){
        List aksess = dec['data'].map((menu) => menu['menu_akses']).toList();
        print(aksess);
        Map saya = {
          'nama' : 'saya',
          'id' : id,
          'akses' : aksess
        };
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AksesUser(saya);
        },));
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Tidak Ditemukan!'),
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
        getList();
      });
    });
  }

}

