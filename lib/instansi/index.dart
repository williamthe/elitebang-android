import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

import 'edit.dart';
import 'tambah.dart';
import '../myenv.dart';

class IndexInstansi extends StatefulWidget{
  @override
  _IndexInstansi createState() => _IndexInstansi();
}

class _IndexInstansi extends State<IndexInstansi>{
  List listData = [];
  MyEnvironments env = new MyEnvironments();

  late BuildContext simpan;

  Widget myList = Center(
    child: Center(child: new CircularProgressIndicator()),
  );
  Widget awal = Text('');

  late BuildContext ex;

  @override
  Widget build(BuildContext context) {
    final contentHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 7;
    return MaterialApp(
      theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
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
                              child: Text('Instansi',
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
                          });
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
    var response = await http.get(
      Uri.https(env.apiUrl, 'api/instansi/list'),
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
                    awal = FormEdit(listData[index]);
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
                              child: Text(listData[index]['nama'],
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

