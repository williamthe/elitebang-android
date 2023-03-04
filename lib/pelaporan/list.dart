
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_litbang/myenv.dart';
import 'package:prototype_litbang/pelaporan/inovasi.dart';
import 'package:prototype_litbang/pelaporan/login.dart';
import 'package:prototype_litbang/user_menu.dart';
import 'package:http/http.dart' as http;

class ListPelaporan extends StatefulWidget{
  _ListPelaporan createState() => _ListPelaporan();

}

class _ListPelaporan extends State<ListPelaporan>{
  MyEnvironments env = new MyEnvironments();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: env.myFont),
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            backgroundColor: Color.fromRGBO(12, 12, 220, 100),
            //endDrawer: Icon(Icons.arrow_left, color: Colors.black, size: 50,),
            body:MylistData()
        )
    );
  }

}

class MylistData extends StatefulWidget{

  @override
  State<MylistData> createState() => _MylistDataState();
}

class _MylistDataState extends State<MylistData> {
  TextStyle menuText = TextStyle(

      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87
  );
  TextStyle subText = TextStyle(

      fontSize: 12,
      color: Colors.black87
  );
  TextStyle waktu = TextStyle(

      fontSize: 11,
      color: Colors.black87
  );

  Color menuColor = Colors.white;
  double menuIconSize = 33;
  Color menuIconColor = Colors.black;

  List<Widget> listData = [];
  late BuildContext ref;

  @override
  Widget build(BuildContext context) {
    final myBodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top ;

    Container(
      padding: EdgeInsetsDirectional.all(15),
      child: Column(
        children: [
          Container(height: myBodyHeight * 0.02,),
          Container(
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadiusDirectional.circular(10)
            ),
            padding: EdgeInsetsDirectional.only(top: 5,bottom: 5),
            //color: Colors.blue,
            height: myBodyHeight * 0.07,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(icon:Icon(Icons.grid_view_sharp), onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return UserMenu();
                    },));
                  },
                    tooltip: 'Ke User Menu',),
                ),
                Expanded(
                  flex: 7,
                  child: Container(padding: EdgeInsetsDirectional.only(start: 10),
                      child: Text('Pelaporan', )),
                ),
                // Expanded(
                //   flex: 1,
                //   child: IconButton(icon:Icon(Icons.refresh), onPressed: (){
                //     getList();
                //   },
                //     tooltip: 'Refresh Data',),
                // ),
              ],
            ),

          ),
          Container(height: myBodyHeight * 0.01,),
          Container(
            height: myBodyHeight * 0.85,
            child: ListView(
              children: [
                Column(
                    children: [
                      Container(
                          child: Column(children: listData,)
                      )
                    ]),

              ],
            ),
          ),
        ],
      ),
    );
    
    return Container(
      height: myBodyHeight,
      decoration: BoxDecoration(),
      child: Column(children: [
        Container(
          height: myBodyHeight * 0.1,
          child: IconButton(icon: Icon(Icons.arrow_circle_left,
            size: myBodyHeight *0.1 * 0.4,
            color: CupertinoColors.white,
          ),onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              return UserMenu();
            },));
          },),
          alignment: Alignment.bottomLeft,
        ),
        Container(
          height: myBodyHeight * 0.3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book,color: CupertinoColors.white, size: myBodyHeight* 0.3 * 0.4,),
                Text('Pelaporan',
                  style: TextStyle(
                      color: CupertinoColors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: myBodyHeight * 0.6,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadiusDirectional.circular(20)
          ),
          padding: EdgeInsetsDirectional.all(25),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex:1,
                  child: Container(

                    child: Text('Pilihan Pelaporan :',
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                        //color: Colors.amber
                      ),),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return Login('inovasi');
                            },));
                          },
                          child: Container(
                            height: myBodyHeight *0.6 * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.lightBlue),
                                borderRadius: BorderRadiusDirectional.circular(20),
                                color: Colors.greenAccent
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.person_pin_circle,
                                  size: myBodyHeight *0.6 * 0.17,
                                  color: Colors.white,),
                                TextButton(
                                  child: Text('Inovasi',
                                      style: TextStyle(fontSize: 18, color: Colors.white)),
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return Login('inovasi');
                                    },));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Expanded(
                        flex:7,
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return Login('penelitian');
                            },));
                          },
                          child: Container(
                            height: myBodyHeight *0.6 * 0.40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.lightBlue),
                               borderRadius: BorderRadiusDirectional.circular(20),
                               color: Colors.blueAccent
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.person_search_sharp,
                                  size: myBodyHeight *0.6 * 0.17,
                                  color: Colors.white,),
                                TextButton(
                                  child: Text('Penelitian',
                                      style: TextStyle(fontSize: 18, color: Colors.white)),
                                  onPressed: (){},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],),
    );
  }

  getList() async {
    // showDialog(context: context, builder: (BuildContext bc) {
    //   ref = bc;
    //   return AlertDialog(title: Center(child: new CircularProgressIndicator()),);
    // },);
    await http.get(
      Uri.https('api-litbang.btx.co.id', 'api/agenda/list'),
      headers: {
        'Content-Type' : 'aplication/json; charset=UTF-8',
      },
    ).then((value) {

      var listDataSrc = jsonDecode(value.body)['data'];
      listDataSrc = [
        {
        'nama' : 'Inovasi',
        'navigasi' : LaporanInovasi(),
        },
        {
          'nama' : 'Penelitian',
          'navigasi' : Login('penelitian'),
        },
      ];
      setState((){
        this.listData = List.generate(listDataSrc.length, (index) => Column(
          children:[
            Container(
              decoration: BoxDecoration(
                color: menuColor,
                borderRadius: BorderRadiusDirectional.circular(15),
                border: Border.all( color: CupertinoColors.white),
              ),
              padding: EdgeInsetsDirectional.all(10),
              //color: Colors.blue,
              height: 100,
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return listDataSrc[index]['navigasi'];
                  },));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(listDataSrc[index]['nama'] == null ? '' : listDataSrc[index]['nama'],
                              style: menuText, ),
                            padding: EdgeInsetsDirectional.all(5),
                          ),
                          // Text(listDataSrc[index]['tempat'] == null ? '' : listDataSrc[index]['tempat'],
                          //   style: subText, ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                        ],)),
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10,),],
        ) );
      });
      
      // Navigator.of(referesh).pop();
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



